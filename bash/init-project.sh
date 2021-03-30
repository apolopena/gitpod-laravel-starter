#!/bin/bash

# Load logger
. workspace-init-log.sh

# BEGIN example code block - migrate database
# COMMENT: Load spinner
# . bash/third-party/spinner.sh
# __migrate_msg="Migrating database"
# log_silent "$__migrate_msg" && start_spinner "$__migrate_msg"
# php artisan migrate
# err_code=$?
# if [ $err_code != 0 ]; then
#  stop_spinner $err_code
#  log "ERROR: Failed to migrate database" -e
# else
#  stop_spinner $err_code
#  log "SUCCESS: migrated database"
# fi

# BEGIN example code block - migrate database

