#!/bin/bash
# This script creates the dataset from OIDv6 and applies the specified filters as options.

######## Input ###########
# -bgt --> filters option
##########################

# Default folders
WORK_ENV="/home/enzo/sdm"
SOURCE="$WORK_ENV/db"
SCRIPTS="$WORK_ENV/datacreator"

# Filters
filters=""
while getopts "bgth" opt 
do
    case $opt in
        b) filters="$filters blur";;
        g) filters="$filters gray";;
        t) filters="$filters th";;
        h) echo -e "Usage: $0 [-bgt]\nBlur (-b), gray-scale (-g) and threshold (-t) are available"
        exit;;
    esac
done

shift

# Creation of folder containing all images to split
./dbCreator.sh



# Creation of dataset's tree of directory

cd $SCRIPTS
echo -n "Insert the name of new dataset: "
read
dt_name=${REPLY}
./dt_tree.sh $dt_name &

echo -e "Success: $dt_name created\n"


# Insert percentages for images splitting
echo -n "Insert train percentage: "
read
train_perc=${REPLY}
echo -n "Insert validation percentage: "
read
val_perc=${REPLY}


echo -n "Insert test percentage: "
read
test_perc=${REPLY}

# percentages check
if test $(($train_perc+$val_perc+$test_perc)) -ne 100; then
	echo "Wrong percentage values inserted."
	exit
fi

cd $WORK_ENV

tot=$(ls "./db/images" | wc -w)

# Dataset creation
echo -e "Creating dataset.."
ls $dt_name | tr " " "\n" | while read phase; do
	perc="${phase}_perc"
	num_imgs=$(($tot*$perc/100))
	ls ./$dt_name/$phase | tr " " "\n" | while read section; do
		if test $section == "images"; then
			ls "./db/images" | tail -n $num_imgs | while read img; do
				cp ./db/images/$img ./$dt_name/$phase/$section
			done
		else
			ls "./$dt_name/$phase/images" | sed "s/.jpg/.txt/g" | while read label; do
				cp ./db/labels/$label ./$dt_name/$phase/$section
			done
		fi
	done
done

echo -e "Done."

cd $SCRIPTS

# Filters application
if ! test -z $filters; then
echo $filters | tr " " "\n" | while read filter; do
	echo "$filter"
	python3 transform.py --filter $filter --source "/home/enzo/sdm/$dt_name"


# Copying matching labels
	cd $WORK_ENV/$dt_name
	ls | tr " " "\n" | while read phase; do
		cd $phase/labels
		ls | tr " " "\n" | while read label; do
			cp $label "$filter$label"
		done
		cd ..
		cd ..
	done
	cd $SCRIPTS
done
fi

# Delete the resulting images from filters combination --> thgrayblur<filename>.jpg etc.
# N.B. Just delete only images with these prefixes
./remove.sh "thgray"
./remove.sh "thblur"
./remove.sh "grayblur"


