# Bash-and-python-scripts
Scripts for modifying iamge files, pdf, ocr
This repository contains various useful bash and python scripts.

Files setup.zip and setup.ini and setup.py, 
is a package of scripts for various actions on image files and pdf files.

The zip archive contains the following scripts:

setup_jpg2resize.sh - a script for resize images from directory.
setup_img2pdf.sh - script creates pdf from images from directory.
setup_change_font.sh - the script changes all the fonts used in the pdf file to the given font as a parameter.
setup_ocrit.py - the script converts jpg and png files to text in a specific language.
setup_ocrit.sh - the script converts jpg and png files to text in the specified language.

The setup.py file is the installer of the scripts contained in the setup.zip archive, according to the settings of the setup.ini file. Setup.ini also creates the folders defined in the configuration file.

i2p.sh
Script to generate PDF from JPG images in the "target" directory

ren_jpg_png_num.sh
This script processes all jpg, jpeg, and png files in the current directory.
It automatically converts png files to jpg format with the same name,and renames all jpg and jpeg files with a specified new name or a default name with a numeric suffix.The converted png files are moved to a folder named "png". If the "png" folder does not exist, it will be created.

all.img1pdf.all.subf.sh
A script to generate PDF files from JPG images in subfolders of a specified directory and save them to the target_pdf_generated folder.

create-www-conf.sh
This script sets up a new virtual host in Apache.

Usage: ./setup_virtual_host.sh <domain_name>

Example: ./setup_virtual_host.sh mydomain.local

1. Create a domain folder in /var/www.
2. Inside the domain folder, create public_html and logs subfolders.
3. Generate a sample index.html file.
4. Append the new domain entry after the last existing 127.0.0.1 entry in the hosts file.
5. Enable the virtual host configuration.
6. Verify the Apache configuration.
7. Restart the Apache web server.
8. Set ownership and permissions for the user and the www-data group.

setwwwr.sh

This script changes ownership and permissions for a specified folder and its contents.

Usage: ./setwwwr.sh <folder> [user]

If user is not provided, the script uses the user running the script


sh files need to be granted run rights.
