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

[[ $(pwd) != "$GITPOD_REPO_ROOT" ]] &&
echo -e "\e[1;31mThis command can only be run from the project root of a gitpod workspace:\e[0m $GITPOD_REPO_ROOT" &&
exit 1

. .gp/bash/spinner.sh

__path=/$1

__port=$(bash .gp/bash/helpers.sh get_default_server_port)
if [[ $(bash .gp/bash/helpers.sh is_inited) == 0 ]]; then
  . .gp/bash/spinner.sh &&
  start_spinner "Opening preview when system is ready..."
  gp sync-await gitpod-inited &&
  stop_spinner 0 &&
  gp await-port "$__port" &&
  gp preview "$(gp url "$__port")$__path" > /dev/null 2>&1
else
  gp preview "$(gp url "$__port")$__path" > /dev/null 2>&1
fi;
