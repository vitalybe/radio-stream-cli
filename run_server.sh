#!/usr/bin/env bash
while getopts "hp:d" opt; do
  case $opt in
    h)
      echo "Usage: ./run_server.sh [-p password] [-d]" >&2
      echo "-p - Set radio-stream password" >&2
      echo "-d - Development mode" >&2
      exit 0
      ;;
    d)
      echo "*** Running in development mode ***"
      DEV_MODE="-v $DIR\..\beets:/radio-stream/beets"
      ;;
    p)
      NGINX_PASSWORD=$OPTARG
      echo "Setting password: $NGINX_PASSWORD"
  esac
done

if [ -z $NGINX_PASSWORD ]; then
    echo "*** WARNING: PASSWORD NOT SET - USING DEFAULT ***" && NGINX_PASSWORD=radio
fi

# make $@ contain all the other arguments
shift $((OPTIND-1))

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# this is required since docker on windows wants Windows-style directories 
type cygpath >/dev/null 2>&1 && DIR=$(cygpath -w "$DIR")

docker run -it -p 80:80  -p 22123:22\
    -v "$DIR\data\ssh-key\authorized_keys":/root/.ssh/authorized_keys:ro\
    -v "$DIR\data\beets":/radio-stream/data/beets\
    -v "$DIR\new-music":/radio-stream/new-music\
    -v "$DIR\scripts\bundled":/radio-stream/scripts/bundled\
    -v "$DIR\scripts\user":/radio-stream/scripts/user\
    -v "C:\Users\htpc2\Music\beets-music":/radio-stream/music\
    -e "NGINX_PASSWORD=$NGINX_PASSWORD"\
    $DEV_MODE\
    vitalybe/radio-stream $@ # provide all the arguments except the first