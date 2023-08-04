#!/bin/bash
#
# This script processes all jpg, jpeg, and png files in the current directory.
# It automatically converts png files to jpg format with the same name,
# and renames all jpg and jpeg files with a specified new name or a default name with a numeric suffix.
# The converted png files are moved to a folder named "png".
# If the "png" folder does not exist, it will be created.
#
# Usage:
#   ./process_images.sh [new_name]
#     - new_name: Optional parameter for the new name of jpg and jpeg files without the numeric suffix.
#                 If not provided, the default new name will be "file" with a numeric suffix.

# Function to convert png files to jpg with the same name
convert_png_to_jpg() {
    for png_file in *.png; do
        jpg_file="${png_file%.png}.jpg"
        convert "$png_file" "$jpg_file"
        #rm "$png_file"
    done
}

# Function to rename jpg and jpeg files with a new name and numeric suffix
rename_jpg_files() {
    new_name=$1
    counter=1

    for jpg_file in *.{jpg,jpeg}; do
        new_jpg_file="${new_name}-${counter}.jpg"
        mv "$jpg_file" "$new_jpg_file"
        ((counter++))
    done
}
# First pass: Convert png files to jpg
convert_png_to_jpg

# Check if the "png" folder exists and create it if not
if [ ! -d "png" ]; then
    mkdir "png"
fi

# Move png files to the "png" folder
for png_file in *.png; do
    mv "$png_file" "png/$png_file"
done


# Third pass: Rename jpg and jpeg files
rename_jpg_files "${1:-file}"

