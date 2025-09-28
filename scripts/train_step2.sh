#!/bin/bash
set -e 

script_dir=$(dirname $(readlink -f "$0"))
script_name=$(basename $(readlink -f "$0") .sh)

date_str=$(date +'%Y%m%d_%H%M%S')

nohup python3 train.py --model_type compression_gan --regime low --n_steps 1e6 --warmstart --ckpt path/to/base/checkpoint > train_step2_${date_str}.log 2>&1 &
echo $! > train_step2.pid
echo "Training started in the background. PID: $(cat train_step2.pid)"