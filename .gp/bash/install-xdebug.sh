#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# install-xdebug.sh
# Description:
# Installs xdebug from source
#
# Notes:
# This script assumes it is being run from .gitpod.Dockerfile as a sudo user
# and that all of this scripts dependencies have already been copied to /tmp
# If you change this script you must force a rebuild of the docker image
#
# For xdebug version compatibility with PHP see https://xdebug.org/docs/compat

xdebug_version='3.1.2'
xdebug_binary_url="http://xdebug.org/files/xdebug-$xdebug_version.tgz"
xdebug_ext_path="$(php -r 'echo ini_get("extension_dir");')/xdebug.so"
php_version="$(. /tmp/utils.sh parse_ini_value /tmp/starter.ini PHP version)"
log='/var/log/workspace-image.log'
msg="Compiling and installing xdebug $xdebug_version from $xdebug_binary_url"

xdebug_zend_ext_conf() {
  # shellcheck disable=SC2028
  echo "\nzend_extension = $xdebug_ext_path\n[XDebug]\nxdebug.client_host = 127.0.0.1\nxdebug.client_port = 9009\nxdebug.log = /var/log/xdebug.log\nxdebug.mode = debug\nxdebug.start_with_request = trigger\n"
}

echo "BEGIN: $msg" | tee -a $log
echo -e "; configuration for xdebug
; priority=20
$(xdebug_zend_ext_conf)" > "/etc/php/$php_version/mods-available/20-xdebug.ini"
ec=$?
[[ $ec -eq 0 ]] || 2>&1 echo "  ERROR $ec: could not generate xdebug zend ext conf to file /etc/php/$php_version/mods-available/xdebug.ini" | tee -a $log
# Generate php-fpm conf
php-fpm_conf "$php_version" 
wget "$xdebug_binary_url" \
&& tar -xvzf "xdebug-$xdebug_version.tgz" \
&& cd "xdebug-$xdebug_version" \
&& /usr/bin/phpize7.4 \
&& ./configure --enable-xdebug \
&& make \
&& sudo cp modules/xdebug.so "$xdebug_ext_path" \
&& sudo bash -c "echo -e \"$(xdebug_zend_ext_conf)\" >> \"/etc/php/$php_version/cli/php.ini\"" \
&& sudo bash -c "echo -e \"$(xdebug_zend_ext_conf)\" >> \"/etc/php/$php_version/apache2/php.ini\"" \
&& sudo ln -s "/etc/php/$php_version/mods-available/20-xdebug.ini" "/etc/php/$php_version/fpm/conf.d"
ec=$?
if [[ $ec -eq 0 ]]; then
  echo "  SUCCESS: $msg" | tee -a $log
else 
  2>&1 echo "  ERROR $ec: $msg" | tee -a $log
fi
echo "END: $msg" | tee -a $log

