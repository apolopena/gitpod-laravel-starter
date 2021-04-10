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

# Load spinner
. .gp/bash/spinner.sh
__path=
[[ -n  $1 ]] && __path=/$1
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