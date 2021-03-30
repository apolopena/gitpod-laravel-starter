#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init-gitpod.sh
# Description:
# Configures an existing phpmyadmin installation.

# Load logger
. bash/workspace-init-logger.sh

# regexp pattern for checking an array of exit codes
all_zeros_reg='^0$|^0*0$'

parse="bash bash/utils.sh parse_ini_value starter.ini"

# Edge case where the workspace image has cached the directive to not install phpmyadmin, install it now.
if [[ ! -d "public/phpmyadmin" ]]; then
  msg="Installing phpmyadmin"
  cd public && composer create-project phpmyadmin/phpmyadmin
  if [ $? != 0 ]; then
    log "ERROR: $msg" -e
    exit 1
  else
    cd ..
    log "SUCCESS: $msg"
  fi
fi

# Load spinner
. bash/third-party/spinner.sh

if [ -e public/phpmyadmin/config.sample.inc.php ]; then
  msg="Creating file public/phpmyadmin/config.inc.php"
  log_silent "$msg" && start_spinner "$msg"
  cp public/phpmyadmin/config.sample.inc.php public/phpmyadmin/config.inc.php
  err_code=$?
  if [ $err_code != 0 ]; then
    stop_spinner $err_code
    log "ERROR: Failed $msg" -e
  else
    stop_spinner $err_code
    log_silent "SUCCESS: $msg"
  fi
  # Setup Blowfish secret
  msg="Parsing blowfish secrect in public/phpmyadmin/config.inc.php"
  log_silent "$msg" && start_spinner "$msg"
  __bfs=$(bash bash/utils.sh generate_string 32)
  sed -i'' "s#\\$cfg['blowfish_secret'] = '';#\\$cfg['blowfish_secret'] = '$__bfs';#g" public/phpmyadmin/config.inc.php
  err_code=$?
  if [ $err_code != 0 ]; then
    stop_spinner $err_code
    log "ERROR: Failed $msg" -e
  else
    stop_spinner $err_code
    log_silent "SUCCESS: $msg"
  fi
  # Setup storage configuration
  msg="Uncommenting storage configuration in public/phpmyadmin/config.inc.php"
  log_silent "$msg" && start_spinner "$msg"
  sed -i "/'controluser'/,/End of servers configuration/ s/^\/\/ *//" public/phpmyadmin/config.inc.php
  err_code=$?
  if [ $err_code != 0 ]; then
    stop_spinner $err_code
    log "ERROR: Failed $msg" -e
  else
    stop_spinner $err_code
    log_silent "SUCCESS: $msg"
  fi
fi
# Setup phpmyadmin db and storage tables
msg='Configuring phpmyadmin db and storage tables'
log_silent "$msg" && start_spinner "$msg"
mysql < public/phpmyadmin/sql/create_tables.sql
if [ $err_code != 0 ]; then
  stop_spinner $err_code
  log "ERROR: $msg" -e
else
  stop_spinner $err_code
  log_silent "SUCCESS: $msg"
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
  log_silent "SUCCESS: $msg"
  stop_spinner $err_code
fi
# Control user account for phpmyadmin (used for storage features)
msg="Creating phpmyadmin control user"
error_codes=()
log_silent "$msg" && start_spinner "$msg"
mysql -e "CREATE USER 'pma'@'localhost' IDENTIFIED BY 'pmapass';"
error_codes+=($?)
mysql -e "GRANT ALL PRIVILEGES ON \`phpmyadmin\`.* TO 'pma'@'localhost' WITH GRANT OPTION;"
error_codes+=($?)
mysql -e "FLUSH PRIVILEGES;"
error_codes+=($?)
error_codes=$(echo ${error_codes[*]} | tr -d '[:space:]')
if [[ $error_codes =~ $all_zeros_reg ]]; then
  stop_spinner 0
  log_silent "SUCCESS: $msg"
else
  stop_spinner 1
  log "ERROR: $msg" -e
fi
# Install node modules
if [ ! -d 'public/phpmyadmin/node_modules' ]; then
  msg="Installing phpmyadmin node modules"
  log "$msg"
  cd public/phpmyadmin && yarn install && cd ../../
  if [ $? == 0 ]; then
    __pmaurl=$(gp url 8001)/phpmyadmin
    log_silent "SUCCESS: $msg"
    log_silent "To login to phpmyadmin:"
    log_silent "  --> 1. Make sure you are serving it with apache"
    log_silent "  --> 2. In the browser go to $__pmaurl"
    log_silent "  --> 3. You should be able to login here using the defaults. user: pmasu, pw: 123456"
    log_silent "Make sure you change the default passwords for the phpmyadmin accounts."
    log_silent "For help with updating phpmyadmin passwords, run the alias help_update_pma_pws"
  else
    log "ERROR: $msg. Try installing them manually." -e
  fi
fi
# END: phpmyadmin setup if installed