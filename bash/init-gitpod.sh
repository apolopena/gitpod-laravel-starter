#!/bin/bash
printf "\033c"

shopt -s dotglob
mv -f ~/test-app/* $GITPOD_REPO_ROOT
rmdir ~/test-app

sed -i "s|APP_URL=|APP_URL=${GITPOD_WORKSPACE_URL}|g" .env
sed -i "s|APP_URL=https://|APP_URL=https://8000-|g" .env

echo "Results of building the workspace image:"
cat /var/log/workspace-image.log
echo "\nMake sure you add, commit and push to your repo."