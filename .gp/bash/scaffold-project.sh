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

_log='/var/log/workspace-image.log'
_scaff_name='laravel-starter'
_scaff_dest="/home/gitpod/$_scaff_name"
_lv_default='8.*'
_lv=$(. /tmp/utils.sh parse_ini_value /tmp/starter.ini laravel version)

# Set default if laravel version was not set in starter.ini
[[ -z $_lv ]] && _lv="$_lv_default"
# Get the major laravel version by deleting the first dot and everthing that follows
_lvm=${_lv%%.*}
# Handle unsupported laravel versions
if (( _lvm < 5 || _lvm > 8 )); then
  echo "WARNING: Laravel version $_lvm is not supported" | tee -a $_log
  echo "Setting Laravel version to the default of $_lv_default"
fi

echo "BEGIN: Scaffolding Laravel Project" | tee -a $_log
echo "  Creating Laravel $_lv project scaffolding in $_scaff_dest" | tee -a $_log
composer create-project --prefer-dist laravel/laravel "$_scaff_name" "$_lv"

_exitcode=$?
if [ $_exitcode -ne 0 ]; then
  >&2 echo "  ERROR $?: failed to create Laravel $_lv project scaffolding in $_scaff_dest" | tee -a $_log
else
  chown -R gitpod:gitpod "$_scaff_dest"
  cd "$_scaff_dest" || exit 1
  echo "  SUCCESS: $(php artisan --version) project scaffolding created in $_scaff_dest" | tee -a $_log

  # Handle optional install of phpmyadmin
  install_phpmyadmin=$(. /tmp/utils.sh parse_ini_value /tmp/starter.ini phpmyadmin install);
  if [[ $install_phpmyadmin -eq 1 ]]; then
    echo "  Installing phpmyadmin"  | tee -a $_log
    cd "$_scaff_dest/public" && composer create-project phpmyadmin/phpmyadmin
    _exitcode_phpmyadmin=$?
    if [ $_exitcode_phpmyadmin -eq 0 ]; then
      chown -R gitpod:gitpod "$_scaff_dest/public/phpmyadmin"
      echo "  SUCCESS: phpmyadmin installed to $_scaff_dest/public"  | tee -a $_log
    else
      >&2 echo "  ERROR $?: phpmyadmin failed to install" | tee -a $_log
    fi
  fi
fi
echo "END: Scaffolding Laravel Project" | tee -a $_log
