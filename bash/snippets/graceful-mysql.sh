# Graceful handling of MySql: Prompts the user for a long wait while MySql initializes on the first run.
# NOTE: The environment variable MYSQL_INIT should be set in your .gitpod.Dockerfile.
if [[ ! -v MYSQL_INIT ]]; then
  /etc/mysql/mysql-bashrc-launch.sh
elif [[ -z "$MYSQL_INIT" ]]; then
  /etc/mysql/mysql-bashrc-launch.sh
else
  . /etc/mysql/spinner.sh &&
  start_spinner "Initializing MySql, this may take a few moments." &&
  /etc/mysql/mysql-bashrc-launch.sh &&
  stop_spinner $? &&
  unset MYSQL_INIT
fi

