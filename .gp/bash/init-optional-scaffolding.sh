#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init-optional-scaffolding.sh
# Description:
# Installs various packages and scaffolding according to the directive set in starter.ini

# Load logger
. .gp/bash/workspace-init-logger.sh

# Load spinner
. .gp/bash/spinner.sh

parse="bash .gp/bash/utils.sh parse_ini_value starter.ini"

install_react=$(eval "$parse" react install)
install_vue=$(eval "$parse" vue install)
install_bootstrap=$(eval "$parse" bootstrap install)
install_phpmyadmin=$(eval "$parse" starter.ini phpmyadmin install)
install_react_router_dom=$(eval "$parse" react-router-dom install)
rrd_ver=$(eval "$parse" react-router-dom version)
init_phpmyadmin=".gp/bash/init-phpmyadmin.sh"

# Any value for set for EXAMPLE will build the react/phpmyadmin questions and answers demo
# into the starter, thus superceding some directives in starter.ini
if [[ -n $EXAMPLE ]]; then
  case $EXAMPLE in
    1)
      example_title="React Example with phpMyAdmin and extras - Questions and Answers"
      init_example=".gp/bash/init-react-example.sh"
      install_react=1
      install_phpmyadmin=1
      install_react_router_dom=1
      rrd_ver='^5.2.0'
      ;;
    2)
      example_title="React Example without phpMyAdmin and no extras - Questions and Answers"
      init_example=".gp/bash/init-react-example.sh"
      install_react=1
      install_phpmyadmin=0
      install_react_router_dom=1
      rrd_ver='^5.2.0'
      ;;
    *)
      # Default example
      # Keep this block identical to case 1)
      example_title="React Example with phpMyAdmin and extras - Questions and Answers"
      init_example=".gp/bash/init-react-example.sh"
      install_react=1
      install_phpmyadmin=1
      install_react_router_dom=1
      rrd_ver='^5.2.0'
      ;;
  esac
  log "EXAMPLE directive query parameter found"
  log "  --> Some directives in starter.ini will be superceded"
  log "Configuring the example project"
  log "  --> $example_title"
fi

# phpmyadmin
if [[ $install_phpmyadmin == 1 ]];then
  if [[ -n  $init_example ]];then
    . "$init_phpmyadmin" 2>/dev/null || log_silent -e "ERROR: $(. $init_phpmyadmin 2>&1 1>/dev/null)"
  else
    log -e "ERROR: phpmyadmin should be configured but the script was not set"
  fi
   . $init_phpmyadmin 2>/dev/null || log_silent -e "ERROR: $(. $init_phpmyadmin 2>&1 1>/dev/null)" 
fi

# BEGIN: Install Laravel ui if needed
has_frontend_scaffolding_install=$(bash .gp/bash/helpers.sh has_frontend_scaffolding_install)
if [[ $has_frontend_scaffolding_install == 1 || -n $EXAMPLE ]]; then
  log "Optional installations that require laravel/ui scaffolding were found"
  # Assume we are using composer 2 or higher, check if the laravel/ui package has already been installed
  composer show | grep laravel/ui >/dev/null && __ui=1 || __ui=0
  if [ $__ui == 1 ]; then
    log "However it appears that laravel/ui has already been installed, skipping this installation."
  else
    log "Installing laravel/ui scaffolding via Composer"
    composer require laravel/ui:^3.2.0
    err_code=$?
    if [ $err_code == 0 ]; then
      log "SUCCESS: laravel/ui scaffolding installed"
    else
      log -e "ERROR $err_code: There was a problem installing laravel/ui via Composer"
    fi
  fi
fi
# END: Install Laravel ui if needed

