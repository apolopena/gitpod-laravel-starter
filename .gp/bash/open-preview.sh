#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# open-preview.sh
# Description:
# Conditionally opens an integrated preview browser
# either to the web root if no argument is passed in
# or to the specified path segment if $1 is passed in
# Can take a port option to open a specific port, for example op -3005
# In the case of using the port option, the path segment to open will be $2

[[ $(pwd) != "$GITPOD_REPO_ROOT" ]] &&
echo -e "\e[1;31mThis command can only be run from the project root of a gitpod workspace:\e[0m $GITPOD_REPO_ROOT" &&
exit 1

function main() {
  local path port
  [[ $1 == '-h' || $1 == '--help' ]] && cat .gp/snippets/messages/op-help.txt && exit 0
  if [[ $1 =~ ^-[1-9][0-9]+$ ]]; then
    port="${1:1}"
    path="/$2"
  else
    path="/$1"
    port=$(bash .gp/bash/helpers.sh get_default_server_port)
  fi
  if [[ $(bash .gp/bash/helpers.sh is_inited) == 0 ]]; then
    . .gp/bash/spinner.sh &&
    start_spinner "Opening preview when system is ready..."
    gp sync-await gitpod-inited &&
    stop_spinner 0 &&
    gp await-port "$port" &&
    gp preview "$(gp url "$port")$path" > /dev/null 2>&1
  else
    gp preview "$(gp url "$port")$path" > /dev/null 2>&1
  fi;
}

main "$@"