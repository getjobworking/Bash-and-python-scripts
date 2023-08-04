#!/bin/bash

# Script to generate PDF from JPG images in the "target" directory

input_dir="$PWD"
output_dir="$input_dir/target_pdf_generated"
output_pdf="doc_from_target_generated.pdf"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Check if there are any JPG files in the input directory
if ! find "$input_dir" -maxdepth 1 -type f -name '*.jpg' -print -quit | grep -q .; then
  echo "No JPG files found in the input directory"
  exit 1
fi

# Generate the PDF file
pdf_files=("$input_dir"/*.jpg)
img2pdf "${pdf_files[@]}" -o "$output_dir/$output_pdf"
echo "PDF generated: $output_pdf in folder $output_dir"

echo "Processed ${#pdf_files[@]} files"

