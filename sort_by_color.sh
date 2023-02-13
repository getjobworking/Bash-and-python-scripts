#!/bin/bash
# File sort images in folder by RGB. Copy images to folder and run.
# Author: Maciej Kawiak
# email: getjobworking@gmail.com
# ver 1.0

#und="_"
n=0

#get extension param

if [ -z "$1" ]
  then
    echo "No extension argument supplied. Set png extension as default."
    extension="png"
else
    extension=$1
fi

for file in *.$extension
do

  if [[ ! -f $file ]]
  then
    echo "Files ${file} does not exist!" && exit 1
     
  fi

  filename_prefix=`convert $file -scale 1x1 -format "%c" histogram:info: | tail -n 1 | awk -F\( '{print $2}'|cut -d\) -f1|awk -F"," '{printf "%03d.%03d.%03d\n", $1 , $2 , $3 }'`
  filename_suffix=`echo $file | cut -d'.' -f1 `
  file_name=$filename_prefix-$filename_suffix.$extension
  cp  $file $file_name

echo "file" $(($n+1)) $file $file_name

n=$((n+1))

done
