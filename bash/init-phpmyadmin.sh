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

# Load spinner
. bash/third-party/spinner.sh

parse="bash bash/utils.sh parse_ini_value starter.ini"

# BEGIN: phpmyadmin setup if installed
installed_phpmyadmin=$(bash bash/utils.sh parse_ini_value starter.ini phpmyadmin install)
if [ "$installed_phpmyadmin" == 1 ]; then
  if [ -e public/phpmyadmin/config.sample.inc.php ]; then
    msg="Creating file public/phpmyadmin/config.inc.php"
    log_silent "$msg ..." && start_spinner "$msg ..."
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
    log_silent "$msg ..." && start_spinner "$msg ..."
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
  log_silent "$msg ..." && start_spinner "$msg ..."
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
# END: phpmyadmin setup if installed