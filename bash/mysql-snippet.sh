#!/bin/bash
if [[ ! -v MYSQL_INIT ]]; then
    #echo "MYSQL_INIT is not set"
    /etc/mysql/mysql-bashrc-launch.sh
elif [[ -z "$MYSQL_INIT" ]]; then
    echo "MYSQL_INIT is set to the empty string"
else
    . /etc/mysql/spinner.sh && start_spinner "Initializing MySql, this may take a few moments." && /etc/mysql/mysql-bashrc-launch.sh && stop_spinner $? && unset MYSQL_INIT
fi
