#!/bin/bash
# Random change saturation and hue images in folder. Copy image to folder and run.
# ImageMagic require
# Author: Maciej Kawiak
# email: getjobworking@gmail.com
# ver 1.0

if [ -z "$1" ]
  then
    echo "No image file name argument supplied." && exit 1
else
    source_file=$1
fi

if [ -z "$2" ]
  then
    echo "No count of generate file supplied." && exit 1
else
    count=$2
fi

n=1

rgb2hex(){
    for var in "$@"
        do
            printf '%x' "$var";
        done
        printf '\n'
}
while [ $n -le $count ] 
do
  saturation=$(( $RANDOM % 255 + 1 ))
  hue=$(( $RANDOM % 255 + 1 ))
  hex=$(rgb2hex 100 $saturation $hue)
  name=$n-export-$hex.png
  
  convert -define modulate:colorspace=HSB $source_file -modulate 100,$saturation,$hue $name
  echo "file: " $n " " $name

 ((n++))
done
