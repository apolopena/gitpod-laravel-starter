#!/bin/bash

workspace_log='/var/log/workspace-image.log'
init_log='/var/log/workspace-init.log'
echo -e "\n\e[38;5;177mSUMMARY\e[0m\n"
echo "Results of building the workspace image $workspace_log ➥\n"
cat $workspace_log
echo ''
echo "Results of the gitpod initialization $init_log ➥"
cat $init_log
echo -e "\n\e[38;5;177mALL DONE\e[0m\n"
echo "If everything looks good in the above results then push the newly created project files to your git repo and get started coding your project 🚀\n"