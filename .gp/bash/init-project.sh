#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init-gitpod.sh
# Description:
# Initial configuration for an existing phpmyadmin installation.


# Load logger
. .gp/bash/workspace-init-logger.sh

# BEGIN example code block - migrate database
# COMMENT: Load spinner
# . .gp/bash/spinner.sh
# __migrate_msg="Migrating database"
# log_silent "$__migrate_msg" && start_spinner "$__migrate_msg"
# php artisan migrate
# err_code=$?
# if [ $err_code != 0 ]; then
#  stop_spinner $err_code
#  log -e "ERROR: Failed to migrate database"
# else
#  stop_spinner $err_code
#  log "SUCCESS: migrated database"
# fi

# BEGIN example code block - migrate database

