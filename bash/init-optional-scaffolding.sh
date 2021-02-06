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

parse="bash bash/utils.sh parse_ini_value starter.ini"

install_react=$(eval $parse react install)
install_vue=$(eval $parse vue install)
install_bootstrap=$(eval $parse bootstrap install)

# BEGIN: Install Laravel ui if needed
if [[ $install_react == 1 || $install_bootstrap  == 1 ]]; then
  log "Optional installations that require laravel/ui scaffolding were found"
  log "Installing laravel/ui scaffolding"
  composer require laravel/ui:^3.2.0
  err_code=$?
  if [ $err_code == 0 ]; then
    log "SUCCESS: laravel/ui scaffolding installed"
    log "Compiling fresh scaffolding and running Laravel Mix"
    yarn install && yarn run dev
  else
    log "ERROR $err_code: There was a problem installing laravel/ui" -e
  fi
fi
# END: Install Laravel ui if needed

# BEGIN: Optional react and react-dom install
if [ "$install_react" == 1 ]; then
  version=$(eval $parse react version)
  auth=$(eval $parse react auth)
  [ -z "$version" ] && version_msg='' || version_msg=" version $version"
  [ "$auth" != 1 ] && auth_msg='' || auth_msg=' with --auth'
  log "React/React DOM install directive found in starter.ini"
  log "Installing React and React DOM"
  if [ "$auth" == 1 ]; then
    php artisan ui react --auth
  else
    php artisan ui react
  fi
  err_code=$?
  if [ $err_code == 0 ]; then
    log "SUCCESS: React and React DOM$version_msg$auth_msg has been installed"
    log "Compiling fresh scaffolding and running Laravel Mix"
    yarn install && yarn run dev && sleep 1 && yarn run dev
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
# END: Optional react and react-dom install

# BEGIN: Optional vue install
if [[ "$install_vue" == 1 && "$install_react" == 0 ]]; then
  version=$(eval $parse vue version)
  auth=$(eval $parse vue auth)
  [ -z "$version" ] && version_msg='' || version_msg=" version $version"
  [ "$auth" != 1 ] && auth_msg='' || auth_msg=' with --auth'
  log "Vue install directive found in starter.ini"
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
# END: Optional vue install

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