# BEGIN: Optional react, react-dom and react-router-dom installs
if [ $install_react == 1 ]; then
  version=$(eval "$parse" react version)
  auth=$(eval "$parse" react auth)
  __installed=$(bash .gp/bash/utils.sh node_package_exists react)
  [[ -z $version ]] && version_msg='' || version_msg=" version $version"
  [[ $auth != 1 ]] && auth_msg='' || auth_msg=' with --auth'
  log "React/React DOM install directive found in starter.ini"
  if [[ $__installed == 1 ]]; then
    log "However it appears that React/React DOM has already been installed, skipping this installation."
  else
    log "Installing React and React DOM$auth_msg"
    if [[ $auth == 1 ]]; then
      php artisan ui react --auth
    else
      php artisan ui react
    fi
    err_code=$?
    if [[ $err_code == 0 ]]; then
      log "SUCCESS: React and React DOM$auth_msg have been installed"
      if [ $install_react_router_dom == 1 ]; then
        if [[ -z "$rrd_ver" ]]; then
          sub_msg="Installing react-router-dom to the latest version"
          log "$sub_msg"
          yarn add react-router-dom --silent
        else
          sub_msg="Installing react-router-dom to semantic version $rrd_ver"
          log "$sub_msg"
          yarn add react-router-dom@$rrd_ver --silent
        fi
        err_code=$?
        if [[ $err_code == 0 ]]; then
          log "SUCCESS: $sub_msg"
        else
          log -e "ERROR: $sub_msg"
        fi
      fi
      log "  --> Installing node modules and running Laravel Mix"
      yarn install && npm run dev
      npm run dev
      if [[ -n $version ]]; then
        log "Upgrading react and react-dom to$version_msg"
        yarn upgrade "react@$version" "react-dom@$version"
      fi
      [[ $install_bootstrap == 1 ]] && log "Bootstrap install directive found but ignored. Already installed"
      [[ $install_vue == 1 ]] && log "Vue install directive found but ignored. The install of react superceded this"
    else
      log -e "ERROR $err_code: There was a problem installing React/React DOM$auth_msg"
    fi
  fi
fi
# END: Optional react, react-dom and react-router-dom installs

# BEGIN: Optional vue install
if [[ $install_vue == 1 && $install_react == 0 ]]; then
  version=$(eval "$parse" vue version)
  auth=$(eval "$parse" vue auth)
  __installed=$(bash .gp/bash/utils.sh node_package_exists vue)
  [[ -z $version ]] && version_msg='' || version_msg=" version $version"
  [[ $auth != 1 ]] && auth_msg='' || auth_msg=' with --auth'
  log "Vue install directive found in starter.ini"
  if [[ $__installed == 1 ]]; then
    log "However it appears that Vue has already been installed, skipping this installation."
  else
    log "Installing vue$auth_msg"
    if [[ $auth == 1 ]]; then
      php artisan ui vue --auth
    else
      php artisan ui vue
    fi
    err_code=$?
    if [[ $err_code == 0 ]]; then
      log "SUCCESS: Vue$auth_msg has been installed"
      log "  --> Installing node modules and running Laravel Mix"
      yarn install && npm run dev
      npm run dev
      if [[ -n $version ]]; then
        log "Upgrading vue to$version_msg"
        yarn upgrade "vue@$version"
      fi
      [[ $install_bootstrap == 1 ]] && log "Bootstrap install directive found but ignored. Already installed."
    else
      log -e "ERROR $err_code: There was a problem installing vue$auth_msg"
    fi
  fi
fi
# END: Optional vue install

# BEGIN: Optional bootstrap install
if [[ $install_bootstrap == 1 && $install_react == 0 && $install_vue == 0 ]]; then
  version=$(eval "$parse" bootstrap version)
  auth=$(eval "$parse" bootstrap auth)
  [[ -z "$version" ]] && version_msg='' || version_msg=" version $version"
  [[ $auth != 1 ]] && auth_msg='' || auth_msg=' with --auth'
  log "Bootstrap install directive found in starter.ini"
  log "Installing Bootstrap$auth_msg"
  if [[ $auth == 1 ]]; then
    php artisan ui bootstrap --auth
  else
    php artisan ui bootstrap
  fi
  err_code=$?
  if [[ $err_code == 0 ]]; then
    log "SUCCESS: Bootstrap$version_msg$auth_msg has been installed"
    log "  --> Installing node modules and running Laravel Mix"
    yarn install && npm run dev
    npm run dev
    if [[ -n "$version" ]]; then
      log "Upgrading bootstrap to$version_msg"
      yarn upgrade "bootstrap@$version"
    fi
  else
    log -e "ERROR $err_code: There was a problem installing Bootstrap$auth_msg"
  fi
else
  version=$(eval "$parse" bootstrap version)
  [[ -z "$version" ]] && version_msg='' || version_msg=" version $version"
  if [[ -n $version && $install_bootstrap == 1 ]]; then
    log "Setting bootstrap to$version_msg"
    yarn upgrade "bootstrap@$version"
  fi
fi
# END: Optional bootstrap install
# END: optional frontend scaffolding installations

# Initialize optional example project
if [[ -n  $init_example ]];then
  . "$init_example" 2>/dev/null || log_silent -e "ERROR: $(. $init_example 2>&1 1>/dev/null)"
else
  log -e "ERROR: EXAMPLE was requested but the example script was not set"
fi