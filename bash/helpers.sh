#!/bin/bash

# helpers.sh
# Author: Apolo Pena
# Description: A variety of useful functions with that depend on gitpod other
# binaries, aliases and functions in .bashrc
# other than coreutils.
# Note: Do not execute this script witout calling a function from it
#
# Usage: bash -i <function name> arg1 arg2 arg3 ...
#

version () {
  echo "helpers.sh version 0.0.2"
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

# Call functions from this script gracefully
if declare -f "$1" > /dev/null
then
  # call arguments verbatim
  "$@"
else
  echo "helpers.sh: '$1' is not a known function name." >&2
  exit 1
fi