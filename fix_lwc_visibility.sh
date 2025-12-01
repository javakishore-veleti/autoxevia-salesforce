#!/bin/bash

SRC="force-app/main/default/domains"
DEST="force-app/main/default/lwc"

echo "Copying all top* LWC components to root /lwc …"

mkdir -p "$DEST"

find "$SRC" -type d -name "top*" | while read folder; do
    comp=$(basename "$folder")
    echo " → Copying $comp"
    rm -rf "$DEST/$comp"
    cp -R "$folder" "$DEST/"
done

echo "Done. Now deploy again:"
echo "sf deploy metadata --source-dir force-app/main/default"
