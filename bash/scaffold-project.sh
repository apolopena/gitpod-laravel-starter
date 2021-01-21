#!/bin/bash
LOG='/var/log/workspace-image.log'

echo "BEGIN: Scaffolding Laravel Project" | tee -a $LOG

echo "Creating Laravel 8.23.x project in /temp-app ..." | tee -a $LOG
composer create-project laravel/laravel:8.23.* temp-app
ERRCODE=$?
if [ $ERROCODE -ne 0 ]; then
  >&2 echo "  ERROR: failed to create Laravel 8.23.x project temp-app" | tee -a $LOG
else
  cd temp-app
  VER=`php artisan --version`
  echo "  SUCCESS: $VER project temp-app project created" | tee -a $LOG
fi

echo "END: Scaffolding Laravel Project" | tee -a $LOG