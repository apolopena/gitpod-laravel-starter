#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# hot-reload.sh
# Description:
# Intelligent hot reload using browser-sync and Laravel Mix
# setup, start, stop, refresh and help commands for the public API

# shellcheck source=.gp/bash/spinner.sh
. "$GITPOD_REPO_ROOT"/.gp/bash/spinner.sh

c_red='\e[38;5;124m'
c_orange='\e[38;5;208m'
c_green='\e[38;5;76m'
c_blue='\e[38;5;147m'
c_hot_pink="\e[38;5;213m"
c_end='\e[0m'

injection_file="$GITPOD_REPO_ROOT"/webpack.mix.js
snippet=.gp/snippets/laravel/webpack/browser-sync.snippet

pass_msg() {
  echo -e "$c_green""SUCCESS$c_end:$c_end $1"
}

fail_msg() {
  local msg script_path prefix
  if [[ $1 == '--omit-path' ]]; then
    msg="$2"
    prefix="ERROR"
  else
    msg="$1"
    prefix="ERROR "
    script_path=$(readlink -f "$0")
  fi
  echo -e "$c_red$prefix$c_end$c_blue$script_path$c_end$c_red:$c_end$c_orange $msg$c_end"
}

setup() {
  local snippet_file="$GITPOD_REPO_ROOT/$snippet"
  local main_msg="$c_hot_pink""Setting up hot reload system$c_end"
  echo -e "$main_msg"
  # Install browser-sync packages
  if [[ ! -f $GITPOD_REPO_ROOT/node_modules/browser-sync/LICENSE ]]; then
    msg="Installing browser-sync packages..."
    start_spinner "$msg"
    yarn add browser-sync browser-sync-webpack-plugin  --silent 2> >(grep -v warning 1>&2) > /dev/null 2>&1
    exit_code=$?
    if [[ $exit_code == 0 ]]; then
      stop_spinner $exit_code "\b \n$(pass_msg "$msg")"
    else
      stop_spinner $exit_code "\b \n$(fail_msg "$msg")"
      exit 1
    fi
  else
    pass_msg "Browser-sync packages have already been installed"
  fi
  # Inject webpack.mix.js
  msg="Injecting $injection_file file"
  if [[ -e $injection_file ]]; then
    [[ ! -e $snippet_file ]] && fail=1 && e_msg="Missing injection file $snippet_file"
    if ! grep -q "Injected from $snippet" "$injection_file"; then
      start_spinner "$msg..." && sleep .5
      cat "$snippet" >> "$injection_file" 2> /dev/null
      exit_code=$?
      if [[ $exit_code -ne 0  || $fail -eq 1 ]]; then 
        [[ $fail -eq 1 ]] && msg=$e_msg
        stop_spinner 1 "\b \n$(fail_msg "$msg")"
        exit 1
      else
        stop_spinner 0 "\b \n$(pass_msg "$msg")"
      fi # end check success or failure
    else
      pass_msg "$injection_file has already been injected"
    fi # end grep check if file is already injected
  else
    start_spinner "$msg"
    sleep .5
    stop_spinner 1 "\b \n$(fail_msg "no $injection_file file to inject")"
    exit 1
  fi
  # Run Laravel Mix, to initialize browser-sync-webpack-plugin
  msg="Running Laravel Mix..."
  start_spinner "$msg"
  if yarn run mix > /dev/null 2>&1; then
    stop_spinner 0 "\b \n$(pass_msg "$msg")"
  else
    stop_spinner 1 "\b \n$(fail_msg "$msg")"
    exit 1
  fi
  pass_msg "$main_msg"
}

start() {
  if ! check_setup start; then exit 1; fi
  if pgrep -f "^node.*yarn run watch"; then
    echo "Hot reload already in progress at $(gp "$(gp url 3005)")"
    exit 5
  fi
  yarn run watch
}

stop() {
  if ! check_setup stop; then exit 1; fi
  local pid _tty
  pid=$(pgrep -f "^node.*yarn run watch")
  if [[ -n $pid ]]; then
    _tty=$(ps "$pid" | sed -n '2 p' | grep -Po "pts\/[0-9]") &&
    pkill -2 -t "$_tty" &&
    pass_msg "Hot reload server has been stopped" &&
    exit
  fi
  fail_msg --omit-path "No Laravel Mix watch process detected"
  fail_msg --omit-path "There is no hot reload server to stop"
}

refresh() {
  local pid
  pid=$(pgrep -f "^node.*yarn run watch")
  if [[ -n $pid ]]; then
    gp preview $(gp url 3005)?bust=cache && gp preview $(gp url 3005)
    local exit_code=$?
    [[ $exit_code -eq 0 ]] && pass_msg "hot reload browser was refreshed" && exit
    fail_msg --omit-path "gp command failed, could not refresh hot reload browser" && exit
  fi
  fail_msg --omit-path "Hot reload server is not running, nothing to refresh"
}

is_setup() {
  [[ ! -f "$GITPOD_REPO_ROOT/node_modules/browser-sync/LICENSE" ]] && echo 0 && exit
  if ! grep -q "Injected from $snippet" "$injection_file"; then
    echo 0 && exit
  fi
  echo 1
}

check_setup() {
  local verb aok
  aok=$(is_setup)
  [[ $1 == 'start' ]] && verb='start'; [[ $1 == 'stop' ]] && verb='stop'
  local err_msg="Cannot $verb the hot reload server because it has not been setup. Run:$c_end hot-reload setup"
  ((aok)) && return 0 || fail_msg --omit-path "$err_msg"; return 1
}



# Call functions from this script gracefully
if declare -f "$1" > /dev/null
then
  # call arguments verbatim
  "$@"
else
  echo "hot-reload.sh: '$1' is not a known function name." >&2
  exit 1
fi

