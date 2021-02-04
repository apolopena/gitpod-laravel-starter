#!/bin/bash

# install-optional-scaffoliding.sh
# Description:
# Installs various packages according to the configuration set in starter.ini

# BEGIN: Parse starter.ini
install_react=$(. /tmp/utils.sh parse_ini_value starter.ini react install)
install_bootstrap=$(. /tmp/utils.sh parse_ini_value starter.ini bootstrap install)
# END: Parse starter.ini
# BEGIN: Install Laravel ui if needed
if [[ $install_react == 1 || $install_bootstrap  == 1 ]]; then
  echo "Optional installations that require laravel/ui scaffolding were found."
  echo "Installing laravel/ui scaffolding..."
  composer require laravel/ui:^3.2.0
  err_code=$?
  if [ $err_code == 0 ]; then
    echo "SUCCESS: laravel/ui scaffolding installed"
    # genrate yarn.lock without installing anything
    # this is a npm workaround since yarn does not have this feature

    echo "Compiling fresh scaffolding and running Laravel Mix"
    yarn install && yarn run dev
    #echo "current working dir is: $(pwd)"
  else
    >&2 echo "ERROR $err_code: There was a problem installing laravel/ui"
  fi
fi
# END: Install Laravel ui if needed
# BEGIN: Optional react and react-dom install
if [ $install_react == 1 ]; then
  version=$(. /tmp/utils.sh parse_ini_value starter.ini react version)
  auth=$(. /tmp/utils.sh parse_ini_value starter.ini react auth)

  [ -z "$version" ] && version_msg='' || version_msg=" version $version"
  [ $auth != 1 ] && auth_msg='' || auth_msg=' with --auth'

  echo "React/React DOM installation directive found in starter.ini"
  echo "Installing React and React DOM$version_msg$auth_msg..."
  sleep 10
  if [ $auth == 1 ]; then
    php artisan ui react --auth
  else
    php artisan ui react
  fi
  err_code=$?
  if [ $err_code == 0 ]; then
    echo "SUCCESS: React and React DOM$version_msg$auth_msg has been installed"
    echo "Compiling fresh scaffolding and running Laravel Mix"
    yarn install && yarn run dev && sleep 1 && yarn run dev
    echo "setting react and react-dom to$version_msg"
    # TODO:  validate semver and valid version for the package so users cant pass in junk
    yarn upgrade react@$version react-dom@$version
  else
    >&2 echo "ERROR $err_code: There was a problem installing React/React DOM$version_msg$auth_msg"
  fi
fi
# END: Optional react and react-dom install
# BEGIN: Optional vue install
# END: Optional vue install
# BEGIN: Optional bootstrap install
# END: Optional bootstrap install

# BEGIN: set react and react-dom to specific version

# END: set react and react-dom to specific version
# BEGIN: set vue to specific version
# END: set vue to specific version
# BEGIN: set bootstrap to specific version
# END: set bootstrap to specific version


# Finally install everything else
echo "Installing remaining dependencies"
#yarn install


