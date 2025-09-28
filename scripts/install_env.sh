#!/bin/bash

# 打开代理（如果需要）
# /data/user/yswang/opt/v2ray-linux-64/v2ray
# export http_proxy="http://127.0.0.1:10809"
# export https_proxy="http://127.0.0.1:10809"

# 创建 Conda 环境
conda create -n hific python=3.7.3 -y
conda activate hific

# 安装依赖
pip install -r requirements.txt

# 导出环境为 zip 包
echo "Packing the Conda environment into a zip file..."
conda install -n base conda-pack -y  # 确保 conda-pack 已安装
conda-pack -n hific -o hific_env.zip

echo "Conda environment packed into hific_env.zip"