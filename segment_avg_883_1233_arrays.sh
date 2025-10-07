#!/bin/bash
#SBATCH --job-name=segment_avg
#SBATCH --output=/mnt/iusers01/nm01/j90161ms/logs/segment_logs/segment_avg_%A_%a.out
#SBATCH --error=/mnt/iusers01/nm01/j90161ms/logs/segment_logs/segment_avg_%A_%a.err
#SBATCH --array=1-351%50       # 351 files (883→1233), max 50 concurrent jobs
#SBATCH --time=72:00:00
#SBATCH --mem=20G
#SBATCH --cpus-per-task=1

# Load MATLAB module
module load apps/binapps/matlab/R2024b 

# Set SPM path environment variable
export USER_SPM_DIR="/mnt/iusers01/nm01/j90161ms/scratch/spm25/spm"

# Change to the submission directory
cd "$SLURM_SUBMIT_DIR"

# Run the MATLAB segmentation script
matlab -nodisplay -nosplash -batch "try; addpath(getenv('USER_SPM_DIR')); run('/mnt/iusers01/nm01/j90161ms/~longitudinal_vbm/segment.m'); catch ME; fprintf(2,'Error: %s\n', ME.message); disp(getReport(ME,'extended')); end; exit"



