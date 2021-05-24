#!/bin/bash
# This script creates the dataset's tree of directories

##### Input #####
# $1 dataset name
#################

# Default folder
WORK_ENV="/home/enzo/sdm"

cd $WORK_ENV

rm -r $1 2>/dev/null


mkdir $1
cd $1

mkdir train
mkdir val
mkdir test

ls | while read phase; do
	cd $phase
	mkdir images
	mkdir labels
	cd ..
done

