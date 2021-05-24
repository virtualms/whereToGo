# This script copies all handles images and labels and a sub-set of doors images and labels in a specified folder given as input

######Input########
# $1 $DEST/Dataset
###################


# Default folders
WORK_ENV="/home/enzo/sdm"
DEST="$WORK_ENV/db"

# Input check
if test $# -ne 1 ; then
	echo "Usage: $0 <dt_path>"
	exit
fi

DEST=$1
cd $DEST/Dataset #$DEST/Dataset

opts="train:validation:test"
classes="Door:Handle"
IFS=:

# Select a sub-set of images from train, validation and test
train=700
test=70
validation=13
# Create copies of images in input folder -->$DEST/images
for opt in $opts; do
	cd $opt
	for class in $classes; do
		cd $class/images
		if test $class == "Door"; then
			ls -S | tail -n ${!opt} | while read line; do
				cp -t $DEST/images/ $line
			done
		else
			cp -n * $DEST/images
			
		fi		
		
		cd $1/Dataset/$opt
		
	done
	cd $DEST/Dataset
done
# Save ids to copy labels too 
ls $DEST/images | cut -d"." -f1 > $WORK_ENV/ids.txt

# Launch the script for copying labels
cd $WORK_ENV/datacreator
./label_creator.sh $1
