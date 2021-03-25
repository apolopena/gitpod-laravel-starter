#!/bin/bash

# init-phpmyadmin.sh
# Description:
# Initial configuration for an existing phpmyadmin installation

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

parse="bash bash/utils.sh parse_ini_value starter.ini"

# HOTFIX:
# remove any residual phpmyadmin files
# HOTFIX: Handle the edge case where workspace image has cached starter.ini and 
# phpymadmin was not installed when it should have been. Abort.
# TODO: move phpmyadmin out of .gitpod.Dockerfile
if [[ ! -d "public/phpmyadmin" ]]; then
  log "ERROR: The workspace image has cached the phpmyadmin install directive." -e
  log "   --> Force the workspace image to build again by incrementing INVALIDATE_CACHE" -e
  log "       in .gitpod.Dockerfile, push the change, and try again with a new workspace." -e
  exit 0
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
  log_silent "$msg ..." && start_spinner "$msg ..."
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
log_silent "$msg..." && start_spinner "$msg.."
mysql -e "CREATE USER 'pma'@'localhost' IDENTIFIED BY 'pmapass';"
error_codes+=($?)
mysql -e "GRANT ALL PRIVILEGES ON \`phpmyadmin\`.* TO 'pma'@'localhost' WITH GRANT OPTION;"
error_codes+=($?)
mysql -e "FLUSH PRIVILEGES;"
error_codes+=($?)
error_codes=$(echo ${error_codes[*]} | tr -d '[:space:]')
if [[ $error_codes =~ $all_zeros_reg ]]; then
  stop_spinner $err_code
  log_silent "SUCCESS: $msg"
else
  stop_spinner 0
  log "ERROR: $msg" -e
fi
# Install node modules
if [ ! -d 'public/phpmyadmin/node_modules' ]; then
  log "phpmyadmin node modules have not yet been installed, installing now..."
  cd public/phpmyadmin && yarn install && cd ../../
  if [ $? == 0 ]; then
    __pmaurl=$(gp url 8001)/phpmyadmin
    log_silent "phpmyadmin node modules installed."
    log_silent "To login to phpmyadmin:"
    log_silent "  --> 1. Make sure you are serving it with apache"
    log_silent "  --> 2. In the browser go to $__pmaurl"
    log_silent "  --> 3. You should be able to login here using the defaults. user: pmasu, pw: 123456"
    log_silent "Make sure you change the default passwords for the phpmyadmin accounts."
    log_silent "For help with updating phpmyadmin passwords, run the alias help_update_pma_pws"
  else
    log "ERROR: installing phpmyadmin node modules. Try installing them manually." -e
  fi
fi
# END: phpmyadmin setup if installed