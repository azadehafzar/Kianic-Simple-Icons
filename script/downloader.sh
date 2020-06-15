#!/usr/bin/env bash

CURRDIR="$PWD"
ICONDIR="${PWD%/*}/kiasimcons/icons"
ICON_TARGZ="kiasimcons.tar.gz"
TEMPDIR="temp"
TEMPICON="$( echo "$TEMPDIR/"*"/icons" )"

# Create temporary directory.
mkdir -p $TEMPDIR 

# Reset current icon directories.
rm -rf "$ICONDIR"
mkdir -p "$ICONDIR"

# Create download link.
LOCATION=$(curl -s https://api.github.com/repos/simple-icons/simple-icons/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/simple-icons/simple-icons/archive/" substr($2, 2, length($2)-3) ".tar.gz"}') \

# Download.
curl -L "$LOCATION" > "$ICON_TARGZ"

# Extract
tar -xz --file "$ICON_TARGZ" --directory "./$TEMPDIR"

# Delete downloaded tar.gz
rm "$ICON_TARGZ"

# Move files from temporary directory to main directory.
mv $TEMPICON/* "$ICONDIR/"

# Delete temporary folder.
rm -rf $TEMPDIR
