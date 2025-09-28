#!/bin/bash
set -e 

script_dir=$(dirname $(readlink -f "$0"))
script_name=$(basename $(readlink -f "$0") .sh)

date_str=$(date +'%Y%m%d_%H%M%S')

nohup python3 train.py --model_type compression --regime low --n_steps 1e6 > train_step1_${date_str}.log 2>&1 &
echo $! > train_step1.pid
echo "Training started in the background. PID: $(cat train_step1.pid)"