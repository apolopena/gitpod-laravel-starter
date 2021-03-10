#!/bin/bash

# install-optional-scaffoliding.sh
# Description:
# Installs various packages according to the configuration set in starter.ini

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

parse="bash bash/utils.sh parse_ini_value starter.ini"

install_react=$(eval $parse react install)
install_vue=$(eval $parse vue install)
install_bootstrap=$(eval $parse bootstrap install)
install_only_frontend_scaffolding=$(bash bash/helpers.sh has_only_frontend_scaffolding_install)

# BEGIN: optional frontend scaffolding installations
# BEGIN: Install Laravel ui if needed
if [[ $install_react == 1 || $install_bootstrap  == 1 ]]; then
  log "Optional installations that require laravel/ui scaffolding were found"

  # Assume we are using composer 2 or higher, check if the laravel/ui package has already been installed
  composer show | grep laravel/ui >/dev/null && __ui=1 || __ui=0

  if [ "$__ui" == 1 ]; then
    log "However it appears that laravel/ui has already been installed, skipping this installation."
  else
    log "Installing laravel/ui scaffolding"
    composer require laravel/ui:^3.2.0
    err_code=$?
    if [ $err_code == 0 ]; then
      log "SUCCESS: laravel/ui scaffolding installed"
      #log "Compiling fresh scaffolding and running Laravel Mix"
      log "-->Installing node modules"
      yarn install && yarn run dev
    else
      log "ERROR $err_code: There was a problem installing laravel/ui" -e
    fi
  fi
fi
# END: Install Laravel ui if needed

# BEGIN: Optional react and react-dom install
if [ "$install_react" == 1 ]; then
  version=$(eval $parse react version)
  auth=$(eval $parse react auth)
  __installed=$(bash bash/utils.sh node_package_exists react)
  [ -z "$version" ] && version_msg='' || version_msg=" version $version"
  [ "$auth" != 1 ] && auth_msg='' || auth_msg=' with --auth'
  log "React/React DOM install directive found in starter.ini"
  if [ "$__installed" == 1 ]; then
    log "However it appears that React/React DOM has already been installed, skipping this installation."
  else
    log "Installing React and React DOM"
    if [ "$auth" == 1 ]; then
      php artisan ui react --auth
    else
      php artisan ui react
    fi
    err_code=$?
    if [ $err_code == 0 ]; then
      log "SUCCESS: React and React DOM$version_msg$auth_msg has been installed"
      if [ $install_only_frontend_scaffolding == 1 ]; then
        log "Compiling fresh scaffolding and running Laravel Mix"
        yarn install && yarn run dev && sleep 1 && yarn run dev
      else
        log "Running Laravel Mix"
        yarn run dev
      fi
      if [ ! -z "$version" ]; then
        log "Setting react and react-dom to$version_msg"
        # TODO:  validate semver and valid version for the package so users cant pass in junk
        yarn upgrade react@$version react-dom@$version
      fi
      [ "$install_bootstrap" == 1 ] && log "Bootstrap install directive found but ignored. Already installed"
      [ "$install_vue" == 1 ] && log "Vue install directive found but ignored. The install of react superceded this"
    else
      log "ERROR $err_code: There was a problem installing React/React DOM$version_msg$auth_msg" -e
    fi
  fi
fi
# END: Optional react and react-dom install

# BEGIN: Optional vue install
if [[ "$install_vue" == 1 && "$install_react" == 0 ]]; then
  version=$(eval $parse vue version)
  auth=$(eval $parse vue auth)
  __installed=$(bash bash/utils.sh node_package_exists vue)
  [ -z "$version" ] && version_msg='' || version_msg=" version $version"
  [ "$auth" != 1 ] && auth_msg='' || auth_msg=' with --auth'
  log "Vue install directive found in starter.ini"
  if [ "$__installed" == 1 ]; then
    log "However it appears that Vue has already been installed, skipping this installation."
  else
    log "Installing Vue..."
    if [ "$auth" == 1 ]; then
      php artisan ui vue --auth
    else
      php artisan ui vue
    fi
    err_code=$?
    if [ $err_code == 0 ]; then
      log "SUCCESS: Vue$version_msg$auth_msg has been installed"
      log "Compiling fresh scaffolding and running Laravel Mix"
      yarn install && yarn run dev && sleep 1 && yarn run dev
      if [ ! -z "$version" ]; then
        log "Setting vue to$version_msg"
        # TODO:  validate semver and valid version for the package so users cant pass in junk
        yarn upgrade vue@$version
      fi
      [ "$install_bootstrap" == 1 ] && log "Bootstrap install directive found but ignored. Already installed."
    else
      log "ERROR $err_code: There was a problem installing Vue$version_msg$auth_msg" -e
    fi
  fi
fi
# END: Optional vue install

# TODO: test bootstrap install without any detection for an existing install.
# If nothing is affected like app.js then install wont need to be skipped.
# otherwise implement the same fix for existing installs that we have for react and vue.

# BEGIN: Optional bootstrap install
if [[ $install_bootstrap == 1 && $install_react == 0 && $install_vue == 0 ]]; then
  version=$(eval $parse bootstrap version)
  auth=$(eval $parse bootstrap auth)
  [ -z "$version" ] && version_msg='' || version_msg=" version $version"
  [ "$auth" != 1 ] && auth_msg='' || auth_msg=' with --auth'
  log "Bootstrap install directive found in starter.ini"
  log "Installing Bootstrap"
  if [ "$auth" == 1 ]; then
    php artisan ui bootstrap --auth
  else
    php artisan ui bootstrap
  fi
  err_code=$?
  if [ $err_code == 0 ]; then
    log "SUCCESS: Bootstrap$version_msg$auth_msg has been installed"
    log "Compiling fresh scaffolding and running Laravel Mix"
    yarn install && yarn run dev && sleep 1 && yarn run dev
    if [ ! -z "$version" ]; then
      log "Setting bootstrap to$version_msg"
      # TODO:  validate semver and valid version for the package so users cant pass in junk
      yarn upgrade bootstrap@$version
    fi
  else
    >&2 log "ERROR $err_code: There was a problem installing Bootstrap$version_msg$auth_msg"
  fi
else
  version=$(eval $parse bootstrap version)
  [ -z "$version" ] && version_msg='' || version_msg=" version $version"
  if [[ ! -z $version && $install_bootstrap == 1 ]]; then
    log "Setting bootstrap to$version_msg"
    yarn upgrade bootstrap@$version
  fi
fi
# END: Optional bootstrap install
# END: optional frontend scaffolding installations

# BEGIN: phpmyadmin setup
installed_phpmyadmin=$(bash bash/utils.sh parse_ini_value starter.ini phpmyadmin install)
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
# END: phpmyadmin setup