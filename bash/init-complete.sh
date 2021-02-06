#!/bin/bash

$workspace_log='/var/log/workspace-image.log'
$init_log='/var/log/workspace-init.log'
echo -e "\nALL DONE\n"
echo "Results of building the workspace image $workspace_log ➥"
cat /var/log/workspace-image.log
echo ''
echo "Results of the gitpod initialization  ➥"
cat /var/log/workspace-init.log