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
if [ "$(bash bash/utils.sh parse_ini_value starter.ini github-changelog-generator install)" ]; then
  msg="Writing rake tasks"
  log "$msg..." &&
  bash bash/init-rake-tasks.sh
  if [ $? == 0 ]; then 
    log "SUCCESS: $msg"
  else
    log "ERROR: $msg" -e
  fi
fi


# Aliases for git
msg="\ngit aliases have been written"
bash bash/utils.sh add_file_to_file_after \\[alias\\] bash/snippets/emoji-log ~/.gitconfig &&
bash bash/utils.sh add_file_to_file_after \\[alias\\] bash/snippets/git-aliases ~/.gitconfig &&
log "$msg" &&
log "\ntry: git a    or: git aliases\nto see what is available.\n"

# grc color configuration for apache logs
msg="Creating grc color configuration file for apache logs: ~/apache-log-colors.conf"
log "$msg..." &&
cat bash/snippets/grc/apache-log-colors > ~/apache-log-colors.conf
if [ $? == 0 ]; then
  log "SUCCESS: $msg"
else
  log "ERROR: $msg" -e
fi

# Keep this at the bottom of the file
# Restores files marked as persistant
# See persist_file in bash/helpers.sh 
if [ $(bash bash/helpers.sh is_inited) == 1 ]; then
  bash bash/helpers.sh restore_persistent_files $GITPOD_REPO_ROOT
fi