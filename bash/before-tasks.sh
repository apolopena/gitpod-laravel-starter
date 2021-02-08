#!/bin/bash

# Gitpod currently does not persist files in the home directory so we must write them 
# in everytime the workspace starts. We do this in the  -before task in .gitpod.yml

# Log to the console and a file
echo "before task: GITPOD_REPO_ROOT is $GITPOD_REPO_ROOT, GITPOD_WORKSPACE_ID is $GITPOD_WORKSPACE_ID"
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
#log "$msg" &&
bash bash/init-rake-tasks.sh

# Aliases for git
msg="Writing git aliases"
#log "$msg" &&
bash bash/utils.sh add_file_to_file_after \\[alias\\] bash/snippets/emoji-log ~/.gitconfig &&
bash bash/utils.sh add_file_to_file_after \\[alias\\] bash/snippets/git-aliases ~/.gitconfig
#log "try: git a    or: git aliases    for a list your git aliases.\n"

# compare to zero for testing this on the first run, put it back to 1 once it works
if [ $(bash bash/helpers.sh is_inited) == 0 ]; then
  sudo bash bash/helpers.sh restore_persistant_files $GITPOD_REPO_ROOT
fi