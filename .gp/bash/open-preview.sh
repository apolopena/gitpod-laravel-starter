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
echo -e "\e[1;31mThis command can only be run from the project root:\e[0m $GITPOD_REPO_ROOT" &&

exit 1
# Load spinner
. .gp/bash/spinner.sh
__path=
if [[ -n  $1 ]]; then
  if [[ ! $1 =~ \/$ ]]; then
    __path=/$1/
  else
    __path=/$1
  fi
fi
__port=$(bash .gp/bash/helpers.sh get_default_server_port)
if [[ $(bash .gp/bash/helpers.sh is_inited) == 0 ]]; then
  . .gp/bash/spinner.sh &&
  start_spinner "Opening preview when system is ready..."
  gp sync-await gitpod-inited &&
  stop_spinner 0 &&
  gp await-port "$__port" &&
  gp preview "$(gp url "$__port")$__path"
else
  gp preview "$(gp url "$__port")$__path"
fi;
