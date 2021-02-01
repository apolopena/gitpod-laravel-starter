#!/bin/bash
apachectl start && multitail /var/log/apache2/access.log -I /var/log/apache2/error.log