#!/bin/bash

set -e

data_ori_path=/data2/user/yswang/data/openimages_v6_origin
data_path=/data2/user/yswang/data/openimages_v6
prj_path=/data2/user/yswang/hific/high-fidelity-generative-compression

# # Install AWS CLI v2.
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# sudo ./aws/install

# https://github.com/cvdfoundation/open-images-dataset#download-images-with-bounding-boxes-annotations
# aws s3 --no-sign-request sync s3://open-images-dataset/train [target_dir/train] (513GB)
# aws s3 --no-sign-request sync s3://open-images-dataset/validation [target_dir/validation] (12GB)
# aws s3 --no-sign-request sync s3://open-images-dataset/test [target_dir/test] (36GB)
# aws s3 --no-sign-request cp s3://open-images-dataset/tar/train_0.tar.gz [target_dir] (46G)
# aws s3 --no-sign-request cp s3://open-images-dataset/tar/train_1.tar.gz [target_dir] (34G)
# aws s3 --no-sign-request cp s3://open-images-dataset/tar/validation.tar.gz [target_dir] (12G)
# aws s3 --no-sign-request cp s3://open-images-dataset/tar/test.tar.gz [target_dir] (36G)

# # Dowload the tar files.
# if [ -e "$data_ori_path/done.txt" ]; then
#     echo "Data already downloaded."    
# else 
#     echo "Downloading data..."
#     mkdir -p $data_ori_path
#     aws s3 --no-sign-request cp s3://open-images-dataset/tar/train_0.tar.gz $data_ori_path
#     aws s3 --no-sign-request cp s3://open-images-dataset/tar/train_1.tar.gz $data_ori_path
#     aws s3 --no-sign-request cp s3://open-images-dataset/tar/validation.tar.gz $data_ori_path 
#     aws s3 --no-sign-request cp s3://open-images-dataset/tar/test.tar.gz $data_ori_path
#     touch $data_ori_path/done.txt
#     echo "Downloading data done."
# fi

# Unzip the tar files.
if [ -e "$data_path/done.txt" ]; then
    echo "Data already unzipped."    
else 
    echo "Unzipping data..."

    mkdir -p $data_path

    # tar -xzf $data_ori_path/test.tar.gz -C $data_path
    # tar -xzf $data_ori_path/validation.tar.gz -C $data_path
    # tar -xzf $data_ori_path/train_0.tar.gz -C $data_path
    # tar -xzf $data_ori_path/train_1.tar.gz -C $data_path

    # pv $data_ori_path/test.tar.gz | tar -xz -C $data_path
    # pv $data_ori_path/validation.tar.gz | tar -xz -C $data_path
    # pv $data_ori_path/train_0.tar.gz | tar -xz -C $data_path
    # pv $data_ori_path/train_1.tar.gz | tar -xz -C $data_path

    mkdir -p $data_path/train/
    # mv $data_path/train_0/* $data_path/train/
    # mv $data_path/train_1/* $data_path/train/
    # too many files, use rsync instead of mv
    rsync -a --progress $data_path/train_0/ $data_path/train/
    rsync -a --progress $data_path/train_1/ $data_path/train/
    # rmdir $data_path/train_0
    # rmdir $data_path/train_1

    touch $data_path/done.txt

    echo "Unzipping data done."
fi

ln -s $data_path $prj_path/data/openimages