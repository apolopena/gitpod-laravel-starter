#!/bin/bash

# utils.sh
# Author: Apolo Pena
# Description: A variety of useful functions with no dependecies.
# Note: Do not execute this script witout calling a function from it
#
# Usage: bash <function name> arg1 arg2 arg3 ...
#


version () {
  echo "utils.sh version 0.0.5"
}

# Use absolute paths or paths relative to this script

# check_files_exist
# Description:
# Checks if any number of files exist.
# Exits with error code 1 on the first file that does not exist.
#
# Notes:
# Pass this function any number of files as arguments.
# File paths must be absolute or relative to this script (utils.sh)
# Error code 0 if all files exist
# Error code 1 if any file doesn't exist. Function exits on the first file that doesn't exist.
# When a file does not exist a message is echoed to the console.
#
# Notes:
# The marker is a regexp expression so it must have any regexp characters in it double escaped.
#
# Usage:
# Example: check if any of these two files dont exist (assume they do exist)
# check_files_exist .bashrc .bash_profile
# outputs: all files exist
# if [ $? -eq 0 ]; then echo "all files exist"; fi
#
# Example: check if any of these three files dont exist (assume that foo.txt does not exist)
# check_files_exist .bashrc foo.txt .bash_profile
# outputs: the file foo.txt does not exist
# if [ $? -eq 0 ]; then echo "all files exist"; fi
check_files_exist () {
  for arg
  do if [ ! -f "$arg" ]; then echo ERROR: the file $arg does not exist; exit 1; fi
  done
}


# add_file_to_file_before
# Description:
# Adds the contents of file ($2) into another file ($3) before the marker ($1)
#
# Notes:
# The marker is a regexp expression so it must have any regexp characters in it double escaped.
#
# Usage:
# Example: add the contents of git-alises.txt to .gitconfig before the marker [aliases]
# add_file_to_file_before \\[alias\\] git-aliases.txt .gitconfig
#
add_file_to_file_before() {
  check_files_exist $2 $3 && if [ $? -ne 0 ]; then exit 1; fi
  awk "/$1/{while(getline line<\"$2\"){print line}} //" $3 >__tmp &&
  mv __tmp $3
}

# add_file_to_file_after
# Description:
# Adds the contents of file ($2) into another file ($3) after the marker ($1)
#
# Notes:
# The marker is a regexp expression so it must have any regexp characters in it double escaped.
#
# Usage:
# Example: add the contents of git-alises.txt to .gitconfig after the marker [aliases]
# add_file_to_file_before \\[alias\\] git-aliases.txt .gitconfig
#
add_file_to_file_after() {
  check_files_exist $2 $3 && if [ $? -ne 0 ]; then exit 1; fi
  awk "//; /$1/{while(getline<\"$2\"){print}}" $3 >__tmp
  mv __tmp $3
}

# parse_ini_value
# Description:
# Echoes the value of a variable ($3) for a name value pair under a section ($2) in an .ini file ($1)
#
# Notes:
# Comments are ignored.
# Comments are either a pound sign # or a semicolon ; at the beginning of a line.
# The name argument ($3) and the section argument ($2)
# must be simple strings with no special regex characters in them.
# If a value is not set then an empty string with be echoed.
#
# Usage:
# Example: get the value of the install variable under the section myphpadmin in the file starter.ini
# Assume the contents of starter.ini has at least this block in it.
#   [phpmyadmin]
#   ; this is a comment: install=1, do not install = 0
#   install=1
#
# parse_ini_value starter.ini phpmyadmin install
# // outputs: 1
#
parse_ini_value() {
  echo $(sed -nr '/^#|^;/b;/\['"$2"'\]/,/\[.*\]/{/\<'"$3"'\>/s/(.*)=(.*)/\2/p}' "$1")
}

# log
# Description:
# Log a message ($1) to the console and an output file ($2). Logs to stdout if no -e option ($3) is passed in.
# Logs to stdout and stderr if the -e option is passed in.
#
# Notes:
# The output file must already exist.
# Backslash escapes are interpreted in both the console
# and the output file (e.g., they are not printed literally).
#
# Usage:
# Example 1: log a standard message to the console and an output file
# log "Hello World" /var/log/test.log
#
# Example 2: log an error message to the console and an output file
# log "Hello World" /var/log/test.log -e
#
log () {
  if [[ "$3" == '-e' || "$3" == '--error' ]]; then
    >&2 echo -e "$1" && printf "$1\n" >> "$2"
  else
    echo -e "$1" && printf "$1\n" >> "$2"
  fi
}

# log_silent
# Description:
# Log a message ($1) to the console. Logs to stdout if no -e option ($2) is passed in.
# Logs to stdout and stderr if the -e option is passed in.
#
# Notes:
# Backslash escapes are interpreted in the output file (e.g., they are not printed literally).
#
# Usage:
# Example 1: log a standard message to an output file
# log "Hello World"
#
# Example 2: log an error message to an output file
# log "Hello World" -e
#
log_silent () {
  if [[ "$3" == '-e' || "$3" == '--error' ]]; then
    1>&2 printf "$1\n" >> "$2"
  else
    printf "$1\n" >> "$2"
  fi
}

# node_package_exists
# Description:
# Checks is a node package directory ($1) is present on the file system
# An optional argument ($2) of the location to make the check can be passed
# otherwise the current working directory will be searched
# Echos 1 if a directory with the name of the node package ($1) exists within
# a directory named node_modules
# Echos 0 if a directory with the name of the node package ($1) does not exists within
# a directory named node_modules or if the node_modules directory does not exist
#
# Notes:
# If using the optional location argument ($2), make sure the path is valid
# or you can get a false negative
#
# Usage:
# Example 1:
# # Check if the node package react exists in the current working directory (assume that is does)
# node_package_is_installed react # echos 1
# Example 2:
# # Check if the node package foobar exists in the current working directory (assume that is does not)
# node_package_is_installed foobar # echos 0
# Example 3:
# # Check if the node package react exists in the foo/bar/baz (assume that is does)
# node_package_is_installed react foo/bar/baz # echos 1

node_package_exists () {
  [ -z $2 ] && local path='node_modules' || local path="$2/node_modules"
  ls "$path" 2>/dev/null | grep -w $1 >/dev/null 2>&1 && echo "1" || echo "0"
}

# generate_string
# Description:
# Generates a string of random alphanumeric and special charaters of any length ($1)
# The length of the string defaults to 32 if no argument is passed in
# or if the argument passed in is empty or not a valid positive integer
#
# Usage:
# Example 1: generate a random string with a length of 8
# generate_string 8
#
# Example 2: generate a random string with a length of 32
# generate_string
#
generate_string () {
  [ "$1" -ge 0 ] 2>/dev/null && local count=$1 || local count=32
  echo $(cat /dev/urandom | tr -dc 'a-zA-Z0-9$&+,:;=?@#|<>.^*()%-' | fold -w $count | head -n 1)
}


# Call functions from this script gracefully
if declare -f "$1" > /dev/null
then
  # call arguments verbatim
  "$@"
else
  echo "utils.sh: '$1' is not a known function name." >&2
  exit 1
fi
