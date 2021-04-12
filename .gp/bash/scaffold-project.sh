#!/bin/bash
# shellcheck source=/dev/null
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# scaffold-project.sh
# Description:
# Creates the main Laravel 8 project scaffolding.
#
# Notes:
# This script assumes it is being run from .gitpod.Dockerfile and
# that all of this scripts dependencies have already been copied to /tmp

LOG='/var/log/workspace-image.log'
SCAFF_NAME='laravel8-starter'
SCAFF_DEST="/home/gitpod/$SCAFF_NAME"

echo "BEGIN: Scaffolding Laravel Project" | tee -a $LOG
echo "  Creating Laravel 5.x project scaffolding in $SCAFF_DEST" | tee -a $LOG
composer create-project --prefer-dist laravel/laravel "$SCAFF_NAME" "5.*"

ERRCODE=$?
if [ $ERRCODE -ne 0 ]; then
  >&2 echo "  ERROR $?: failed to create Laravel 8 project scaffolding in $SCAFF_DEST" | tee -a $LOG
else
  chown -R gitpod:gitpod "$SCAFF_DEST"
  cd "$SCAFF_DEST" || exit 1
  echo "  SUCCESS: $(php artisan --version) project scaffolding created in $SCAFF_DEST" | tee -a $LOG

  # Handle optional install of phpmyadmin
  install_phpmyadmin=$(. /tmp/utils.sh parse_ini_value /tmp/starter.ini phpmyadmin install);
  if [[ $install_phpmyadmin -eq 1 ]]; then
    echo "  Installing phpmyadmin"  | tee -a $LOG
    cd "$SCAFF_DEST/public" && composer create-project phpmyadmin/phpmyadmin
    ERRCODE_PHPMYADMIN=$?
    if [ $ERRCODE_PHPMYADMIN -eq 0 ]; then
      chown -R gitpod:gitpod "$SCAFF_DEST/public/phpmyadmin"
      echo "  SUCCESS: phpmyadmin installed to $SCAFF_DEST/public"  | tee -a $LOG
    else
      >&2 echo "  ERROR $?: phpmyadmin failed to install" | tee -a $LOG
    fi
  fi
fi
echo "END: Scaffolding Laravel Project" | tee -a $LOG
