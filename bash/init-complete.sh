#!/bin/bash

$workspace_log='/var/log/workspace-image.log'
$init_log='/var/log/workspace-init.log'
echo -e "\nALL DONE\n"
sleep 3
echo "Results of building the workspace image $workspace_log ➥"
less $workspace_log
echo ''
echo "Results of the gitpod initialization  ➥"
less $init_log