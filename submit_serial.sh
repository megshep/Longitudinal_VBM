#!/bin/bash
#SBATCH --job-name=serial_reg
#SBATCH --output=/mnt/iusers01/nm01/j90161ms/logs/serial_reg_%A_%a.out
#SBATCH --error=/mnt/iusers01/nm01/j90161ms/logs/serial_reg_%A_%a.err
#SBATCH --array=1-1233%20
#SBATCH --time=72:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=1

# Load required modules
module load apps/binapps/matlab/R2024b 
module load apps/binapps/matlab/third-party-toolboxes/spm/12.5

source $SPM_COPY

# Set the SPM path environment variable (assuming you've copied SPM with source $SPM_COPY)
export USER_SPM_DIR="/mnt/iusers01/nm01/j90161ms/scratch/SPM12.5"

# Ensure we run in the job submission directory
cd "$SLURM_SUBMIT_DIR"

SUB_ID=$SLURM_ARRAY_TASK_ID

# Run the MATLAB script 
matlab -nodisplay -nosplash -batch "try;addpath(getenv('USER_SPM_DIR'));run('/mnt/iusers01/nm01/j90161ms/~longitudinal_vbm/serial_reg_csf.m');catch ME;fprintf(2,'Error: %s\n', ME.message);disp(getReport(ME, 'extended'));end;exit"
