# shellcheck shell=bash
server_port() {
  local err='Error: get_server_port():'
  case $(echo "$1" | tr '[:upper:]' '[:lower:]') in
    'php')
      echo 8000
      ;;
    'apache')
      echo 8001
      ;;
    'nginx')
      echo 8002
      ;;
    *)
      echo 8001 ; exit 1
      ;;
  esac
}

debug_on() {
  local refresh stype port
  local usage='Usage: debug_on server-type [no-refresh]'
  local err='Error: debug_on():'
  refresh=$(echo "$2" | tr '[:upper:]' '[:lower:]')
  stype=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  # Error handling
  [ -z "$stype" ] && echo "$err must have at least one argument" && echo "$usage" && return
  [[ $stype != 'php' && $stype != 'apache' && $stype != 'nginx' ]] \
  && echo -e "$err Invalid default server type $stype.\nCheck starter.ini for supported values" && return
  [ "$refresh" != '' ] && [ "$refresh" != 'no-refresh' ] && echo "$err invalid refresh argument: $refresh" && return
  # Set port
  if ! port=$(server_port "$stype"); then echo "Internal $err server_port() defaulted to $port"; fi
  # Start debug session
  [ "$refresh" == 'no-refresh' ] && gp preview "$(gp url "$port")?XDEBUG_SESSION_START=$stype" && return
  gp preview "$(gp url "$port")?XDEBUG_SESSION_START=$stype" && sleep 1 && gp preview "$(gp url "$port")"
}

debug_off() {
  local refresh stype port
  local usage='Usage: debug_off server-type [no-refresh]'
  local err='Error: debug_off():'
  refresh=$(echo "$2" | tr '[:upper:]' '[:lower:]')
  stype=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  # Error handling
  [ -z "$stype" ] && echo "$err must have at least one argument" && echo "$usage" && return
  [[ $stype != 'php' && $stype != 'apache' && $stype != 'nginx' ]] \
  && echo -e "$err Invalid default server type $stype.\nCheck starter.ini for supported values" && return
  [ "$refresh" != '' ] && [ "$refresh" != 'no-refresh' ] && echo "$err invalid refresh argument: $refresh" && return
  # Set port
  if ! port=$(server_port "$stype"); then echo "Internal $err server_port() defaulted to $port"; fi
  # Stop debug session
  [ "$refresh" == 'no-refresh' ] && gp preview "$(gp url "$port")?XDEBUG_SESSION_STOP=$stype" && return
  gp preview "$(gp url "$port")?XDEBUG_SESSION_STOP=$stype" && sleep 1 && gp preview "$(gp url "$port")"
}
