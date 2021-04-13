#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init-react-example.sh
# Description:
# Initial setup for the gitpod-laravel-starter React example.

# Load logger
. .gp/bash/workspace-init-logger.sh

declare -a exit_codes=()
all_zeros='^0$|^0*0$'
task_msg="Setting up React example: Questions and Answers"

log "$task_msg"
curl -LJO https://github.com/apolopena/QnA-demo-skeleton/archive/refs/tags/1.0.0.tar.gz
exit_codes+=($?)
tar -xvzf QnA-demo-skeleton-1.0.0.tar.gz --strip-components=1
exit_codes+=($?)
rm QnA-demo-skeleton-1.0.0.tar.gz
exit_codes+=($?)
php artisan migrate
exit_codes+=($?)
php artisan db:seed
exit_codes+=($?)
yarn run mix
exit_codes+=($?)

if [[ $(echo "${exit_codes[@]}" | tr -d '[:space:]') =~ $all_zeros ]]; then
  log "SUCCESS: $task_msg"
else
  log -e "ERROR: $task_msg"
fi




