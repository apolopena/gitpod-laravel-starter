#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init-react-example.sh
# Description:
# Initial setup for the gitpod-laravel-starter Vue example.

# Load logger
. .gp/bash/workspace-init-logger.sh

lvm=$(bash .gp/bash/helpers.sh laravel_major_version)
# Failsafe for unsupported versions
(( lvm < 6 )) && exit 1

declare -a exit_codes=()
all_zeros='^0$|^0*0$'
task_msg="Setting up Vue example: Material Dashboard"

log "$task_msg"

if (( lvm > 6 )); then
  composer require laravel-frontend-presets/material-dashboard
else
  composer require laravel-frontend-presets/material-dashboard v1.0.9
fi
exit_codes+=($?)
php artisan ui material
exit_codes+=($?)
composer dump-autoload
exit_codes+=($?)
php artisan migrate
exit_codes+=($?)
php artisan migrate --seed

if [[ $(echo "${exit_codes[@]}" | tr -d '[:space:]') =~ $all_zeros ]]; then
  log "SUCCESS: $task_msg"
else
  log -e "ERROR: $task_msg"
fi