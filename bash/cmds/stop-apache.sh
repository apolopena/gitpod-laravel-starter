#!/bin/bash
apachectl stop
mtail_apache_pid=$(ps axf | grep 'multitail /var/log/apache2/access.log -I /var/log/apache2/error.log' | grep -v grep | awk '{print $1}' | sed 1q)
kill -2 $mtail_apache_pid