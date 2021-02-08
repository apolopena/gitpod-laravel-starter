#!/bin/bash

# Note: always call this file last from the init command in .gitpod.yml

# Summarize results
bash bash/helpers.sh show_first_run_summary
echo -e "\e[38;5;194mIf everything looks good in the above results then push the newly created\n project files to your git repo and get started coding your project\e[0m"

# Persist the workspace-init.log since the .gitpod.Dockerfile will wipe it out and it wont come back after the first run
bash bash/helpers.sh persist_file /var/log/workspace-init.log

# Set initialized flag - Keep this at the bottom of the file
bash bash/helpers.sh mark_as_inited