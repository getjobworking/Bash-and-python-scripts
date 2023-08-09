#!/bin/bash

# Script to generate PDFs from JPG images in subfolders of the specified directory
# Requires img2pdf

input_dir="$PWD"
output_dir="$PWD/target_pdf_generated"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Process subfolders
for folder in "$input_dir"/*; do
  if [ -d "$folder" ] && [ "$folder" != "$output_dir" ]; then
    folder_name=$(basename "$folder")
    pdf_name="$output_dir/$folder_name.pdf"
    
    # Check if there are any JPG files in the subfolder
    if find "$folder" -maxdepth 1 -type f -name '*.jpg' -print -quit | grep -q .; then
      img2pdf "$folder"/*.jpg -o "$pdf_name"
      echo "PDF generated for $folder_name: $pdf_name"
    else
      echo "No JPG files found in $folder_name"
    fi
  fi
done

echo "Processed all subfolders and generated PDFs in folder $output_dir"

