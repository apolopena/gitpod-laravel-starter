#!/bin/bash

# BEGIN: update composer to the latest version
echo 'UPDATING COMPOSER: removing existing version composer'
sudo apt-get --assume-yes purge composer
echo 'UPDATING COMPOSER: installing latest version of composer'
EXPECTED_CHECKSUM="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
    >&2 echo 'ERROR: Invalid installer checksum - could not update composer'
    rm composer-setup.php
else
  php composer-setup.php --install-dir=/usr/bin --filename=composer
  RESULT=$?
   if [$? -ne 0]
   then
    echo "ERROR $RESULT: Installing the latest version of composer, FAILED."
   else
    echo "SUCCESS: latest version of composer was installed"
   fi
  rm composer-setup.php
fi
# END: update composer to the latest version