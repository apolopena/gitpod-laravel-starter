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

# BEGIN: Bootstrap Laravel scaffolding

# Move Laravel project files if they are not already in version control
if [ ! -d "$GITPOD_REPO_ROOT/vendor" ]; then
  msg="\nrsync Laravel project from ~/temp-app to $GITPOD_REPO_ROOT"
  # TODO: replace spinner with a real progress bar for coreutils
  #log_silent "$msg..." && start_spinner "$msg..."
  shopt -s dotglob
  rsync -rlptgoDP --ignore-existing --info=name0 ~/test-app/ $GITPOD_REPO_ROOT | xargs -L1 printf "\33[2K\rTransferring: %s"
  err_code=$?
  if [ $err_code != 0 ]; then
    #stop_spinner $err_code
    log "ERROR: Failed to rsync Laravel project from ~/temp-app to $GITPOD_REPO_ROOT" -e
  else
    #stop_spinner $err_code
    log "SUCCESS: rsync Laravel project from ~/temp-app to $GITPOD_REPO_ROOT"
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

  # Create laravel database if it does not exist
  # TODO: think more about making this dynamic as per .env
  __laravel_db_exists=$(mysqlshow  2>/dev/null | grep laravel >/dev/null 2>&1 && echo "1" || echo "0")
  if [ $__laravel_db_exists == 0 ]; then
    __laravel_db_msg="laravel database did not exist in mysql. Creating database: laravel"
    log_silent "$__laravel_db_msg..." && start_spinner "$__laravel_db_msg..."
    mysql -e "CREATE DATABASE laravel;"
    err_code=$?
    if [ $err_code != 0 ]; then
      stop_spinner $err_code
      log "ERROR: Failed to move create mysql database: laravel" -e
    else
      stop_spinner $err_code
      log "SUCCESS: created mysql database: laravel"
    fi
  fi
  # Install node packages if needed, in case the Laravel Ui front end is already in version control
  if [[ -f "package.json"  && ! -d "node_modules" ]]; then
    log "Found a package.json but there are no node modules installed"
    log " --> Installing node packages..."
    yarn install
    log " --> Node packages installed"
    log " --> Running Laravel Mix..."
    yarn run dev
    log " --> Running of Laravel Mix complete"
  fi

  # BEGIN: Optional configurations
  # phpmyadmin config
  installed_phpmyadmin=$(. bash/utils.sh parse_ini_value starter.ini phpmyadmin install)
  if [ "$installed_phpmyadmin" == 1 ]; then
    if [ -e public/phpmyadmin/config.sample.inc.php ]; then
      msg="Creating public/phpmyadmin/config.inc.php"
      log_silent "$msg ..." && start_spinner "$msg ..."
      cp public/phpmyadmin/config.sample.inc.php public/phpmyadmin/config.inc.php
      err_code=$?
      if [ $err_code != 0 ]; then
        stop_spinner $err_code
        log "ERROR: Failed $msg" -e
      else
        stop_spinner $err_code
        log "SUCCESS: $msg"
      fi
      msg="Parsing public/phpmyadmin/config.inc.php"
      log_silent "$msg ..." && start_spinner "$msg ..."
      __bfs=$(bash bash/utils.sh generate_string 32)
      sed -i'' "s#\\$cfg['blowfish_secret'] = '';#\\$cfg['blowfish_secret'] = '$__bfs';#g" public/phpmyadmin/config.inc.php
      err_code=$?
      if [ $err_code != 0 ]; then
        stop_spinner $err_code
        log "ERROR: Failed $msg" -e
      else
        stop_spinner $err_code
        log "SUCCESS: $msg"
      fi
    fi
    # phpmyadmin db
    mysql -e "CREATE DATABASE phpmyadmin;"
    err_code=$?
    if [ $err_code != 0 ]; then
      log "ERROR: Failed to move created mysql database: phpmyadmin" -e
    else
      log "SUCCESS: created mysql database: phpmyadmin"
    fi
    # Super user account for phpmyadmin
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
    if [ ! -d 'public/phpmyadmin/node_modules' ]; then
      log "phpmyadmin node modules have not yet been installed, installing now..."
      cd public/phpmyadmin && yarn install && cd ../../
      if [ $? == 0 ]; then
        __pmaurl=$(gp url 8001)/phpmyadmin
        log "phpmyadmin node modules installed."
        log "To login to phpmyadmin:"
        log "  --> 1. Make sure you are serving it with apache"
        log "  --> 2. In the browser go to $__pmaurl"
        log "  --> 3. You should be able to login here using the default account. user: pmasu, pw: 123456"
      else
        log "ERROR: installing phpmyadmin node modules. Try installing them manually." -e
      fi
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

  # Move and merge necessary files, then cleanup
  mv ~/test-app/README.md $GITPOD_REPO_ROOT/README_LARAVEL.md
  rm -rf ~/test-app
fi
# END: Bootstrap Laravel scaffolding

# Messages for github_changelog_generator
[ "$installed_changelog_gen" == 1 ] &&
log "You may auto generate a CHANGELOG.md from github commits by running the command:\nrake changelog [...options]\n" &&
log "See starter.ini (github_changelog_generator section) for configurable options" &&
log "For a full list of options see the github-changelog-generator repository on github"
