#!/bin/bash

# Log to the console and a file
log () {
  if [ -z "$2" ]; then
    bash bash/utils.sh log "$1" /var/log/workspace-init.log
  else
    bash bash/utils.sh log "$1" /var/log/workspace-init.log -e
  fi
}

# Log only to a file
log_silent () {
  if [ -z "$2" ]; then
    bash bash/utils.sh log_silent "$1" /var/log/workspace-init.log
  else
    bash bash/utils.sh log_silent "$1" /var/log/workspace-init.log -e
  fi
}

# Load spinner
. bash/third-party/spinner.sh

# Let the user know there will a wait, then begin once MySql is initialized.
start_spinner "Initializing MySql..." &&
gp await-port 3306 &&
stop_spinner $?

# Bootstrap scaffolding
if [ ! -d "$GITPOD_REPO_ROOT/bootstrap" ]; then
  msg="\nMoving Laravel project from ~/temp-app to $GITPOD_REPO_ROOT"
  # TODO: replace spinner with a real progress bar for coreutils
  log_silent "$msg" && start_spinner "$msg"
  shopt -s dotglob
  mv --no-clobber ~/test-app/* $GITPOD_REPO_ROOT
  err_code=$?
  if [ $err_code != 0 ]; then
    stop_spinner $err_code
    log "ERROR: Failed to move Laravel project from ~/temp-app to $GITPOD_REPO_ROOT" -e
  else
    stop_spinner $err_code
    log "SUCCESS: moved Laravel project from ~/temp-app to $GITPOD_REPO_ROOT"
  fi
  
  # BEGIN: parse configurations

  # Configure .editorconfig
  if [ -e .editorconfig ]; then 
    ec_type=$(bash bash/utils.sh parse_ini_value starter.ini .editorconfig type)
    case $(echo "$ec_type" | tr '[:upper:]' '[:lower:]') in
      'laravel-js-2space')
        cp bash/snippets/editorconfig/laravel-js-2space .editorconfig
      ;;
      'none')
        rm .editorconfig
      ;;
      *)
        #Ignore invalid types
      ;;
    esac
  fi
  
  # Laravel .env 
  [ -e .env ] && url=$(gp url 8000); sed -i'' "s#^APP_URL=http://localhost*#APP_URL=$url\nASSET_URL=$url#g" .env
  # END: parse configurations

  # BEGIN: Optional configurations
  # Super user account for phpmyadmin
  installed_phpmyadmin=$(. bash/utils.sh parse_ini_value starter.ini phpmyadmin install)
  if [ "$installed_phpmyadmin" == 1 ]; then
    msg="Creating phpmyadmin superuser: pmasu"
    log_silent "$msg" && start_spinner "$msg" 
    mysql -e "CREATE USER 'pmasu'@'%' IDENTIFIED BY '123456';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'pmasu'@'%';"
    err_code=$?
    if [ $err_code != 0 ]; then
      stop_spinner $err_code
      log "ERROR: failed to create phpmyadmin superuser: pmasu" -e
    else
      stop_spinner $err_code
    fi
  fi
  # Install https://github.com/github-changelog-generator/github-changelog-generator
  installed_changelog_gen=$(bash bash/utils.sh parse_ini_value starter.ini github-changelog-generator install)
  if [ "$installed_changelog_gen" == 1 ]; then
    msg="Installing github-changelog-generator"
    log_silent "$msg" && start_spinner "$msg" &&
    gem install github_changelog_generator --no-document --silent &&
    stop_spinner $?
  fi
  # END: Optional configurations

  # Move and or merge necessary failes then cleanup
  (echo; cat ~/test-app/.gitignore) >> $GITPOD_REPO_ROOT/.gitignore && rm ~/test-app/.gitignore
  mv ~/test-app/README.md $GITPOD_REPO_ROOT/README_LARAVEL.md
  rmdir ~/test-app
fi

# Messages for github_changelog_generator
[ "$installed_changelog_gen" == 1 ] && 
log "You may auto generate a CHANGELOG.md from github commits by running the command:\nrake changelog [...options]\n" &&
log "See starter.ini (github_changelog_generator section) for configurable options" &&
log "For a full list of options see the github-changelog-generator repository on github"