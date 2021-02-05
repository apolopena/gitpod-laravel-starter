#!/bin/bash
#printf "\033c"

# Load spinner
. bash/third-party/spinner.sh

# Bootstrap scaffolding
if [ ! -d "$GITPOD_REPO_ROOT/bootstrap" ]; then
  echo "Results of building the workspace image ➥"
  cat /var/log/workspace-image.log
  # Todo replacespinner with a real progrees bar for coreutils
  start_spinner "Moving Laravel project from ~/temp-app to $GITPOD_REPO_ROOT "
  shopt -s dotglob
  mv --no-clobber ~/test-app/* $GITPOD_REPO_ROOT
  RESULT=$?
  if [ $RESULT != 0 ]; then
    stop_spinner $RESULT
    >&2 echo "ERROR: Failed to move Laravel project from ~/temp-app to $GITPOD_REPO_ROOT"
  else
    stop_spinner $RESULT
    #echo "SUCCESS: moved Laravel project from ~/temp-app to $GITPOD_REPO_ROOT"
  fi
  # BEGIN: Optional configurations
  # Super user account for phpmyadmin
  installed_phpmyadmin=$(. /tmp/utils.sh parse_ini_value /tmp/starter.ini phpmyadmin install)
  if [ "$installed_phpmyadmin" == 1 ]; then
    start_spinner "Creating phpmyadmin superuser: pmasu  "
    mysql -e "CREATE USER 'pmasu'@'%' IDENTIFIED BY '123456';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'pmasu'@'%';"
    RESULT=$?
    if [ $RESULT != 0 ]; then
      stop_spinner $RESULT
      >&2 echo "ERROR: failed to create phpmyadmin superuser: pmasu"
    else
      stop_spinner $RESULT
      #echo "SUCCESS: created phpmyadmin superuser: pmasu"
    fi
  fi
  # Install https://github.com/github-changelog-generator/github-changelog-generator
  installed_changelog_gen=$(bash bash/utils.sh parse_ini_value starter.ini github-changelog-generator install)
  if [ "$installed_changelog_gen" == 1 ]; then
    start_spinner "Installing github-changelog-generator  " &&
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
# Some rake tasks are dynamic and conditional depending on the configuration in starter.ini
bash bash/init-rake-tasks.sh

# Aliases for .bash_profile
# Aliases for git
start_spinner "Writing git aliases " &&
bash bash/utils.sh add_file_to_file_after \\[alias\\] bash/snippets/emoji-log ~/.gitconfig &&
bash bash/utils.sh add_file_to_file_after \\[alias\\] bash/snippets/git-aliases ~/.gitconfig &&
stop_spinner $?
#echo "Writing git aliases complete, check the log for any possible errors."
echo "try: git a    or: git aliases    for a list your git aliases."
[ "$installed_changelog_gen" == 1 ] && 
echo "You may auto generate a CHANGELOG from github commits by running the command: rake changelog [options]" &&
echo "See starter.ini (github_changelog_generator section). for configurable options" &&
echo "For a full list of options see https://github.com/github-changelog-generator/github-changelog-generator"
echo -e "\nALL DONE: If the above results are successful then make sure to add, commit and push the changes to your git repository."
