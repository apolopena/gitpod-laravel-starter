#!/bin/bash

log_path=/var/log/workspace-init.log

log () {
  local cmd
  [[ "$2" == '-e' || "$2" == '--error' ]] && cmd=(>&2 echo -e "$1") || cmd=(echo -e "$1")
  eval "${cmd[@]}" | tee -a $log_path
}

log_silent () {
  local cmd
  [[ "$2" == '-e' || "$2" == '--error' ]] && cmd='>&2 echo -e "$1"' || cmd='echo -e "$1"'
  eval "$cmd"
}
# Load spinner
. bash/third-party/spinner.sh

# Bootstrap scaffolding
if [ ! -d "$GITPOD_REPO_ROOT/bootstrap" ]; then
  echo "Results of building the workspace image ➥"
  cat /var/log/workspace-image.log
  # Todo replacespinner with a real progress bar for coreutils
  msg="\nMoving Laravel project from ~/temp-app to $GITPOD_REPO_ROOT"
  log_silent $msg && start_spinner $msg
  shopt -s dotglob
  mv --no-clobber ~/test-app/* $GITPOD_REPO_ROOT
  err_code=$?
  err_code=1 #temp for testing
  if [ $err_code != 0 ]; then
    stop_spinner $err_code
    log "ERROR: Failed to move Laravel project from ~/temp-app to $GITPOD_REPO_ROOT" -e
  else
    stop_spinner $err_code
    #echo "SUCCESS: moved Laravel project from ~/temp-app to $GITPOD_REPO_ROOT"
  fi
  # BEGIN: Optional configurations
  # Super user account for phpmyadmin
  installed_phpmyadmin=$(. /tmp/utils.sh parse_ini_value /tmp/starter.ini phpmyadmin install)
  if [ "$installed_phpmyadmin" == 1 ]; then
    start_spinner "Creating phpmyadmin superuser: pmasu"
    mysql -e "CREATE USER 'pmasu'@'%' IDENTIFIED BY '123456';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'pmasu'@'%';"
    err_code=$?
    if [ $err_code != 0 ]; then
      stop_spinner $err_code
      >&2 echo "ERROR: failed to create phpmyadmin superuser: pmasu"
    else
      stop_spinner $err_code
    fi
  fi
  # Install https://github.com/github-changelog-generator/github-changelog-generator
  installed_changelog_gen=$(bash bash/utils.sh parse_ini_value starter.ini github-changelog-generator install)
  if [ "$installed_changelog_gen" == 1 ]; then
    start_spinner "Installing github-changelog-generator" &&
    gem install github_changelog_generator --no-document --silent &&
    stop_spinner $?
  fi
  # END: Optional configurations

  # Move and or merge necessary failes then cleanup
  (echo; cat ~/test-app/.gitignore) >> $GITPOD_REPO_ROOT/.gitignore && rm ~/test-app/.gitignore
  mv ~/test-app/README.md $GITPOD_REPO_ROOT/README_LARAVEL.md
  rmdir ~/test-app
fi

# Rake tasks (will be written to ~/.rake).
# Some rake tasks are dynamic and depend on the configuration in starter.ini
bash bash/init-rake-tasks.sh

# Aliases for git
start_spinner "Writing git aliases " &&
bash bash/utils.sh add_file_to_file_after \\[alias\\] bash/snippets/emoji-log ~/.gitconfig &&
bash bash/utils.sh add_file_to_file_after \\[alias\\] bash/snippets/git-aliases ~/.gitconfig &&
stop_spinner $?
echo "try: git a    or: git aliases    for a list your git aliases.\n"

# Messages for github_changelog_generator
[ "$installed_changelog_gen" == 1 ] && 
echo -e "You may auto generate a CHANGELOG.md from github commits by running the command:\nrake changelog [...options]\n" &&
echo "See starter.ini (github_changelog_generator section) for configurable options" &&
echo "For a full list of options see the github-changelog-generator repository on github"

# Init complete message
echo -e "\nALL DONE\nIf the above results are successful then make sure to add, commit and push the changes to your git repository."
