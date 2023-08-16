#!/bin/bash

# Description: This script changes ownership and permissions for a specified folder and its contents.
# Usage: ./setwwwr.sh <folder> [user]
# If user is not provided, the script uses the user running the script.

# Check if an adequate number of arguments is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <folder> [user]"
    exit 1
fi

# Set the 'folder' variable to the first parameter
folder="$1"

# Set the 'user' variable to the second parameter or the user running the script
user="${2:-$USER}"

# Display information about script actions
echo "Changing owner and group for folder $folder to user $user..."

# Change owner and group for the folder and its contents
sudo chown -R "$user":www-data "$folder"

# Display information about the next step
echo "Setting setgid for folder $folder..."

# Set the setgid permission for the folder and its contents
sudo chmod -R g+s "$folder"

# Display information about script completion
echo "Operations completed."
