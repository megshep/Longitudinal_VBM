!/bin/bash
#SBATCH --job-name=segment_avg
#SBATCH --output=/mnt/iusers01/nm01/j90161ms/logs/segment_avg_%A_%a.out
#SBATCH --error=/mnt/iusers01/nm01/j90161ms/logs/segment_avg_%A_%a.err
#SBATCH --array=1-1231%1231
#SBATCH --time=72:00:00
#SBATCH --mem=20G
#SBATCH --cpus-per-task=1

# Load required modules
module load apps/binapps/matlab/R2024b 

# Set the SPM path environment variable
export USER_SPM_DIR="/mnt/iusers01/nm01/j90161ms/scratch/spm25/spm"

# Ensure we run in the job submission directory
cd "$SLURM_SUBMIT_DIR"

SUB_ID=$SLURM_ARRAY_TASK_ID

# Run the MATLAB script 
matlab -nodisplay -nosplash -batch "try;addpath(getenv('USER_SPM_DIR'));run('/mnt/iusers01/nm01/j90161ms/~longitudi>

