"""This script applies filters specified in input to images of dataset"""

import cv2 as cv
import numpy as np
import os, shutil
import argparse
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt

if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--filter', type=str, default='', help='filter operation')
    parser.add_argument('--source', type=str, default='', help='Dataset source path')    
    opt = parser.parse_args()
    
    """Default folder"""
    WORK_ENV=opt.source        
    os.chdir(WORK_ENV)
    _dirs=os.listdir()
    
    """Filters application
    example:
    
    opt.filter = "filter"
    image = cv.imread(image.jpg)
    filter = cv.filter(image) --> the signature change according to the filter applied 
    filter_filename = "filter"+image.jpg
    cv.imwrite(filter_filename, filter)    
    """
    for _dir in _dirs :
        os.chdir(WORK_ENV+"/"+_dir+"/images")
        
        filenames=os.listdir()
        for filename in filenames:
            image=cv.imread(filename) 
            if opt.filter == "blur":     
                blur = cv.blur(image,(5,5))
                blur_filename="blur"+filename
                cv.imwrite(blur_filename, blur)
            elif opt.filter == "gray":
                gray = cv.cvtColor(image, cv.COLOR_BGR2GRAY)
                gray_filename="gray"+filename
                cv.imwrite(gray_filename, gray)
            elif opt.filter == "th":
                ret, threshold = cv.threshold(image,127,255,cv.THRESH_BINARY)
                th_filename="th"+filename
                cv.imwrite(th_filename, threshold)


        
        
    

        
