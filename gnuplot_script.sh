#!/bin/bash

# $1 - path to gnuplot input file

file=$1

gnuin=$(echo $file | awk 'BEGIN { FS = "/" };{ print $NF }')
dir=$(echo $file | awk 'BEGIN { FS = "/" };NF{ NF -=1 };{ OFS = "/" };1')

echo "Processed: $file"
cp $file ${gnuin}_tmp

# modify output path
grep 'set output' $file | awk '{ print $NF }' | cut -d ''"'"'' -f 2 | xargs -n 1 -I {} sed -i 's:'{}':'$dir/{}':' ${gnuin}_tmp

# modify data path
PATT=$(grep 'file = ' $file | awk '{ print $NF }' | cut -d '"' -f 2)
echo $PATT
grep 'file = ' $file | awk '{ print $NF }' | cut -d '"' -f 2 | awk 'BEGIN { FS = "*" }; {if ($2 == "") print $1; else print $1"[*]"$2}' | xargs -n 1 -I {} sed -i 's:'{}':'$dir/$PATT':' ${gnuin}_tmp
#echo $( grep 'file = ' $file | awk '{ print $NF }' | cut -d '"' -f 2 | awk 'BEGIN { FS = "*" }; {if ($2 == "") print $1; else print $1"[*]"$2}')

gnuplot ${gnuin}_tmp

mkdir -p gnuplot_tmp

mv ${gnuin}_tmp gnuplot_tmp/

