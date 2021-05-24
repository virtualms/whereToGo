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
Change these paths with those in which you are going to work.it is recommended to install in the `WORK_ENV` path a virtual environment with the Opencv library in the version suggested in the readme on the homepage.

