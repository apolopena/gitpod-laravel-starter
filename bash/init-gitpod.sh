#!/bin/bash
printf "\033c"
echo "Results of building the workspace image ➥"
cat /var/log/workspace-image.log
echo -e "\nMoving Laravel project from ~/temp-app to $GITPOD_REPO_ROOT ..."
shopt -s dotglob
mv --no-clobber ~/test-app/* $GITPOD_REPO_ROOT
RESULT=$?
if [ $? -ne 0 ]; then
  >&2 echo "ERROR: Failed to move Laravel project from ~/temp-app to $GITPOD_REPO_ROOT"
else
  echo "SUCCESS: moved Laravel project from ~/temp-app to $GITPOD_REPO_ROOT"
fi
mv ~/test-app/README.md $GITPOD_REPO_ROOT/README_LARAVEL.md
rmdir ~/test-app
echo -e 'alias debug-on="gp preview \"$(gp url 8000)?XDEBUG_SESSION_START=1\""' >> ~/.bash_profile
echo -e 'alias debug-off="gp preview \"$(gp url 8000)?XDEBUG_SESSION_STOP=1\""' >> ~/.bash_profile
source ~/.bash_profile
echo "If the above results are successful then make sure to add, commit and push the changes to your git repository."