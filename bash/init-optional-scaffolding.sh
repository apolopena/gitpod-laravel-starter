#!/bin/bash

# install-optional-scaffoliding.sh
# Description:
# Installs various packages according to the configuration set in starter.ini

# Parse starter.ini
install_react=$(. /tmp/utils.sh parse_ini_value starter.ini react install)
install_bootstrap=$(. /tmp/utils.sh parse_ini_value starter.ini bootstrap install)

# Install Laravel ui if needed
if [ $install_react -eq 1 ] || [ $install_bootstrap  -eq 1 ]; then
  echo "Optional installation the require laravel/ui were found."
  echo "Installing laravel/ui ..."
  composer require laravel/ui
  err_code=$?
  if [ $err_code -eq 0 ]; then
    echo "SUCCESS: laravel/ui installed"
  else
    >&2 echo "ERROR $?: There was a problem installing laravel/ui"
  fi
fi

# BEGIN: Optional react and react-dom install
echo "install react=$install_react"
if [ $install_react -eq 1 ]; then
  version=$(. /tmp/utils.sh parse_ini_value starter.ini react version)
  auth=$(. /tmp/utils.sh parse_ini_value starter.ini react auth)
  [ -z "$version" ] version_msg='' || version_msg=" version $version"
  [ $auth -eq 0 ] auth_msg='' || auth_msg= ' with --auth'
  echo "React/ React DOM installation directive found in starter.ini"
  echo "Installing React and React DOM$version_msg$auth_msg..."
  if [ $auth -eq 1 ]; then
    php artisan ui react --auth
  else
    php artisan ui react
  fi
  err_code=$?
  if [ $err_code -eq 0 ]; then
    echo "SUCCESS: React and React DOM$version_msg$auth_msg has been installed"
  else
    >&2 echo "ERROR $?: There was a problem installing React/React DOM$version_msg$auth_msg"
  fi
  if [ ! -z "$version" ]; then
    "Installing/upgrading react to$version_msg"
    yarn upgrade react@$version
    err_code=$?
    if [ $err_code -eq 0 ]; then
      echo "SUCCESS: React version installed/upgraded to$version_msg"
    else
      >&2 echo "ERROR $?: There was a problem installing/upgrading React to$version_msg"
    fi
    yarn upgrade react-dom@$version
    err_code=$?
    if [ $err_code -eq 0 ]; then
      echo "SUCCESS: React DOM version installed/upgraded to$version_msg"
    else
      >&2 echo "ERROR $?: There was a problem installing/upgrading React DOM to$version_msg"
    fi
  fi
fi
# END: Optional react and react-dom install


# Finally install everything else
echo "Installing remaining dependencies"
yarn install


