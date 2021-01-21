#!/bin/bash
printf "\033c"

echo "Moving Laravel project from ~/temp-app to $GITPOD_REPO_ROOT ..."
shopt -s dotglob
mv -f ~/test-app/* $GITPOD_REPO_ROOT

if [$? -ne 0]; then
  >&2 echo "ERROR: Failed to move Laravel project from ~/temp-app to $GITPOD_REPO_ROOT"
else
  echo "SUCCESS: moved Laravel project from ~/temp-app to $GITPOD_REPO_ROOT"
fi

rmdir ~/test-app

echo "Results of building the workspace image:"
cat /var/log/workspace-image.log
echo -e "\n\nIf the above results show success then make sure you add, commit and push the changes to your repo."