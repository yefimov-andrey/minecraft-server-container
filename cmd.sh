#/bin/bash

set -euo pipefail

if [[ $# -eq 0 ]]; then
    echo Give me the name of the server .env file, then the command. The command with spaces does not need to be quote escaped.
    exit 0
fi

# run a server commend and show output
CONFIG=$1 #"$NAME.env"
NAME=${CONFIG%%.*}

time=$(date +%Y-%m-%dT%T.%N)
# grab all commands past the first argument
commands="${@:2}"
# crazy quoting below to allow passing commands from the command line with spaces in them
docker exec minecraft-server-$NAME sh -c 'echo "'"$commands"'" > /proc/$(pgrep -f ^java)/fd/0'
docker logs --since "$time" minecraft-server-$NAME
