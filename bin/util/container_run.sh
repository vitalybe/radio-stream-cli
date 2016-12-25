#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CONTAINER_ID=$($DIR/container_id.sh)
if [ -z $CONTAINER_ID ]; then
    echo "*** Radio Stream isn't running ***"
    exit 1
fi

docker exec -it $($DIR/container_id.sh) bash -ic "$*"