#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# hot-reload.sh
# Description:
# One-time setup script for hot reloading functionality using browser-sync

. .gp/bash/workspace-init-logger.sh
. .gp/bash/spinner.sh

c_red='\e[38;5;124m'
c_orange='\e[38;5;208m'
c_green='\e[38;5;76m'
c_blue='\e[38;5;147m'
c_hot_pink="\e[38;5;213m"
c_end='\e[0m'

pass_msg() {
  echo -e $c_green"SUCCESS$c_end:$c_end $1"
}
fail_msg() {
  echo -e $c_red"ERROR $c_end$c_blue$(readlink -f $0)$c_end$c_red:$c_end$c_orange $1"$c_end
}
main_msg="$c_hot_pink""Setting up hot reload system$c_end"
echo -e "$main_msg"
# Install browser-sync packages
if [[ ! -f node_modules/browser-sync/LICENSE ]]; then
  msg="Installing browser-sync packages..."
  start_spinner "$msg"
  yarn add browser-sync browser-sync-webpack-plugin  --silent --dev 2> >(grep -v warning 1>&2) > /dev/null 2>&1
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
file=webpack.mix.js
snippet=.gp/snippets/laravel/webpack/browser-sync.snippet
msg="Injecting $file file..."
if [[ -e $file ]]; then
  [[ ! -e $snippet ]] && fail=1 && e_msg="Missing injection file $snippet"
  if ! grep -q "Injected from $snippet" "$file"; then
    start_spinner "$msg" && sleep .5
    cat "$snippet" >> "$file" 2> /dev/null
    exit_code=$?
    if [[ $exit_code -ne 0  || $fail -eq 1 ]]; then 
      [[ $fail -eq 1 ]] && msg=$e_msg
      stop_spinner 1 "\b \n$(fail_msg "$msg")"
      exit 1
    else
      stop_spinner 0 "\b \n$(pass_msg "$msg")"
    fi # end check success or failure
  else
    pass_msg "$file has already been injected"
  fi # end grep check if file is already injected
else
  start_spinner "$msg"
  sleep .5
  stop_spinner 1 "\b \n$(fail_msg "no $file file to inject")"
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

