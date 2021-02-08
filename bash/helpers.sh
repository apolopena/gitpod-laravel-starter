#!/bin/bash

# helpers.sh
# Author: Apolo Pena
# Description: A variety of useful functions with that depend on gitpod
# and other binaries, aliases and functions such as code in .bashrc
# other than coreutils.
# Note: Do not execute this script witout calling a function from it
# Additional Note: some functions use functions from .bashrc so the -i flag
# is the safest way to invoke functions from this script.
#
# Usage: bash -i <function name> arg1 arg2 arg3 ...
#

version () {
  echo "helpers.sh version 0.0.3"
}

# start_server
# Description:
# Starts up the default server or a specific server ($1)
#
# Notes:
# It is assumed that starter.ini is in the project root.
# Valid servers are: apache, php
#
# Usage:
# Example: start the default server
# start_server
start_server() {
  local usage='Usage: start_server [server-type]'
  local err='Error: start_server():'
  local server
  local s
  s=$(bash bash/utils.sh parse_ini_value starter.ini development default_server)
  # Bump the value of the default_server in starter.ini to lowercase
  server=$(echo "$s" | tr '[:upper:]' '[:lower:]')
  if [ -z "$1" ]; then
  case "$server" in
    'php')
    start_php_dev
    ;;
    'apache')
    start_apache
    ;;
    *)
    echo "$err invalid default server: $server. Check the file $GITPOD_REPO_ROOT/starter.ini"
    ;;
  esac
  else
  echo $(echo "$1" | tr '[:upper:]' '[:lower:]')
  case $(echo "$1" | tr '[:upper:]' '[:lower:]') in
    'php')
    start_php_dev
    ;;
    'apache')
    start_apache
    ;;
    *)
    echo "$err invalid server type: $1"
    ;;
  esac
  fi
}

# add_global_rake_task
# Description:
# Writes a rake task multiline string ($1) to a file named by the command ($2) in ~/.rake
#
# Notes:
# Depending on how the task is written you may need to
# invoke a global rake task using the -g flag like so: rake -g hello-world
# Do not use the .rake suffic in your command. The rake file name will
# automatically written as to "$2.rake"
# Any exisitng rake command in ~/.rake will be clobbered.
#
# Usage:
# Example: a dynamically created hello world rake task
# # create a safe multiline string (with variable interpolation) to pass to add_global_rake_task
# name='Apolo'
# rake_task_name='hello'
# IFS='' read -r -d '' __task <<EOF
# task "$rake_task_name" do
#    puts "Hello $name, this is a global rake task"
# end
# EOF
# bash bash/helpers.sh add_global_rake_task "$__task" "$rake_task_name"
add_global_rake_task() {
  local root=~/.rake
  local file="$2.rake"
  local err="Helpers.sh: Error: add_global_rake_task:"
  local usage="Usage: add_global_rake_task task file.rake"

  [[ -z $1 || -z $2 ]] && echo "$err requires exactly two arguments." && echo $usage && return

  mkdir -p $root
  touch -c "$root/$2"
  echo -e "$1" > "$root/$file"
}

# Begin: persistance hacks
get_store_root() {
  echo "/workspace/$(basename $GITPOD_REPO_ROOT)--store"
}

persist_file() {
  local err="helpers.sh: persist: error:"
  local store=$(get_store_root)
  local dest="$store/$(dirname ${1#/})"
  local file="$dest/$(basename "$1")"
  mkdir -p $store && mkdir -p $dest
  [ -f $1 ] && cp $1 $file || echo "$err $1 does not exist"
}

# For some reason $GITPOD_REPO_ROOT is not avaialable when this is called (from before task)
# So just pass it in from there as $1
restore_persistent_files() {
  local err="helpers.sh: restore_persistent_files: error:"
  # TODO make this dynamic
  local init_log_orig=/var/log/workspace-init.log
  local store="/workspace/$(basename $1)--store"
  local init_log="$store$init_log_orig"
  [ -e $init_log ] && cp $init_log $init_log_orig || echo "$err $init_log NOT FOUND"
}

inited_file () {
  echo "$(get_store_root)/is_inited.lock"
}

mark_as_inited() {
  local file=$(inited_file)
  local store=$(get_store_root)
  mkdir -p $(get_store_root)
  [ ! -e $file ] && touch $file
}

is_inited() {
  [ -e $(inited_file) ] && echo 1 || echo 0
}
# End: persistance hacks




# Call functions from this script gracefully
if declare -f "$1" > /dev/null
then
  # call arguments verbatim
  "$@"
else
  echo "helpers.sh: '$1' is not a known function name." >&2
  exit 1
fi
