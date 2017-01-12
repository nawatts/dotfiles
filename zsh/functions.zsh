alias externalip="echo -n $(curl --silent 'http://checkip.amazonaws.com')"

# Run a command repeatedly until it fails
function repeat-until-fails () {
  exit_code=0
  count=0
  while [ $exit_code -eq 0 ]; do
    count=$((count + 1))
    $@
    exit_code=$?
  done
  echo "Ran ${count} times"
}
