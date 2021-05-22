#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# init-vue-example.sh
# Description:
# Initial setup for the gitpod-laravel-starter Vue example.

main () {
  local src="$GITPOD_REPO_ROOT"/snippets/projects/material-dashboard-example.sh
  local dest="$GITPOD_REPO_ROOT"/.gp/bash/init-project.sh
  [[ -f $src ]] && mv -f "$src" "$dest"
}
  
main