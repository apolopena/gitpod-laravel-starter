#!/bin/bash

# helpers.sh
# Author: Apolo Pena
# Description: A variety of useful functions with that depend on gitpod other
# binaries, aliases and functions in .bashrc 
# other than coreutils.
# Note: Do not execute this script witout calling a function from it
#
# Usage: bash <function name> arg1 arg2 arg3 ...
# 

version () {
  echo "helpers.sh version 0.0.1"
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
  # Bump the value of the defualt_server in starter.ini to lowercase
  server=$(echo "$(bash utils.sh parse_ini_value $GITPOD_REPO_ROOT/starter.ini development default_server)" | tr '[:upper:]' '[:lower:]') 
  if [ -z "$server" ]; then
    [ "$server" == 'apache' ] && start_apache && return
    [ "$server" == 'php' ] && start_php_dev && return
    echo "$err invalid default server: $server. Check the file $GITPOD_REPO_ROOT/starter.ini"
    return
  else
    case $(echo "$1" | tr '[:upper:]' '[:lower:]') in
      "php")
        start_php_dev
      "apache")
        start_apache
        ;;
      *)
        echo "$err invalid server type: $1"
        ;;
    esac
  fi
}


