#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2022 Apolo Pena
#
# open-preview.sh
# Description:
# Conditionally opens an integrated preview browser
# either to the web root if no argument is passed in
# or to the specified path segment if $1 is passed in
# Can take a port option to open a specific port, for example op -3005
# In the case of using the port option, the path segment to open will be $2

function help() {
  echo "Command line interface for opening the preview browser
Requires the Gitpod binary: gp

Usage:
  op
  op [-h |--help]
  op [-PORT]
  op [-PORT][PATH]
  op [PATH]

  Options:
    -h  --help   Display this help and exit

    -PORT        The valid port number to open
                 If you want to open a specific port, this must be the first argument.

    PATH         The web root path segment to open
                 The web root will be opened if no PATH is given
                 Cannot contain a leading slash

  Notes:
    If no -PORT is given, the default port (as set in starter.ini) will be used.
      In starter.ini if default_server=nginx: default port is 8002
      In starter.ini if default_server=apache: default port is 8001
      In starter.ini if default_server=php: default port is 8000
    PORT numbers must start with a dash like: -3005

  Examples:
    Open a preview of the web root using the default port: 
        op
    Open a preview of the web root on port 3005:
        op -3005
    Open the phpmyadmin folder relative to the web root on the default port:
        op phpmyadmin
    Open the foo/bar/baz folder relative to the web root on port 3005:
        op -3005 foo/bar/baz 
"  
}

function valid_path() {
  [[ ${1:0:1} == '/' ]] && echo "ERROR: PATH $1 cannot have a leading slash" && return 1
  return 0

}

function main() {
  local rp="$GITPOD_REPO_ROOT/.gp/"
  local path port errchk

  [[ $1 == '-h' || $1 == '--help' ]] && help && exit 0

  if [[ $1 =~ ^-[1-9][0-9]+$ ]]; then
    port="${1:1}"
    if ! valid_path "$2"; then exit 1; fi
    path="/$2"
  else
    if ! valid_path "$1"; then exit 1; fi
    path="/$1"
    [[ ${path:1:1} == '-' ]] && echo "ERROR: Invalid option ${path#?}" && exit 1
    [[ -f "$rp/bash/helpers.sh" ]] &&  port=$(bash "$rp/bash/helpers.sh" get_default_server_port)
  fi

  [[ -z $port ]] &&
    echo "WARNING: Could not derive the default port, using port 8001 instead." &&
    port=8001
  errchk="$(whereis gp)" && [[ ${#errchk} == 3 ]] && echo "ERROR: no gp binary found" && exit 1

  if [[ $(bash "$rp/bash/helpers.sh" is_inited) == 0 ]]; then
    # shellcheck disable=SC1090,SC1091
    . "$rp/bash/spinner.sh" &&
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