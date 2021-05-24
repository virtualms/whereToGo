# Custom dataset with data augemntation
If you need to create a custom dataset with data augmentation, you can use this guide to do it easly. We used it to create a custom dataset with `door` and `handle` classes but you can use it for all classes you want by modifying a few lines that we will explain later.

## 1. Download OIDv6
Download the classes that interest you through this [link](https://storage.googleapis.com/openimages/web/download.html)

## 2. Set right paths
Every script has the following section:

```
# Default folders
WORK_ENV="/home/enzo/sdm"
OIDv6="$WORK_ENV/OIDv6_ToolKit_Download_Open_Images_Support_Yolo_Format/OID"
DEST="$WORK_ENV/db"
```
Change these paths with those in which you are going to work. It is recommended to install in the `WORK_ENV` path a [python virtual environment](https://uoa-eresearch.github.io/eresearch-cookbook/recipe/2014/11/26/python-virtual-env/) with the Opencv library in the version suggested in the [README.md](https://github.com/EnzoFama/whereToGo/blob/main/README.md).

## 3. Set your classes
You may want to use these scripts with classes that are not `door` and `handle`. To make it edit in [copy_all.sh](https://github.com/EnzoFama/whereToGo/blob/main/scripts/copy_all.sh) and [label_creator.sh](https://github.com/EnzoFama/whereToGo/blob/main/scripts/label_creator.sh) scripts the following line:
```
classes="Door:Handle"
```
entering your classes as in the format shown.
You can also specify how many images to insert in your dataset in [copy_all.sh](https://github.com/EnzoFama/whereToGo/blob/main/scripts/copy_all.sh) here:
```

# Select a sub-set of images from train, validation and test
train=700
test=70
validation=13
```
If you want get a subset for a specific class use this code block as shown:
```
if test $class == "YOUR_CLASS"; then
			ls -S | tail -n ${!opt} | while read line; do
				cp -t $DEST/images/ $line
			done
		else
```
otherwise use it:
```
cp -n * $DEST/images
```
## 4. Create your dataset
Before running any script sign in to your [virtual envirnoment](https://uoa-eresearch.github.io/eresearch-cookbook/recipe/2014/11/26/python-virtual-env/).
To create your dataset run the script [setup.sh](https://github.com/EnzoFama/whereToGo/blob/main/scripts/setup.sh) as shown below:
```
./setup.sh [-htgb]
```
You can specify some option that set filters that you want to apply to your dataset for `data augmentation` such as:
* -h: print filters available;
* -t: apply binary threshold;
* -b: apply blur;
* -g: apply gray scale;

Example of `setup.sh` output:


```
(sdm) enzo@enzo-N752VX:~/sdm/datacreator$ ./setup.sh -gbt
You want create a new images db?[Y/n] y
Insert the new folder name: my_db
Creating the new folder my_db

Start unzip dataset in /home/enzo/sdm/my_db..

Done.
Insert new dataset name: my_dt
Success: my_dt created

Insert train percentage: 70
Insert validation percentage: 15
Insert test percentage: 15
Creating dataset..
Starting data augemntation:
	Applying gray..
	Applying blur..
	Applying th..
Done.

```


