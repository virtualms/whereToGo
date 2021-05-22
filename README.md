# whereToGo

WhereToGo is an Android app coinceived to help visually impaired or blind people to explore indoor ambients, like for example apartments, offices, markets and so on. The Android App (see the section Android App) uses a vocal speech synthesizer to notify the subject of the presence of useful objects inside a room. 

For this version of the project, whe focused upon the two most important objects for this people to move inside a new ambient: doors and handles (specially door handles).

# Introduction
For this purpose, we used and trainined the network YOLO, specially [YOLOv5s](https://github.com/ultralytics/yolov5) implemented in PyTorch in the latest possible version released by [ultralytics](https://ultralytics.com/). You can find all the notebooks in the `notebook` folder.

We started by considering the dataset [DoorDetect-Dataset](https://github.com/MiguelARD/DoorDetect-Dataset), regarding the paper [Robust and Adaptive Door Operation with a Mobile Manipulator Robot](https://arxiv.org/abs/1902.09051). Because of the non-optimanl performances we obtained, we decided to create our own dataset, starting from [Open Images Dataset](https://storage.googleapis.com/openimages/web/index.html) and using also custom images annotated with [RoboFlow](https://roboflow.com/). 

The dataset was also extended using data augmentation through cv2 filters. It is composed on Training, Validation, Testing in 70-15-15 proportion and provided of YOLO compliant labels. The structure is how it follows, with label "door" and label "handle" balanced:

Data Augmentation | Total size | Train | Validation | Test
-------------- | ---------- | ----- | ---------- | ----
No | 1435 | 1005 | 215 | 215
Yes | 5740 | 4020 | 860 | 860

You can download our dataset here:
* with data augmentation : [link1](https://drive.google.com/file/d/1FP9JiH5007FYb1c1I9NiMXqRGcvs1FgE/view?usp=sharing)
* raw: [link2](https://drive.google.com/file/d/10lpGb3cVTmKh2YXOxObq_v61ImeliROf/view?usp=sharing)


# Results for the training

 
# Android App
