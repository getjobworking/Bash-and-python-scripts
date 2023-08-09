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

sh files need to be granted run rights.
