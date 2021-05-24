#!/bin/bash
# This script creates a folder and collects all images to split into the dataset
## input ##
# none
###########

# Default folders
WORK_ENV="/home/enzo/sdm"
OIDv6="$WORK_ENV/OIDv6_ToolKit_Download_Open_Images_Support_Yolo_Format/OID"
DEST="$WORK_ENV/db"
SCRIPTS="$WORK_ENV/datacreator"

cd $WORK_ENV

# New folder creation
echo -n "You want create a new images db?[Y/n] "
read
choose=${REPLY}
shopt -s nocasematch
case "$choose" in
 "y" ) echo -n "Insert the new folder name: "
 	read
 	folder=${REPLY}
 	if test -d $folder ; then
 		echo -e "$folder already exists.\nI'm preparing it for new operations.."
 		# se il folder esiste già lo svuoto di tutto quello che ha dentro
 		cd $folder
 		rm -r images 
 		rm -r labels
 		mkdir images
 		mkdir labels
 		cd $WORK_ENV
 	else
 		echo -e "Creating the new folder $folder"
 		mkdir $folder
 		cd $folder
 		mkdir images
 		mkdir labels
 		DEST="$WORK_ENV/$folder"
 	fi ;;
 *) echo "Using default folder $DEST"
 	cd $DEST
 	rm -r *
 	cd $WORK_ENV ;;
esac

# Load OIDv6
echo -e "\nStart unzip dataset in $DEST..\n"
unzip -q $OIDv6/Dataset.zip -d $DEST
echo "Done."

# Launch the script for copying images and labels
cd $WORK_ENV/datacreator
./copy_all.sh $DEST
cd $DEST

echo "$DEST" > $SCRIPTS/source.txt

