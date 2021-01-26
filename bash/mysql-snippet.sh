if [ $MYSQL_INIT -ne 0 ]; then
  . /etc/mysql/spinner.sh && start_spinner "Initializing MySql, this may take a moment."
fi
/etc/mysql/mysql-bashrc-launch.sh
if [ $MYSQL_INIT -ne 0 ]; then
  stop_spinner $?
  MYSQL_INIT=0
fi
