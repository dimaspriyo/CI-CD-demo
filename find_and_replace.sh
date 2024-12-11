#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <directory> <old_text> <new_text>"
    exit 1
fi

# Assign arguments to variables
directory=$1
old_text=$2
new_text=$3

# Perform the find and replace
find "$directory" -type f -not -name "*.md" -not -path "./gitea/*" -exec sed -i "s/$old_text/$new_text/g" {} +

echo "Replaced all occurrences of '$old_text' with '$new_text' in files under '$directory'."
