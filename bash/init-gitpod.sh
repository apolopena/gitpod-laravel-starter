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
  log_silent "$msg..." && start_spinner "$msg..."
  shopt -s dotglob
  #rsync -rlptgoDP --ignore-existing --info=name0 --no-i-r ~/test-app/ $GITPOD_REPO_ROOT | xargs -L1 printf "\33[2K\r%s"
  grc -c bash/snippets/grc/rsync-stats \
  rsync -rlptgoD --ignore-existing --stats --human-readable ~/test-app/ $GITPOD_REPO_ROOT
  err_code=$?
  if [ $err_code != 0 ]; then
    stop_spinner $err_code
    log "ERROR: Failed to rsync Laravel project from ~/temp-app to $GITPOD_REPO_ROOT" -e
  else
    stop_spinner $err_code
    log_silent "SUCCESS: rsync Laravel project from ~/temp-app to $GITPOD_REPO_ROOT"
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
    msg="Creating database: laravel"
    log_silent "$_msg..." && start_spinner "$msg..."
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
    log "$msg..."
    yarn install
    err_code=$?
    if [ $err_code != 0 ]; then
      log "ERROR $?: $msg" -e
    else
      log "SUCCESS: $msg"
    fi
    log " --> Running Laravel Mix..."
    npm run dev
    log " --> Running of Laravel Mix complete"
  fi

  # Move and merge necessary files, then cleanup
  mv ~/test-app/README.md $GITPOD_REPO_ROOT/README_LARAVEL.md
  rm -rf ~/test-app
fi
# END: Bootstrap Laravel scaffolding

# Messages for github_changelog_generator
[ "$installed_changelog_gen" == 1 ] &&
log_silent "You may auto generate a CHANGELOG.md from github commits by running the command:\nrake changelog [...options]\n" &&
log_silent "See starter.ini (github_changelog_generator section) for configurable options" &&
log_silent "For a full list of options see the github-changelog-generator repository on github"
