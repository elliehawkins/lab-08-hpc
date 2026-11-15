#! /bin/bash
set -euo pipefail
BUCKET="$1"
DIRECTORY="$2"

#create book directory
mkdir -p "$DIRECTORY"

#copy every .txt file
aws s3 cp "s3://$BUCKET" "$DIRECTORY" \
    --recursive \
    --exclude "*" \
    --include "*.txt" 

echo "File path" > book_list.txt
DIRECTORY="$(realpath "$DIRECTORY")"
find "$DIRECTORY" -name "*.txt" | sort >> book_list.txt


NUMBER=$(tail -n +2 book_list.txt | wc -l)
echo "Listed $NUMBER books"