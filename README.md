# whereToGo
![Problem solving-bro(1)](https://user-images.githubusercontent.com/50915778/119220078-ec9fb280-bae8-11eb-9843-946f83acef35.png)

`WhereToGo` is an Android app coinceived to help visually impaired or blind people to explore indoor ambients, like for example apartments, offices, markets and so on. The Android App (see the section `Android App`) uses a vocal speech synthesizer to notify the subject of the presence of useful objects inside a room. 

For this version of the project, whe focused upon the two most important objects for these people to move inside a new ambient: doors and handles.

# Introduction
For this purpose, we used and trainined the network `YOLO`, specially [YOLOv5s](https://github.com/ultralytics/yolov5) implemented in PyTorch in the latest possible version released by [ultralytics](https://ultralytics.com/). You can find all the Colab notebooks in the `notebook` folder. Also you can run them with minimal adjustments on Jupyter.

We started by considering the dataset [DoorDetect-Dataset](https://github.com/MiguelARD/DoorDetect-Dataset), regarding the paper [Robust and Adaptive Door Operation with a Mobile Manipulator Robot](https://arxiv.org/abs/1902.09051). Because of the non-optimal performances we obtained on `door` and `handle` labels, we decided to create our own `custom dataset`, starting from [Open Images Dataset](https://storage.googleapis.com/openimages/web/index.html) and using also custom images annotated with [RoboFlow](https://roboflow.com/). 

The dataset was also extended using data augmentation through OpenCV filters. It is composed on Training, Validation, Testing in 70-15-15 proportion and provided of YOLO compliant labels. The structure is how it follows, with label `door` and label `handle` balanced:

Data Augmentation | Total size | Train | Validation | Test
-------------- | ---------- | ----- | ---------- | ----
No | 1435 | 1005 | 215 | 215
Yes | 5740 | 4020 | 860 | 860

You can download our dataset here:
* with data augmentation: [drive link](https://drive.google.com/file/d/1FP9JiH5007FYb1c1I9NiMXqRGcvs1FgE/view?usp=sharing)
* w\o data augmentation: [drive link](https://drive.google.com/file/d/10lpGb3cVTmKh2YXOxObq_v61ImeliROf/view?usp=sharing)

This is a summing schema of what we did:

<p align="center">
  <img src="https://github.com/virtualms/whereToGo/blob/main/demoPics/sisdig_workflow.jpg">
</p>

# Training
As introduced before, we trained YOLOv5s with two different input size: 320x320 and 640x640. We report the metrics (Precision, Recall, mAP@0.5, mAP@0.5:0.95) obtained for these training on the `custom dataset`. Both training were ran with `batch-size=32`, `epochs=250`.

640x640:
Classes | Precision | Recall | mAP@0.5 | mAP0.5:0.95
------- | --------- | ------ | ------- | -----------
All | 0.998 | 0.979 | 0.993 | 0.901
Door | 0.998 | 0.984 | 0.995 | 0.91
Handle | 0.999 | 0.974 | 0.991 | 0.891

320x320:
Classes | Precision | Recall | mAP@0.5 | mAP0.5:0.95
------- | --------- | ------ | ------- | -----------
All | 0.98 | 0.973 | 0.988 | 0.833
Door | 0.971 | 0.977 | 0.99 | 0.876
Handle | 0.989 | 0.989 | 0.987 | 0.79

If you are interested, you can find the network weights in `weights`, or alternatively here for custom dataset with data augmentation: [drive link](https://drive.google.com/drive/folders/1W5yXhwJ8yTndKcrgqteBQXrmCLoTdsWv?usp=sharing).

# Conversion in Torchscript
Network weights were converted in TorchScript and optimized for the Android App. You can check `Export_to_torchscript_simple` for a simple export or `Model_optimization_torch` for and explicit export and some ways to optimize the model for mobile. Also refer to the latest [Pytorch Mobile Performance Recipe](https://pytorch.org/tutorials/recipes/mobile_perf.html?highlight=mobile).

TorchScript weights are available here:
* with data augmentation: [320](https://drive.google.com/file/d/1-OEeQ3bsIkjnCDLhiXPziKCdOU_sHCLH/view?usp=sharing)
* w\o data augmentation: [640](https://drive.google.com/file/d/1-KceBOglxJCBCVGx5MXBpItcteOyo2ZF/view?usp=sharing) 
 
# Android App
The Android App implement the purpose discussed in introductions, using the best weights obtained from the training phase. You can find the repository following this [broken link :(]().

# References
> The image from the first section was taken by https://storyset.com/ 
