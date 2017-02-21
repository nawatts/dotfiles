function command_exists () {
  [[ -x "$(command -v $1)" ]]
}

alias externalip="echo -n $(curl --silent 'http://checkip.amazonaws.com')"

# Run a command repeatedly until it fails
function repeat-until-fails () {
  if [[ $# -eq 0 ]]; then
    echo "Usage: ${0} command" >&2
    return 1
  fi
  local exit_code=0
  local count=0
  while [ $exit_code -eq 0 ]; do
    count=$((count + 1))
    $@
    exit_code=$?
  done
  echo "Ran ${count} times"
}
