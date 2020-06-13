#!/usr/bin/env bash

CURRDIR="$PWD"
ICONDIR="${PWD%/*}/kiasimcons/icons"
TEMPDIR="temp"
TEMPICON="$( echo "$TEMPDIR/"*"/icons" )"

LOCATION=$(curl -s https://api.github.com/repos/simple-icons/simple-icons/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/simple-icons/simple-icons/archive/" substr($2, 2, length($2)-3) ".tar.gz"}') \

mkdir -p $TEMPDIR && curl -L $LOCATION | tar -xzv --directory $TEMPDIR

rm -rf "$ICONDIR" && mkdir -p "$ICONDIR"

mv -v  $TEMPICON/* "$ICONDIR/" && rm -rf $TEMPDIR
