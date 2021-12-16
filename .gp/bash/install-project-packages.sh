#!/bin/bash
# shellcheck source=/dev/null
#
# SPDX-License-Identifier: MIT
# Copyright © 2021 Apolo Pena
#
# install-project-packages.sh
# Description:
# Installs core packages, an optional PHP version as per starter.ini
# and any other additional project specific packages a user may require
#
# Notes:
# This script assumes it is being run from .gitpod.Dockerfile and
# that all of this scripts dependencies have already been copied to /tmp
# If you change this script you must force a rebuild of the docker image

# Put any additional packages you would like to install for the project here in single quotes delimited by a space
additional_packages=

log='/var/log/workspace-image.log'
core='rsync grc shellcheck'
php7_4='php7.4 php7.4-fpm php7.4-dev php7.4-bcmath php7.4-ctype php7.4-curl php-date php7.4-gd php7.4-intl php7.4-json php7.4-mbstring php7.4-mysql php-net-ftp php7.4-pgsql php7.4-sqlite3 php7.4-tokenizer php7.4-xml php7.4-zip'
latest_php="$(. /tmp/utils.sh php_version)"

echo "BEGIN: installing project packages" | tee -a $log
php_version=$(. /tmp/utils.sh parse_ini_value /tmp/starter.ini PHP version)
ec=$?
if [[ $ec -ne 0 ]]; then
  2>&1 echo "  WARNING: could not parse /tmp/starter.ini. Defaulting PHP version to 'latest'" | tee -a $log
  php_version='latest'
fi

if [[ $php_version == '7.4' ]]; then
  all_packages="$core $php7_4 $additional_packages"
else
  [[ $php_version == 'latest' ]] || echo "  WARNING: unsupported or invalid PHP version value $php_version found in /tmp/starter.ini. Defaulting PHP version to 'latest'" | tee -a $log
  all_packages="$core php$latest_php-fpm $additional_packages"
fi

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections \
  && sudo apt-get update -q \
  && sudo apt-get -yq install "$all_packages"
ec=$!
if [[ $ec -ne 0 ]]; then
  >&2 echo "  ERROR: failed while installing: $all_packages" | tee -a $log
else
  [[ "$php_version" == "7.4" ]] && sudo update-alternatives --set php /usr/bin/php7.4
  sudo apt-get clean
  echo "  SUCCESS: installing project packages: $all_packages" | tee -a $log
fi

echo "END: installing project packages" | tee -a $log

