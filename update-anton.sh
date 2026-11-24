#!/bin/sh

# Update only Anton data and build the xar file

# Anton API token: from $ANTON_API_TOKEN or from the git-ignored file .anton-token
# next to this script. Never commit the token.
SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" >/dev/null 2>&1 && pwd )
if [ -z "$ANTON_API_TOKEN" ] && [ -f "$SCRIPT_DIR/.anton-token" ]; then
    ANTON_API_TOKEN=$(tr -d '[:space:]' < "$SCRIPT_DIR/.anton-token")
fi
if [ -z "$ANTON_API_TOKEN" ]; then
    echo "Missing Anton API token: set ANTON_API_TOKEN or create $SCRIPT_DIR/.anton-token" >&2
    exit 1
fi
anton_get() {
    curl --fail --silent --show-error -H "Authorization: Bearer $ANTON_API_TOKEN" "$1"
}

SOURCE=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

SECONDS=0
start=$(date +"%Y-%m-%dT%H:%M:%S%z")
echo "start $start"
cd "$SOURCE"

echo "Pull latest changes from $SOURCE"
git pull

echo "Update Anton data"
anton_get https://stadtasg.anton.ch/api/tei/refresh || exit 1

echo " Download Anton data - execution time (s): $SECONDS"
anton_get https://stadtasg.anton.ch/api/tei/stadtasg-actors-tei.xml > "$SOURCE/person/person.xml".tmp && mv "$SOURCE/person/person.xml".tmp "$SOURCE/person/person.xml" || exit 1
anton_get https://stadtasg.anton.ch/api/tei/stadtasg-places-tei.xml > "$SOURCE/place/place.xml".tmp && mv "$SOURCE/place/place.xml".tmp "$SOURCE/place/place.xml" || exit 1
anton_get https://stadtasg.anton.ch/api/tei/stadtasg-keywords-tei.xml > "$SOURCE/keyword/keyword.xml".tmp && mv "$SOURCE/keyword/keyword.xml".tmp "$SOURCE/keyword/keyword.xml" || exit 1
