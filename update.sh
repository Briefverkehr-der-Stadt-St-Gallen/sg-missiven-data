#!/bin/sh
source="../missive-data"
target="../stgm-data"
app="../stgm"

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
mv "$target/pages/2_Über das Projekt.md" "$target/pages/2_Ueber_das_Projekt.md"
echo "Move PDF files to web app"
rm -r "$app/stgm/resources/pdfs"
mv "$target/pages/pdfs" "$app/stgm/resources/"

echo "Update Anton data"
curl https://stadtasg.anton.ch/api/tei/refresh?api_token=yMzzOO8NeKQFuynAYRhrKZSMcjZAnuAkcFlEzDtru209aXnPk8jexRzCTyam

echo " Download Anton data - execution time (s): $SECONDS"
curl https://stadtasg.anton.ch/api/tei/stadtasg-actors-tei.xml > "$target/person/person.xml"
curl https://stadtasg.anton.ch/api/tei/stadtasg-places-tei.xml > "$target/place/place.xml"
curl https://stadtasg.anton.ch/api/tei/stadtasg-keywords-tei.xml > "$target/keyword/keyword.xml"

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





