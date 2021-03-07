#!/bin/bash

# Gitpod currently does not persist files in the home directory so we must write them 
# in everytime the workspace starts. We do this in the  -before task in .gitpod.yml

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

# Rake tasks (will be written to ~/.rake).
# Some rake tasks are dynamic and depend on the configuration in starter.ini
msg="Writing rake tasks"
log "$msg..." &&
bash bash/init-rake-tasks.sh &&
if [ $? == 0 ]; then
  log "SUCCESS: $msg"
else
  log "ERROR: $msg" -e
fi

# Aliases for git
msg="git aliases have been written"
bash bash/utils.sh add_file_to_file_after \\[alias\\] bash/snippets/emoji-log ~/.gitconfig &&
bash bash/utils.sh add_file_to_file_after \\[alias\\] bash/snippets/git-aliases ~/.gitconfig &&
log "$msg" &&
log "try: git a    or: git aliases    to see what has been written.\n"

# grc color configuration for apache logs
msg="Creating grc color configuration file for apache logs"
log "$msg..." &&
cat bash/snippets/grc/apache-log-colors > ~/apache-log-colors.conf &&
if [ $? == 0 ]; then
  log "SUCCESS: $msg"
else
  log "ERROR: $msg" -e
fi

if [ $(bash bash/helpers.sh is_inited) == 1 ]; then
  bash bash/helpers.sh restore_persistent_files $GITPOD_REPO_ROOT
fi