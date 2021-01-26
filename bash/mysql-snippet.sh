if [ $MYSQL_INIT -ne 0 ]; then
  . /etc/mysql/spinner.sh && start_spinner "Initializing MySql, this may take a moment." >> ~/.bashrc
fi
echo "/etc/mysql/mysql-bashrc-launch.sh" >> ~/.bashrc
if [ $MYSQL_INIT -ne 0 ]; then
  echo "stop_spinner $?" >> ~/.bashrc
  export MYSQL_INIT=0
fi
