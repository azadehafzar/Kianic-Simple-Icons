#!/usr/bin/env bash

CURRDIR="${PWD}"
ICONDIR="${PWD%/*}/kiasimcons"
TEMPDIR="temp"

# Create temporary directory.
mkdir --parents "${TEMPDIR}"

# Create download link.
SIC_VERSION=$(curl --silent https://api.github.com/repos/simple-icons/simple-icons/releases/latest \
| grep "tag_name" \
| awk '{print "" substr($2, 2, length($2)-3)}')

SIC_DOWNLOAD_LINK="https://github.com/simple-icons/simple-icons/archive/${SIC_VERSION}.tar.gz"

# Setup paths.
SIC_TARGZ="kiasimcons.tar.gz"
TEMPICON="./${TEMPDIR}/simple-icons-${SIC_VERSION}/icons"

# Download.
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 \
--tries 0 --no-dns-cache --output-document "${SIC_TARGZ}" "${SIC_DOWNLOAD_LINK}"

tar --extract --gzip --file "${SIC_TARGZ}" --directory "./${TEMPDIR}"

# Delete downloaded tar.gz
rm "${SIC_TARGZ}"

# Remove current icons.
rm --force --recursive "${ICONDIR}/icons"

# Move files from temporary directory to main directory.
mv "${TEMPICON}" "${ICONDIR}"

# Delete temporary folder.
rm --force --recursive "${TEMPDIR}"

# restore deleted icons
git ls-files -z -d | xargs -0 git checkout --
