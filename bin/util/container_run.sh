#!/usr/bin/env bash
DIR="$(dirname "$(readlink -f "$0")")"

CONTAINER_ID=$($DIR/container_id.sh)
if [ -z $CONTAINER_ID ]; then
    echo "*** Radio Stream isn't running ***"
    exit 1
fi

docker exec -it $($DIR/container_id.sh) bash -ic "$*"