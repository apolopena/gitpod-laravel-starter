#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init-gitpod.sh
# Description:
# Tasks to be run when a gitpod workspace is created for the first time.

# Load logger
. bash/workspace-init-logger.sh

# Load spinner
. bash/spinner.sh

# Let the user know there will be a wait, then begin once MySql is initialized.
start_spinner "Initializing MySql..." &&
gp await-port 3306 &&
stop_spinner $?

# BEGIN: Update npm if needed
target_npm_ver='7.7.5'
current_npm_ver=$(npm -v)
update_npm=$(bash bash/utils.sh comp_ver_lt $current_npm_ver $target_npm_ver)
if [ $update_npm == 1 ]; then
  msg="Updating npm from $current_npm_ver to $target_npm_ver"
  log_silent "$msg" && start_spinner "$msg"
  npm install -g "npm@$target_npm_ver" &>/dev/null
  err_code=$?
  if [ $err_code != 0 ]; then
    stop_spinner $err_code
    log "ERROR $?: $msg" -e
  else
    stop_spinner $err_code
    log_silent "SUCCESS: $msg"
  fi
fi
# END: Update npm if needed

# BEGIN: install shellcheck
if [[ $(bash bash/utils.sh parse_ini_value starter.ini shellcheck install) == 1 ]]; then
  msg="Installing shellcheck"
  if npm install -g shellcheck --silent; then
    log_silent "SUCCESS: $msg $(shellcheck -V | grep version:)"
  else
    log "ERROR: $msg"
  fi
fi
# END: install shellcheck

# BEGIN: Bootstrap Laravel scaffolding

# Move Laravel project files if they are not already in version control
if [ ! -d "$GITPOD_REPO_ROOT/vendor" ]; then
  msg="rsync Laravel 8 scaffolding from ~/laravel8-starter to $GITPOD_REPO_ROOT"
  log_silent "$msg" && start_spinner "$msg"
  shopt -s dotglob
  grc -c bash/snippets/grc/rsync-stats \
  rsync -rlptgoD --ignore-existing --stats --human-readable /home/gitpod/laravel8-starter/ $GITPOD_REPO_ROOT
  err_code=$?
  if [ $err_code != 0 ]; then
    stop_spinner $err_code
    log "ERROR: $msg" -e
  else
    stop_spinner $err_code
    log_silent "SUCCESS: $msg"
  fi

  # Move LICENSE to the bash folder
  [[ -f "LICENSE" && -d "bash" ]] && mv -f LICENSE bash/LICENSE
  
  # Cleanup any cached phpmyadmin installation from the workspace image if needed
  if [ $(bash bash/utils.sh parse_ini_value starter.ini phpmyadmin install) == 0 ]; then
    [ -d "public/phpmyadmin" ] && rm -rf public/phpmyadmin
  fi

  # BEGIN: parse configurations

  # BEGIN Laravel .env injection
  if [ -e .env ]; then
    msg="Injecting Laravel .env file with APP_URL and ASSET_URL"
    start_spinner "$msg"
    default_server_port=$(bash bash/helpers.sh get_default_server_port)
    url=$(gp url $default_server_port)
    sed -i'' "s#^APP_URL=http://localhost*#APP_URL=$url\nASSET_URL=$url#g" .env
    err_code=$?
    if [ $err_code != 0 ]; then
      stop_spinner 1
      log "ERROR: Could not inject Larvel .env file with the url $url" -e
    else
      stop_spinner $err_code
      log_silent "SUCCESS: Laravel .env APP_URL and ASSET_URL was set to $url"
      log_silent "  You should check .env to make sure the values are set correctly."
      log_silent "  If you change the server then the port number will need to be"
      log_silent "  changed in .env for APP_URL and ASSET_URL"
    fi
  else
    log 'ERROR: no Laravel .env file to inject'
  fi
  # BEGIN Laravel .env injection
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
  # END: parse configurations

  # Create laravel database if it does not exist
  __laravel_db_exists=$(mysqlshow  2>/dev/null | grep laravel >/dev/null 2>&1 && echo "1" || echo "0")
  if [ $__laravel_db_exists == 0 ]; then
    msg="Creating database: laravel"
    log_silent "$msg" && start_spinner "$msg"
    mysql -e "CREATE DATABASE laravel;"
    err_code=$?
    if [ $err_code != 0 ]; then
      stop_spinner $err_code
      log "ERROR: $msg" -e
    else
      stop_spinner $err_code
      log_silent "SUCCESS: $msg"
    fi
  fi
  
  # BEGIN: Optional configurations
  # Install https://github.com/github-changelog-generator/github-changelog-generator
  installed_changelog_gen=$(bash bash/utils.sh parse_ini_value starter.ini github-changelog-generator install)
  if [ "$installed_changelog_gen" == 1 ]; then
    msg="Installing github-changelog-generator"
    log_silent "$msg" && start_spinner "$msg" &&
    gem install github_changelog_generator --no-document --silent &&
    stop_spinner $?
  fi
  # END: Optional configurations

  # Install node packages and run laravel mix blindly here since at this stage there is no viable
  # hook for when laravel/ui frontend scaffolding (react, vue or bootstrap) is in version control but the
  # workspace is initializing for the first time. This is the only way we can establish a hook
  # for init-optional-scaffolding.sh to determine if it should bypass the php artisan ui command
  # since the hook that init-optional-scaffolding.sh uses is to look for a directory in node_modules
  # named react, vue or bootstrap. Without this hook project code such ass app.js gets overwitten.
  if [[ -f "package.json"  && ! -d "node_modules" ]]; then
    msg="Installing node modules"
    log "$msg"
    yarn install
    err_code=$?
    if [ $err_code != 0 ]; then
      log "ERROR $?: $msg" -e
    else
      log "SUCCESS: $msg"
    fi
    log " --> Running Laravel Mix"
    npm run dev
    log " --> Running of Laravel Mix complete"
  fi

  # Move and merge necessary files, then cleanup
  mv /home/gitpod/laravel8-starter/README.md $GITPOD_REPO_ROOT/README_LARAVEL.md
  rm -rf /home/gitpod/laravel8-starter
  [ $? == 0 ] && log_silent "CLEANUP SUCCESS: removed /home/gitpod/laravel8-starter"
fi
# END: Bootstrap Laravel scaffolding

# Messages for github_changelog_generator
[ "$installed_changelog_gen" == 1 ] &&
log_silent "You may auto generate a CHANGELOG.md from github commits by running the command:\nrake changelog [...options]" &&
log_silent "See starter.ini (github_changelog_generator section) for configurable options" &&
log_silent "For a full list of options see the github-changelog-generator repository on github"
