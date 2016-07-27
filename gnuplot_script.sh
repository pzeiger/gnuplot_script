#!/bin/bash


# $ARGV[0] - directory of input and datafile
# $ARGV[1] - gnuplot input file

wd=$(pwd)
cd $ARGV[0]

# modify output path
outp=$(grep 'set output' $ARGV[1])
outp=$(cut -d ' ' -f 3 $outp)
outp=$(echo $outp | cut -d ''"'"'' -f 4)
sed "s:"$outp":"$ARGV[0]"/"$outp":g" $ARGV[1] > $ARGV[1]_tmp

# modify data path
inp=$(grep 'file = ' $ARGV[1]) 
inp=$(cut -d ' ' -f 3 $inp)
inp=$(echo $inp | cut -d '"' -f 2)
sed -i "s:"$inp":"$ARGV[0]"/"$inp":g" $ARGV[1] > $ARGV[1]_tmp

gnuplot $ARGV[1]_tmp


cd $wd





