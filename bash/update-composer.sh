#!/bin/bash

LOG='/var/log/workspace-image.log'
# BEGIN: update composer to the latest version
echo '\nPurging existing version of composer...' | tee -a $LOG
sudo apt-get --assume-yes purge composer
COMP_PURGE=$?
if [ $COMP_PURGE -ne 0 ]; then
  echo "ERROR: failed to purge existing version of composer." | tee -a $LOG
else
  echo "SUCCESS: purged existing version of composer." | tee -a $LOG
fi
echo 'Installing latest version of composer...'
EXPECTED_CHECKSUM="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
    >&2 echo 'ERROR: Invalid installer checksum - failed to install latest version of composer.' | tee -a $LOG
    rm composer-setup.php
else
  php composer-setup.php --install-dir=/usr/bin --filename=composer
  COMP_VAL=$?
  if [ $COMP_VAL -ne 0 ]; then
    echo "ERROR $COMP_VAL: Failed to install latest version of composer." | tee -a $LOG
  else
    echo "SUCCESS: latest version of composer installed." | tee -a $LOG
  fi
  rm composer-setup.php
fi
# END: update composer to the latest version