#!/bin/bash

# Note: allways call thi file last in the initialization sequence

workspace_log='/var/log/workspace-image.log'
init_log='/var/log/workspace-init.log'
echo -e "\n\e[38;5;171mSUMMARY 📃\e[0m\n"
echo -en "\e[38;5;194mResults of building the workspace image\e[0m \e[38;5;34m$workspace_log\e[0m ➥\n\e[38;5;183m"
cat $workspace_log
echo -en "\e[0m"
echo ''
echo -en "\e[38;5;194mResults of the gitpod initialization\e[0m \e[38;5;34m$init_log\e[0m ➥\e[38;5;39m"
cat $init_log
echo -en "\e[0m"
echo -en "\n\e[38;5;171mALL DONE 🚀\e[0m\n"
echo -e "\e[38;5;194mIf everything looks good in the above results then push the newly created\n project files to your git repo and get started coding your project\e[0m"


# Hack: Persist the workspace-init.log since the .gitpod.Dockerfile will wipe it out and it wont come back after the first run
bash bash/helpers.sh persist_file /var/log/workspace-init.log
# Set initialized flag - Keep this at the bottom of the file
bash bash/helpers.sh mark_as_inited