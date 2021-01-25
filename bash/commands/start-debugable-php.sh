#!/bin/bash
# Depends on gitpod binaries
php -S 127.0.0.1:8000 -t public/  & php_pid=$!; sleep 5;  wait $php_pid; gp preview $(gp url 8000)

