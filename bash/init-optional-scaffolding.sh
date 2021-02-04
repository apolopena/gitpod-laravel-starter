#!/bin/bash

# install-optional-scaffoliding.sh
# Description:
# Installs various packages according to the configuration set in starter.ini

# BEGIN: Parse starter.ini
install_react=$(. /tmp/utils.sh parse_ini_value starter.ini react install)
install_vue=$(. /tmp/utils.sh parse_ini_value starter.ini vue install)
install_bootstrap=$(. /tmp/utils.sh parse_ini_value starter.ini bootstrap install)
# END: Parse starter.ini

# BEGIN: Install Laravel ui if needed
if [[ $install_react == 1 || $install_bootstrap  == 1 ]]; then
  echo "Optional installations that require laravel/ui scaffolding were found."
  echo "Installing laravel/ui scaffolding..."
  composer require laravel/ui:^3.2.0
  err_code=$?
  if [ $err_code == 0 ]; then
    echo "SUCCESS: laravel/ui scaffolding installed."
    echo "Compiling fresh scaffolding and running Laravel Mix."
    yarn install && yarn run dev
    #echo "current working dir is: $(pwd)"
  else
    >&2 echo "ERROR $err_code: There was a problem installing laravel/ui"
  fi
fi
# END: Install Laravel ui if needed

# BEGIN: Optional react and react-dom install
if [ "$install_react" == 1 ]; then
  version=$(. /tmp/utils.sh parse_ini_value starter.ini react version)
  auth=$(. /tmp/utils.sh parse_ini_value starter.ini react auth)

  [ -z "$version" ] && version_msg='' || version_msg=" version $version"
  [ "$auth" != 1 ] && auth_msg='' || auth_msg=' with --auth'

  echo "React/React DOM install directive found in starter.ini"
  echo "Installing React and React DOM..."
  sleep 3

  if [ "$auth" == 1 ]; then
    php artisan ui react --auth
  else
    php artisan ui react
  fi
  err_code=$?
  if [ $err_code == 0 ]; then
    echo "SUCCESS: React and React DOM$version_msg$auth_msg has been installed"
    echo "Compiling fresh scaffolding and running Laravel Mix"
    yarn install && yarn run dev && sleep 1 && yarn run dev
    echo "Setting react and react-dom to$version_msg"
    # TODO:  validate semver and valid version for the package so users cant pass in junk
    yarn upgrade react@$version react-dom@$version
    [ "$install_bootstrap" == 1 ] && echo "Bootstrap install directive found but ignored. Already installed."
    [ "$install_vue" == 1 ] && echo "Vue install directive found but ignored. React supercedes this."
  else
    >&2 echo "ERROR $err_code: There was a problem installing React/React DOM$version_msg$auth_msg"
  fi
fi
# END: Optional react and react-dom install

# BEGIN: Optional vue install
if [[ "$install_vue" == 1 && "$install_react" == 0 ]]; then
  version=$(. /tmp/utils.sh parse_ini_value starter.ini vue version)
  auth=$(. /tmp/utils.sh parse_ini_value starter.ini vue auth)

  [ -z "$version" ] && version_msg='' || version_msg=" version $version"
  [ "$auth" != 1 ] && auth_msg='' || auth_msg=' with --auth'

  echo "Vue install directive found in starter.ini"
  echo "Installing Vue..."
  sleep 3

  if [ "$auth" == 1 ]; then
    php artisan ui vue --auth
  else
    php artisan ui vue
  fi
  err_code=$?
  if [ $err_code == 0 ]; then
    echo "SUCCESS: Vue$version_msg$auth_msg has been installed."
    echo "Compiling fresh scaffolding and running Laravel Mix."
    yarn install && yarn run dev && sleep 1 && yarn run dev
    echo "Setting vue to$version_msg"
    # TODO:  validate semver and valid version for the package so users cant pass in junk
    yarn upgrade vue@$version
    [ "$install_bootstrap" == 1 ] && echo "Bootstrap install directive found but ignored. Already installed."
  else
    >&2 echo "ERROR $err_code: There was a problem installing Vue$version_msg$auth_msg"
  fi
fi
# END: Optional vue install

# BEGIN: Optional bootstrap install
if [[ $install_bootstrap == 1 && $install_react == 0 && $install_vue == 0 ]]; then
  version=$(. /tmp/utils.sh parse_ini_value starter.ini bootstrap version)
  auth=$(. /tmp/utils.sh parse_ini_value starter.ini bootstrap auth)

  [ -z "$version" ] && version_msg='' || version_msg=" version $version"
  [ "$auth" != 1 ] && auth_msg='' || auth_msg=' with --auth'

  echo "Bootstrap install directive found in starter.ini"
  echo "Installing Bootstrap..."
  sleep 3

  if [ "$auth" == 1 ]; then
    php artisan ui bootstrap --auth
  else
    php artisan ui bootstrap
  fi
  err_code=$?
  if [ $err_code == 0 ]; then
    echo "SUCCESS: Bootstrap$version_msg$auth_msg has been installed."
    echo "Compiling fresh scaffolding and running Laravel Mix."
    yarn install && yarn run dev && sleep 1 && yarn run dev
    echo "Setting bootstrap to$version_msg"
    # TODO:  validate semver and valid version for the package so users cant pass in junk
    yarn upgrade bootstrap@$version
  else
    >&2 echo "ERROR $err_code: There was a problem installing Bootstrap$version_msg$auth_msg"
  fi
else
  version=$(. /tmp/utils.sh parse_ini_value starter.ini bootstrap version)
  [ -z "$version" ] && version_msg='' || version_msg=" version $version"
  if [! -z "$version" && "$install_bootstrap" == 1 ]
    echo "Setting bootstrap to$version_msg"
    yarn upgrade bootstrap@$version
fi
# END: Optional bootstrap install




