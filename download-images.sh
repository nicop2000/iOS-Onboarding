#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <GIT_REPOSITORY_URL> <BRANCH_NAME> <VERSION>"
    exit 1
fi

GIT_REPO_URL=$1
BRANCH_NAME=$2
VERSION=$3


SCRIPTPATH="$(cd "$(dirname "$0")" && pwd)"

DESTINATION_DIRECTORY="${SCRIPTPATH}/Images"

rm -rf "$DESTINATION_DIRECTORY"
mkdir -p "$DESTINATION_DIRECTORY"

git clone --branch "$BRANCH_NAME" "$GIT_REPO_URL" /tmp/temp_repo

DIRECTORY="/tmp/temp_repo"

PREFIX="$VERSION"
echo "Searching for images for version $PREFIX"


for file in "$DIRECTORY"/*; do
    # Check if the file starts with the specified prefix
    if [[ -f "$file" && "$(basename "$file")" == "$PREFIX"* ]]; then
        # Extract the filename without the directory path
        filename=$(basename "$file")
        # Split the filename at '_' and keep the second part
        new_filename=$(echo "$filename" | cut -d'_' -f2-)
        # Move the file to the destination directory
        mv "$file" "$DESTINATION_DIRECTORY/$new_filename"
        echo "Moved $filename to $DEST/$new_filename"
    else
        echo "Skipping $file as it doesn't have the prefix $PREFIX"
        continue
    fi
done

if [ ! "$(ls -A $DESTINATION_DIRECTORY)" ]; then
    echo "No files were downloaded."
fi

rm -rf /tmp/temp_repo
