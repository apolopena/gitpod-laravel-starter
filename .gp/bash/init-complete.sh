#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init-complete.sh
# Description:
# Code to be run just once at the very end of workspace initialization.
# 
# Notes:
# Always call this file last from the 'init' command in .gitpod.yml

# routes/web.php injection
allow_mixed_web=$(bash .gp/bash/utils.sh parse_ini_value starter.ini laravel allow_mixed_web)
[[ $allow_mixed_web != 0 ]] && bash .gp/bash/directives/allow-mixed-web.sh

# Summarize results
bash .gp/bash/helpers.sh show_first_run_summary
echo -e "\e[38;5;194mIf everything looks good in the above results then push any new\nproject files to your git repository. Your project is ready to code.\e[0m"

# Persist the workspace-init.log since the .gitpod.Dockerfile will wipe it out and it wont come back after the first run
bash .gp/bash/helpers.sh persist_file /var/log/workspace-init.log

# Set initialized flag - Keep this at the bottom of the file
bash .gp/bash/helpers.sh mark_as_inited
gp sync-done gitpod-inited
