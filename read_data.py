#!/usr/bin/python2
# -*- coding:utf-8 -*-

# read image as matrices and
# match the right target

# Standard scientific Python imports
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as mpimg

#------- functions -------------------


def rgb2gray(rgb):
    '''
    RGB trans to gray scale
    '''
    return np.dot(rgb[..., :3], [0.299, 0.587, 0.114])


def removeBorder(before):
    height = len(before)
    width = len(before[0])

    height_rate = 15.0 / 80
    width_rate = 30.0 / 215

    height_start = int(height_rate * height)
    height_end = int(height - height_start)

    width_start = int(width_rate * width)
    width_end = int(width - width_start)

    after = []

    for m in before[height_start: height_end]:
        after.append(m[width_start: width_end])

    #after = before[height_start: height_end][width_start: width_end]

    return after


def split_image(img, num):
    height = len(img)
    width = len(img[0])
    unit = int(width / num)
    singles = []
    i = 0
    while i < num:
        s = []
        j = 0
        while j < height:
            s.append(img[j][i * unit: (i + 1) * unit])
            j = j + 1
        singles.append(s)
        i = i + 1
    return singles

#--------------------------------------


def read_data():
    # final target!
    X = []
    y = []

    #-------- read targets  ---------------
    train_record = open('train_images/train_record', 'r')
    f = open('record.txt', 'w')
    target = []

    while 1:
        record = train_record.readline()
        if not record:
            break
        target.append(record.split(' ')[1])

    train_record.close()

    cnt = 0
    hash_table = {"0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6,
                  "7": 7, "8": 8, "9": 9}
    s = 'abcdefghijklmnopqrstuvwxyz'
    i = 10
    for ch in s:
        hash_table[ch] = i
        i = i + 1
    s = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    for ch in s:
        hash_table[ch] = i
        i = i + 1
    for tar in target:
        for char in tar:
            f.write(
                '/home/neymar/Documents/Machine-Learning/captcha/good_images/%d.png %d\n' %
                (cnt, hash_table[char]))
            cnt = cnt + 1
            y.append(char)

    f.close()
    #-------------------------------------
    '''
    #----------- read images --------------
    n = 20000
    i = 0
    basedir = 'train_images/'
    basename = basedir + 'train'
    extension = '.png'
    images = []

    while i < n:
        filename = basename + str(i) + extension
        img = plt.imread(filename)
        gray = rgb2gray(img)
        images.append(gray)
        i = i + 1

    i = 0
    h = 0
    w = 0
    while i < n:
        images[i] = removeBorder(images[i])
        singles = split_image(images[i], 6)
        for sin in singles:
            h = len(sin)
            w = len(sin[0])
            tmp = np.array(sin)
            X.append(tmp.reshape(h * w))
        i = i + 1

    #-------------------------------------------
    return (X, y, h, w)
    '''
