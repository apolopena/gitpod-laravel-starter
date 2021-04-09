#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# open-preview.sh
# Description:
# Conditionally opens an integrated preview browser.

# Load spinner
. .gp/bash/spinner.sh

__port=$(bash .gp/bash/helpers.sh get_default_server_port)
if [[ $(bash .gp/bash/helpers.sh is_inited) == 0 ]]; then
  . .gp/bash/spinner.sh &&
  start_spinner "Opening preview when system is ready..."
  gp sync-await gitpod-inited &&
  stop_spinner 0 &&
  gp await-port "$__port" &&
  gp preview "$(gp url "$__port")"
else
  gp preview "$(gp url "$__port")"
fi;