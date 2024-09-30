#!/bin/bash

#SBATCH --job-name=cifar      # Job name
#SBATCH --gres=gpu:1             # how many gpus would you like to use (here I use 1)
#SBATCH --mail-type=END,FAIL         # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=fmaroufs@uci.edu  # Where to send mail	(for notification only)
#SBATCH --nodes=1                    # Run all processes on a single node
#SBATCH --ntasks=1                   # Run a single task
#SBATCH --cpus-per-task=4            # Number of CPU cores per task
#SBATCH --mem=32G                 # total memory per node (= mem-per-cpu * cpus-per-task)
#SBATCH --time=72:00:00              # Time limit hrs:min:sec
#SBATCH --partition=ava_m.p          # partition name; 'ava_m.p' is the partition/queue for mandt lab
## SBATCH --nodelist=ava-m4          # select your node (or not)
#SBATCH --output=/home/fmaroufs/slurm_logs/job_%j.log   # output log

source /home/fmaroufs/.bashrc     # the ICS default .bashrc makes 'module' available
cd /home/fmaroufs
module load slurm
# module list
module load anaconda/2023.07
# conda info --envs
# conda activate climate2
# conda info --envs
module load cuda/11.6    # Use whichever cuda version required by your code

source activate climate2
conda activate climate2   # Use the right python interpreter

cd /home/fmaroufs/projects/SiT   # Assuming you have a 'train.py' in this directory

echo "Job started at: " `date`
echo "Job running on: " `hostname`
echo "Module list:"
module list

# for Tensorflow
#export TF_CPP_MIN_LOG_LEVEL=2   # ignore TF libpng warnings: https://github.com/tensorflow/tensorflow/issues/31870

echo "Python version is:"
which python

cd /home/fmaroufs/projects/SiT   # Assuming you have a 'train.py' in this directory

echo "Job started at: " `date`
echo "Job running on: " `hostname`
echo "Module list:"
module list

python3 train_cifar.py  --device cuda


 train.py --model SiT-S/4 \
          --data-path data \
          --path-type Linear \
          --prediction velocity \
          --epochs 1000 \
          --results-dir 'workspace' \
          --image-size 32 \
          --sample-every 1000 \
