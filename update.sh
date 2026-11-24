#!/bin/sh
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

source="../missive-data"
target="../sg-missiven-data"
app="../sg-missiven-app"

SECONDS=0
start=$(date +"%Y-%m-%dT%H:%M:%S%z")
echo "start $start"
cd "$source"
echo "Pull latest changes from $source"
git pull
echo "Copy relevant data from $source to $target"
#cp $source/33_candidates/*.xml "$target/data/"
cp $source/34_finalized/*.xml "$target/data/"
cp $source/README.md "$target/"
cp $source/info/* "$target/info"
cp -r $source/pages/* "$target/pages"
echo "Move PDF files to web app"
rm -r "$app/resources/pdfs"
mv "$target/pages/pdfs" "$app/resources/"
cp -a "$target/pages/missivedesmonats/." "$app/resources/pdfs/"
rm -r "$target/pages/missivedesmonats"
echo "Move images files to web app"
cp -a "$source/pages/images/." "$app/resources/images/"
rm -r "$target/pages/images/"
echo "Move script data to web app"
mv "$target/pages/highlights.xml" "$app/resources/scripts/app/"

echo "Update Anton data"
anton_get https://stadtasg.anton.ch/api/tei/refresh || exit 1

echo " Download Anton data - execution time (s): $SECONDS"
anton_get https://stadtasg.anton.ch/api/tei/stadtasg-actors-tei.xml > "$target/person/person.xml".tmp && mv "$target/person/person.xml".tmp "$target/person/person.xml" || exit 1
anton_get https://stadtasg.anton.ch/api/tei/stadtasg-places-tei.xml > "$target/place/place.xml".tmp && mv "$target/place/place.xml".tmp "$target/place/place.xml" || exit 1
anton_get https://stadtasg.anton.ch/api/tei/stadtasg-keywords-tei.xml > "$target/keyword/keyword.xml".tmp && mv "$target/keyword/keyword.xml".tmp "$target/keyword/keyword.xml" || exit 1

echo "Finished downloading Anton data - execution time (s): $SECONDS"
sleep 1
cd "$target"
echo "build stgm-data.xar - execution time (s): $SECONDS"
ant xar
echo "deploy stgm-data.xar to database - execution time (s): $SECONDS"
xst package install build/*.xar
echo "finished installation of stgm-data - execution time (s): $SECONDS"
end=($(date +"%Y-%m-%dT%H:%M:%S%z"))
echo "end date-time: $end - overall duration: $SECONDS"





