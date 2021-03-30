#!/bin/bash

# workspace-init-logger.sh
# Description:
# Log wrapper for logging to workspace-init.log
#
# Usage:
# . workspace-init-logger
# log "SUCCESS: Logging to workspace-init.log"
# log "ERROR: something went wrong" - e

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