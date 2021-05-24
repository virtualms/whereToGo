#!/bin/bash
# this script deletes the resulting images from the filter combination

################ Input ######################
# $1 filter prefix 
#############################################


# Default folders
WORK_ENV="/home/enzo/sdm"
my_dataset="$WORK_ENV/custom_dt"

cd $my_dataset

ls | tr " " "\n" | while read phase; do
	cd $phase
	ls | tr " " "\n" | while read section; do
		cd $section
		ls | grep "$1" | while read file; do
			rm $file
		done
		cd ..
	done
	cd ..
done
