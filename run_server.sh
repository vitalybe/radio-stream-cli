#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
type cygpath >/dev/null 2>&1 && DIR=$(cygpath -w "$(pwd)")
[ -z "$NGINX_PASSWORD" ] && NGINX_PASSWORD=bestrice404

docker run -it -p 80:80  -p 22123:22\
    -v "$DIR\ssh-key\authorized_keys":/root/.ssh/authorized_keys:ro\
    -v "$DIR\beets-data":/radio-stream/data\
    -v "$DIR\new-music":/radio-stream/new-music\
    -v "$DIR\scripts\bundled":/radio-stream/scripts/bundled\
    -v "$DIR\scripts\user":/radio-stream/scripts/user\
    -v "C:\Users\htpc2\Music\beets-music":/radio-stream/music\
    -e "NGINX_PASSWORD=$NGINX_PASSWORD"\
	vitalybe/radio-stream $*