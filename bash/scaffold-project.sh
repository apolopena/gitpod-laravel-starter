#!/bin/bash
#
# scaffold-project.sh
#
# Description:Creates all project files in /tmp
# Author: Apolo Pena
#
# NOTE: This script assumes it is being run from .gitpod.Dockerfile
# and all of this scripts dependencies have already been copied to /tmp

LOG='/var/log/workspace-image.log'

echo "BEGIN: Scaffolding Laravel Project" | tee -a $LOG
echo "  Creating Laravel 8.x project in ~/temp-app..." | tee -a $LOG
composer create-project --prefer-dist laravel/laravel test-app "8.*"

ERRCODE=$?
if [ $ERRCODE -ne 0 ]; then
  >&2 echo "  ERROR $?: failed to create Laravel 8.23.x project temp-app" | tee -a $LOG
else
  chown -R gitpod:gitpod /home/gitpod/test-app
  cd /home/gitpod/test-app
  VER=`php artisan --version`
  echo "  SUCCESS: $VER project temp-app project created in ~/" | tee -a $LOG

  # Handle optional install of phpmyadmin
  install_phpmyadmin=$(. /tmp/utils.sh parse_ini_value /tmp/starter.ini phpmyadmin install);
  if [ $install_phpmyadmin -eq 1 ]; then
    echo "  Phpmyadmin installation directive found in starter.ini" | tee -a $LOG
    echo "  Installing phpmyadmin..."  | tee -a $LOG
    cd /home/gitpod/test-app/public && composer create-project phpmyadmin/phpmyadmin
    ERRCODE_PHPMYADMIN=$?
    if [ $ERRCODE_PHPMYADMIN -eq 0 ]; then
      chown -R gitpod:gitpod /home/gitpod/test-app/public/phpmyadmin
      echo "  SUCCESS: phpmyadmin installed to ~/temp-app/public"  | tee -a $LOG
    else
      >&2 echo "  ERROR $?: phpmyadmin failed to install" | tee -a $LOG
    fi
  fi
fi
echo "END: Scaffolding Laravel Project" | tee -a $LOG
