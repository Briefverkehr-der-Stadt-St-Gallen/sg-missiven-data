#!/bin/sh

# Update only Anton data and build the xar file

SOURCE=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

SECONDS=0
start=$(date +"%Y-%m-%dT%H:%M:%S%z")
echo "start $start"
cd "$SOURCE"

echo "Pull latest changes from $SOURCE"
git pull

echo "Update Anton data"
curl https://stadtasg.anton.ch/api/tei/refresh?api_token=yMzzOO8NeKQFuynAYRhrKZSMcjZAnuAkcFlEzDtru209aXnPk8jexRzCTyam

echo " Download Anton data - execution time (s): $SECONDS"
curl https://stadtasg.anton.ch/api/tei/stadtasg-actors-tei.xml > "$SOURCE/person/person.xml"
curl https://stadtasg.anton.ch/api/tei/stadtasg-places-tei.xml > "$SOURCE/place/place.xml"
curl https://stadtasg.anton.ch/api/tei/stadtasg-keywords-tei.xml > "$SOURCE/keyword/keyword.xml"
