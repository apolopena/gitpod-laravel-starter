#!/bin/bash

# init-optional-scaffoliding.sh
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

# regexp pattern for checking an array of exit codes
all_zeros_reg='^0$|^0*0$'

# Load spinner
. bash/third-party/spinner.sh

parse="bash bash/utils.sh parse_ini_value starter.ini"

install_react=$(eval $parse react install)
install_vue=$(eval $parse vue install)
install_bootstrap=$(eval $parse bootstrap install)

# BEGIN: optional frontend scaffolding installations

# phpmyadmin
installed_phpmyadmin=$(bash bash/utils.sh parse_ini_value starter.ini phpmyadmin install)
[ "$installed_phpmyadmin" == 1 ] && . bash/init-phpmyadmin.sh

# BEGIN: Install Laravel ui if needed
has_frontend_scaffolding_install=$(bash bash/helpers.sh has_frontend_scaffolding_install)
if [[ $has_frontend_scaffolding_install == 1 ]]; then
  log "Optional installations that require laravel/ui scaffolding were found"
  # Assume we are using composer 2 or higher, check if the laravel/ui package has already been installed
  composer show | grep laravel/ui >/dev/null && __ui=1 || __ui=0
  if [ "$__ui" == 1 ]; then
    log "However it appears that laravel/ui has already been installed, skipping this installation."
  else
    log "Installing laravel/ui scaffolding via Composer"
    composer require laravel/ui:^3.2.0
    err_code=$?
    if [ $err_code == 0 ]; then
      log "SUCCESS: laravel/ui scaffolding installed"
    else
      log "ERROR $err_code: There was a problem installing laravel/ui via Composer" -e
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
    log "Installing React and React DOM$auth_msg"
    if [ "$auth" == 1 ]; then
      php artisan ui react --auth
    else
      php artisan ui react
    fi
    err_code=$?
    if [ $err_code == 0 ]; then
      log "SUCCESS: React and React DOM$auth_msg have been installed"
      log "  --> Installing node modules and running Laravel Mix"
      yarn install && yarn run dev && yarn run dev
      if [ ! -z "$version" ]; then
        log "Upgrading react and react-dom to$version_msg"
        # TODO:  validate semver and valid version for the package so users cant pass in junk
        yarn upgrade react@$version react-dom@$version
      fi
      [ "$install_bootstrap" == 1 ] && log "Bootstrap install directive found but ignored. Already installed"
      [ "$install_vue" == 1 ] && log "Vue install directive found but ignored. The install of react superceded this"
    else
      log "ERROR $err_code: There was a problem installing React/React DOM$auth_msg" -e
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
    log "Installing vue$auth_msg"
    if [ "$auth" == 1 ]; then
      php artisan ui vue --auth
    else
      php artisan ui vue
    fi
    err_code=$?
    if [ $err_code == 0 ]; then
      log "SUCCESS: Vue$auth_msg has been installed"
      log "  --> Installing node modules and running Laravel Mix"
      yarn install && npm run dev && sleep 1 && npm run dev
      if [ ! -z "$version" ]; then
        log "Upgrading vue to$version_msg"
        # TODO:  validate semver and valid version for the package so users cant pass in junk
        yarn upgrade vue@$version
      fi
      [ "$install_bootstrap" == 1 ] && log "Bootstrap install directive found but ignored. Already installed."
    else
      log "ERROR $err_code: There was a problem installing vue$auth_msg" -e
    fi
  fi
fi
# END: Optional vue install

# BEGIN: Optional bootstrap install
if [[ $install_bootstrap == 1 && $install_react == 0 && $install_vue == 0 ]]; then
  version=$(eval $parse bootstrap version)
  auth=$(eval $parse bootstrap auth)
  [ -z "$version" ] && version_msg='' || version_msg=" version $version"
  [ "$auth" != 1 ] && auth_msg='' || auth_msg=' with --auth'
  log "Bootstrap install directive found in starter.ini"
  log "Installing Bootstrap$auth_msg"
  if [ "$auth" == 1 ]; then
    php artisan ui bootstrap --auth
  else
    php artisan ui bootstrap
  fi
  err_code=$?
  if [ $err_code == 0 ]; then
    log "SUCCESS: Bootstrap$version_msg$auth_msg has been installed"
    log "  --> Installing node modules and running Laravel Mix"
    yarn install && npm run dev && sleep 1 && npm run dev
    if [ ! -z "$version" ]; then
      log "Upgrading bootstrap to$version_msg"
      # TODO:  validate semver and valid version for the package so users cant pass in junk
      yarn upgrade bootstrap@$version
    fi
  else
    >&2 log "ERROR $err_code: There was a problem installing Bootstrap$auth_msg"
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
