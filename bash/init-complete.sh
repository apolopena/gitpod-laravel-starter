#!/bin/bash

$workspace_log="/var/log/workspace-init.log"
$init_log="/var/log/workspace-init.log"
echo -e "\nALL DONE\n"
sleep 3
echo "Results of building the workspace image $workspace_log ➥"
cat $workspace_log
echo ''
echo "Showing a summary of key initialization actions taken. This data can be found here: $init_log\n"
cat $log_file | less