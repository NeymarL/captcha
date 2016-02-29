#!/bin/sh

for((i = 0; i < 3000; i++)); do
    #...
    curl -o "train_images/train${i}.png" http://localhost/securimage_show.php
    code=`cat '/home/www/securimage/code'`
    echo "train${i} ${code} 6" >> train_images/train_record
done