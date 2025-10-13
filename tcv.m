%% tcv.m
% This provides a subject ID with a SLURM array ID to allow for multiple job arrays to be submitted at the same time on the CSF
SUB_ID = str2double(getenv('SLURM_ARRAY_TASK_ID'));

% Defining the directory where the seg8.mat files are saved - this is the .mat file that contains the segmentation parameters of the avg templates made
segDir = '/scratch/j90161ms';

% Find and sort all seg8.mat files
seg_files = dir(fullfile(segDir, 'avg_*_seg8.mat'));
seg_files = fullfile({seg_files.folder}, {seg_files.name});
seg_files = sort(seg_files);

% Select this subject’s file and tell me which subject is running when I check the .out file 
this_seg = seg_files{SUB_ID};
disp(['Running TCV extraction for: ', this_seg]);

% Build SPM batch
% This inputs the segmentation parameters for each ID into the model and compares to the ICV mask from SPMs directory and produces a .txt file of the TCVs for each ID. 
matlabbatch{1}.spm.util.tvol.matfiles = {this_seg};
matlabbatch{1}.spm.util.tvol.tmax = 3;
matlabbatch{1}.spm.util.tvol.mask = {'/mnt/iusers01/nm01/j90161ms/scratch/spm25/spm/tpm/mask_ICV.nii,1'};
matlabbatch{1}.spm.util.tvol.outf = 'TCV';

% Run job on spm within CSF
spm('defaults', 'FMRI');
spm_jobman('run', matlabbatch);
