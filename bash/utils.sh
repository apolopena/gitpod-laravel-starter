#!/bin/bash

# utils.sh
# Author: Apolo Pena
# Description: A variety of useful functions
# Note: Do not execute this script witout calling a function from it
#
# Usage: bash <function name> arg1 arg2 arg3 ...
# 


version () {
  echo "utils.sh version 0.0.1"
}


# add_file_to_file_before
# Description:
# Adds the contents of file ($2) into another file ($3) before the marker ($1)
# 
# Note:
# The marker is a regexp expression so it must have any regexp characters in it double escaped
#
# Usage:
# Example: add the contents of git-alises.txt to .gitconfig before the marker [aliases]
# add_file_to_file_before \\[alias\\] git-aliases.txt .gitconfig
#
add_file_to_file_before() {
  awk "/$1/{while(getline line<\"$2\"){print line}} //" $3 >__tmp &&
  mv __tmp $3
}

# add_file_to_file_after
# Description:
# Adds the contents of file ($2) into another file ($3) after the marker ($1)
# 
# Note:
# The marker is a regexp expression so it must have any regexp characters in it double escaped
#
# Usage:
# Example: add the contents of git-alises.txt to .gitconfig after the marker [aliases]
# add_file_to_file_before \\[alias\\] git-aliases.txt .gitconfig
#
add_file_to_file_after() {
  awk "//; /$1/{while(getline<\"$2\"){print}}" $3 >__tmp
  mv __tmp $3
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
