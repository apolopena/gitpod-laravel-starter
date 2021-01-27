#!/bin/bash
if [[ ! -v MYSQL_INIT ]]; then
    #echo "MYSQL_INIT is not set"
    /etc/mysql/mysql-bashrc-launch.sh
elif [[ -z "$MYSQL_INIT" ]]; then
    echo "MYSQL_INIT is set to the empty string"
else
    #echo "MYSQL_INIT has the value: $MYSQL_INIT"
    . /etc/mysql/spinner.sh && start_spinner "Initializing MySql, this may take a moment."
    /etc/mysql/mysql-bashrc-launch.sh
    stop_spinner $?
    unset MYSQL_INIT
fi
