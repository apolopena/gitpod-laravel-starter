#!/bin/bash

# Log to the console and a file
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

if [[ $(echo ${exit_codes[@]} | tr -d '[:space:]') =~ $all_zeros ]]; then
  log "SUCCESS: $task_msg"
else
  log "ERROR: $task_msg"
fi




