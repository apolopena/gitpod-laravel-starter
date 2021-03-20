#!/bin/bash
#
# change-passwords.sh
#
# Description:
# changes passwords for phpmyadmin from the defaults in version control to the values set in .starter.env
# Author: Apolo Pena
#
# NOTE:
# This script should be always run at least once by the user as an mandatory additional layer of security
# This script requires the file .starter.env to exist along will all the key value pairs as set 
# in example.starter.ini

# Load spinner
. bash/third-party/spinner.sh

change_phpmyadmin_passwords() {
  # Keep keys in sequence. Add new keys to the end of the array
  local keys=(PHPMYADMIN_SUPERUSER_PW PHPMYADMIN_CONTROLUSER_PW)

  local name="change_phpmyadmin_passwords"
  local err="$name ERROR:"
  local all_zeros='^0$|^0*0$'
  local exit_codes
  local values

  for key in ${keys[@]}; do
    local value="$(bash bash/helpers.sh get_starter_env_val $key)"
    values+=("$(bash bash/helpers.sh get_starter_env_val $key)")
    local code="$?"
    exit_codes+=$code
    # show error message of called function
    [ $code != 0 ] && echo "$value\n"
  done

  if [[ ! $(echo ${exit_codes[@]} | tr -d '[:space:]') =~ $all_zeros ]]; then
    echo "$err retrieving values, no passwords were changed."
    exit 1
  fi

  # Values have been set and there are no errors so far so change passwords
  i=0
  for key in ${keys[@]}; do
    case $key in
      "${keys[0]}")
        msg="Changing password for phpmyadmin user 'pmasu' to the value found in .starter.env"
        start_spinner "$msg"
        mysql -e "ALTER USER 'pmasu'@'localhost' IDENTIFIED BY '${values[$i]}'; FLUSH PRIVILEGES;"
        stop_spinner $?
        ;;
      "${keys[1]}")
        msg="Changing password for phpmyadmin user 'pma' to the value found in .starter.env"
        start_spinner "$msg"
        mysql -e "ALTER USER 'pma'@'localhost' IDENTIFIED BY '${values[$i]}'; FLUSH PRIVILEGES;"
        stop_spinner $?
        ;;
      *)
        echo "$err unidentified key $value"
        ;;
    esac
    ((i++))
  done
}

echo "$(change_phpmyadmin_passwords)"


