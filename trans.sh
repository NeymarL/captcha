#!/usr/bin/sh

DATA="/home/neymar/Documents/Machine-Learning/captcha/record.txt"
TOOLS="../caffe/build/tools"
ROOT="/home/neymar/Documents/Machine-Learning/captcha/good_images/"

echo "Creating train lmdb..."

GLOG_logtostderr=1 $TOOLS/convert_imageset \
    $ROOT \
    $DATA \
    liu_train_lmdb

echo "Done!"