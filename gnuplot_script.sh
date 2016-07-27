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
grep 'file = ' $file | awk '{ print $NF }' | cut -d '"' -f 2 | xargs -n 1 -I {} sed -i 's:'{}':'$dir/{}':' ${gnuin}_tmp

gnuplot ${gnuin}_tmp

rm -r ${gnuin}_tmp

