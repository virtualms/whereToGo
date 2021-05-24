#!/bin/bash
# This script copies the labels for which there is a match with the images selected by copy_all.sh


##### input ######
# $1 $DEST/Dataset
##################

# Default folders
WORK_ENV="/home/enzo/sdm"
DEST="$WORK_ENV/db"
cd $1

opts="train:validation:test"
classes="Door:Handle"
IFS=:

for opt in $opts; do
	cd $opt
	for class in $classes; do
		cd ./$class/labels
		cat $WORK_ENV/ids.txt | while read id; do
			match=$(ls | grep $id)
			echo $match | while read line; do
				cat $line >> $DEST/labels/$id.txt
			done
		done
		
		
		cd ..
		cd ..
	done
	cd $DEST/Dataset
done

rm $WORK_ENV/ids.txt
