#!/bin/bash
#printf "\033c"

# Bootstrap scaffolding
if [ ! -d "$GITPOD_REPO_ROOT/bootstrap" ]; then
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
  # BEGIN: Optional configurations
  installed_phpmyadmin=$(. /tmp/utils.sh parse_ini_value /tmp/starter.ini phpmyadmin install)
  if [ $installed_phpmyadmin -eq 1 ]; then
    echo "Creating phpmyadmin superuser: pmasu..."
    mysql -e "CREATE USER 'pmasu'@'%' IDENTIFIED BY '123456';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'pmasu'@'%';"
    RESULT=$?
    if [ $? -ne 0 ]; then
      >&2 echo "ERROR: failed to create phpmyadmin superuser: pmasu"
    else
      echo "SUCCESS: created phpmyadmin superuser: pmasu"
    fi
  fi
  # END: Optional configurations
  # Move and or merge necessary failes then cleanup
  (echo; cat ~/test-app/.gitignore) >> $GITPOD_REPO_ROOT/.gitignore && rm ~/test-app/.gitignore
  mv ~/test-app/README.md $GITPOD_REPO_ROOT/README_LARAVEL.md
  rmdir ~/test-app
fi

# Aliases for git 
echo "Writing git aliases..."
bash bash/utils.sh add_file_to_file_after \\[alias\\] bash/snippets/emoji-log ~/.gitconfig
bash bash/utils.sh add_file_to_file_after \\[alias\\] bash/snippets/git-aliases ~/.gitconfig
echo "Writing git aliases complete, check the log for any possible errors."
echo "try: git a    or: git aliases    for a list your git aliases."

# Aliases for .bash_profile
echo -e 'alias debug-on="gp preview \"$(gp url 8000)?XDEBUG_SESSION_START=1\""' >> ~/.bash_profile
echo -e 'alias debug-off="gp preview \"$(gp url 8000)?XDEBUG_SESSION_STOP=1\""' >> ~/.bash_profile
echo -e "alias start-apache=\"bash $GITPOD_REPO_ROOT/bash/cmds/start-apache.sh\"" >> ~/.bash_profile
echo -e "alias stop-apache=\"bash $GITPOD_REPO_ROOT/bash/cmds/stop-apache.sh\"" >> ~/.bash_profile
echo "If the above results are successful then make sure to add, commit and push the changes to your git repository."
