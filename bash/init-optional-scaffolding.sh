#!/bin/bash

# install-optional-scaffoliding.sh
# Description:
# Installs various packages according to the configuration set in starter.ini

# Parse starter.ini
install_react=$(. /tmp/utils.sh parse_ini_value starter.ini react install)
install_bootstrap=$(. /tmp/utils.sh parse_ini_value starter.ini bootstrap install)

# Install Laravel ui if needed
if [[ $install_react == 1 || $install_bootstrap  == 1 ]]; then
  echo "Optional installations that require laravel/ui scaffolding were found."
  echo "Installing laravel/ui scaffolding..."
  composer require laravel/ui
  err_code=$?
  if [ $err_code -eq 0 ]; then
    echo "SUCCESS: laravel/ui scaffolding installed"
    # genrate yarn.lock without installing anything
    # this is a npm workaround since yarn does not have this feature

    #echo "Doing a npm install now."
    yarn install
    #echo "current working dir is: $(pwd)"
  else
    >&2 echo "ERROR $?: There was a problem installing laravel/ui"
  fi
fi

# BEGIN: Optional react and react-dom install
if [ $install_react -eq 1 ]; then
  version=$(. /tmp/utils.sh parse_ini_value starter.ini react version)
  auth=$(. /tmp/utils.sh parse_ini_value starter.ini react auth)

  [ -z "$version" ] && version_msg='' || version_msg=" version $version"
  [ $auth != 1 ] && auth_msg='' || auth_msg=' with --auth'

  echo "React/React DOM installation directive found in starter.ini"
  echo "Installing React and React DOM$version_msg$auth_msg..."

  if [ $auth == 1 ]; then
    php artisan ui react --auth
  else
    php artisan ui react
  fi
  err_code=$?
  if [ $err_code == 0 ]; then
    echo "SUCCESS: React and React DOM$version_msg$auth_msg has been installed"
  else
    >&2 echo "ERROR $?: There was a problem installing React/React DOM$version_msg$auth_msg"
  fi
# END: Optional react and react-dom install
fi

# Finally install everything else
echo "Installing remaining dependencies"
#yarn install


