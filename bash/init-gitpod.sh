#!/bin/bash
shopt -s dotglob
mv -f ~/test-app/* $GITPOD_REPO_ROOT
rmdir ~/test-app
cat /var/log/workspace-image.log