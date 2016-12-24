#!/usr/bin/env bash
function convert_path() {
    # this is required since docker on windows wants Windows-style directories 
    if [[ "$OSTYPE" == "msys" ]]; then
        type cygpath >/dev/null 2>&1 && echo $(cygpath -w $1) 
    else
        echo $1
    fi
}

# get this script folder
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CONTAINER_ID=$($DIR/util/container_id.sh)
if [ $CONTAINER_ID ]; then
    echo "*** Server is already running ***"
    exit 1
fi

FOLDER_BEETS_DATA=`convert_path $DIR/../data/beets`
FOLDER_CONFIG=`convert_path $DIR/../config`
FOLDER_SSH_KEYS=`convert_path $DIR/../data/ssh-key/authorized_keys`
FOLDER_SCRIPTS=`convert_path $DIR/../scripts`
FOLDER_MUSIC=`convert_path $DIR/../music`
FOLDER_NEW_MUSIC=`convert_path $DIR/../new-music`
FOLDER_BEETS_DEV=`convert_path $DIR/../../beets`

while getopts "hp:b:m:d" opt; do
  case $opt in
    h)
      echo "Usage: ./run_server.sh [-p password] [-m /music/folder] [-b /beets/data] [-d]" >&2
      echo "-p - Set radio-stream password" >&2
      echo "-b - Set beets library directory, by default: $FOLDER_BEETS_DATA" >&2
      echo "-m - Set music directory, by default: $FOLDER_MUSIC" >&2
      echo "-p - Set radio-stream password" >&2
      echo "-d - Development mode" >&2
      exit 0
      ;;
    p)
      NGINX_PASSWORD=$OPTARG
      echo "Setting password: $NGINX_PASSWORD" 
      ;;
    m)
      FOLDER_MUSIC=$OPTARG
      echo "Overrided music folder: $OPTARG"
      ;;
    b)
      FOLDER_BEETS_DATA=$OPTARG
      echo "Overrided beets config folder: $OPTARG"
      ;;
    d)
      echo "*** Running in development mode ***"
      DEV_MODE="-v $FOLDER_BEETS_DEV:/radio-stream/beets"
      ;;
  esac
done

if [ -z $NGINX_PASSWORD ]; then
    echo "*** WARNING: PASSWORD NOT SET - USING DEFAULT ***" && NGINX_PASSWORD=radio
fi

# make $@ contain all the other arguments
shift $((OPTIND-1))

docker run -d -p 80:80  -p 22123:22\
    -v "$FOLDER_SSH_KEYS":/root/.ssh/authorized_keys:ro\
    -v "$FOLDER_BEETS_DATA":/radio-stream/data/beets\
    -v "$FOLDER_NEW_MUSIC":/radio-stream/new-music\
    -v "$FOLDER_SCRIPTS":/radio-stream/scripts\
    -v "$FOLDER_CONFIG":/radio-stream/config\
    -v "$FOLDER_MUSIC":/radio-stream/music\
    -e "NGINX_PASSWORD=$NGINX_PASSWORD"\
    $DEV_MODE\
    vitalybe/radio-stream $@

docker logs -f $(docker ps -l -q)