#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init-complete.sh
# Description:
# Tasks to be run everytime a gitpod workspace is created or started.
# 
# Notes:
# Always call this file last from the 'init' command in .gitpod.yml

# Summarize results
bash bash/helpers.sh show_first_run_summary
echo -e "\e[38;5;194mIf everything looks good in the above results then push any new\nproject files to your git repository. Your project is ready to code.\e[0m"

# Persist the workspace-init.log since the .gitpod.Dockerfile will wipe it out and it wont come back after the first run
bash bash/helpers.sh persist_file /var/log/workspace-init.log

# Set initialized flag - Keep this at the bottom of the file
bash bash/helpers.sh mark_as_inited
gp sync-done gitpod-inited
