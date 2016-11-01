#!/usr/bin/env bash
if [ -z $1 ]; then echo "Usage: ./run_server.sh Password1234" && exit 1; fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

type cygpath >/dev/null 2>&1 && DIR=$(cygpath -w "$DIR")
NGINX_PASSWORD=$1

DEV_MODE=""
# DEV_MODE="-v $DIR\..\beets:/radio-stream/beets"

docker run -it -p 80:80  -p 22123:22\
    -v "$DIR\data\ssh-key\authorized_keys":/root/.ssh/authorized_keys:ro\
    -v "$DIR\data\beets":/radio-stream/data/beets\
    -v "$DIR\new-music":/radio-stream/new-music\
    -v "$DIR\scripts\bundled":/radio-stream/scripts/bundled\
    -v "$DIR\scripts\user":/radio-stream/scripts/user\
    -v "C:\Users\htpc2\Music\beets-music":/radio-stream/music\
    -e "NGINX_PASSWORD=$NGINX_PASSWORD"\
    $DEV_MODE\
	vitalybe/radio-stream ${@:2} # provide all the arguments except the first