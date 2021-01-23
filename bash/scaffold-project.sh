#!/bin/bash
LOG='/var/log/workspace-image.log'

echo "BEGIN: Scaffolding Laravel Project" | tee -a $LOG

echo "  Creating Laravel 8.x project in ~/temp-app ..." | tee -a $LOG
composer create-project --prefer-dist laravel/laravel test-app "8.*"
ERRCODE=$?
if [ $ERRCODE -ne 0 ]; then
  >&2 echo "  ERROR: failed to create Laravel 8.23.x project temp-app" | tee -a $LOG
else
  chown -R gitpod:gitpod /home/gitpod/test-app
  cd /home/gitpod/test-app
  VER=`php artisan --version`
  echo "  SUCCESS: $VER project temp-app project created in ~/" | tee -a $LOG
fi

echo "END: Scaffolding Laravel Project" | tee -a $LOG