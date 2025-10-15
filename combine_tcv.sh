#!/bin/bash
#SBATCH --job-name=combine_tcv
#SBATCH --output=/mnt/iusers01/nm01/j90161ms/logs/combine_tcv.out
#SBATCH --error=/mnt/iusers01/nm01/j90161ms/logs/combine_tcv.err
#SBATCH --time=00:30:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1

# Load MATLAB
module load apps/binapps/matlab/R2024b

# Go to working directory
cd "$SLURM_SUBMIT_DIR"

# Run MATLAB script submitted
matlab -nodisplay -nosplash -batch "try; run('/mnt/iusers01/nm01/j90161ms/~longitudinal_vbm/combine_tcv.m'); catch ME; disp(getReport(ME)); exit(1); end; exit(0);"
