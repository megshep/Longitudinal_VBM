%-----------------------------------------------------------------------
% Normalise (affine registering to MNI 152 space) one rc1 image using its corresponding y_rc1 deformation field
% Run via SLURM array: e.g. #SBATCH --array=1-N
%-----------------------------------------------------------------------

% Get subject index from SLURM array
SUB_ID = str2double(getenv('SLURM_ARRAY_TASK_ID'));

% define the directory (for me, this is in my scratch space in the CSF3)
scratchDir = '/scratch/j90161ms';

% finds all of the rc1 and yrc1 files (these are the within-subject average images [rc1] and the deformation fields from creating the shoot templates [y_rc1] for GM)
rc1_files = dir(fullfile(scratchDir, 'rc1*.nii'));
yrc1_files = dir(fullfile(scratchDir, 'y_rc1*.nii'));

rc1_files = fullfile({rc1_files.folder}, {rc1_files.name});
yrc1_files = fullfile({yrc1_files.folder}, {yrc1_files.name});

rc1_files = sort(rc1_files);
yrc1_files = sort(yrc1_files);

% Build batch for the normalisation
% Input template 4 (output from creating SHOOT templates). This template is registered to MNI space (affine transform)
% allows the transformations to be combined so that all the individual spatially normalised scans can also be brought into MNI space.
matlabbatch{1}.spm.tools.shoot.norm.template = {fullfile(scratchDir, 'Template_4.nii')};

% Select the deformation fields for each subject that were created in the previous step of the analysis - this is in relation to the subjectID to allow for the jobs to be submitted as arrays
matlabbatch{1}.spm.tools.shoot.norm.data.subjs.deformations = {yrc1_files{SUB_ID}};

% Select the DARTEL imported grey matter images - again, in relation to the subjectID to allow for the jobs to be submitted as arrays
matlabbatch{1}.spm.tools.shoot.norm.data.subjs.images = {{rc1_files{SUB_ID}}};

% This keeps the voxels at 1.5mmx1.5mmx1.5mm - this matches my earlier analysis and is the default for any VBM 
matlabbatch{1}.spm.tools.shoot.norm.vox = [NaN NaN NaN];

% This defines the bounding box (the field of view for the spatially normalised images) - this is left as default
matlabbatch{1}.spm.tools.shoot.norm.bb = [NaN NaN NaN; NaN NaN NaN];

% This tells the model to preserve amount (“modulation”) - to allow the tissue volumes to be compared.
matlabbatch{1}.spm.tools.shoot.norm.preserve = 1;

% Defines the smoothing kernel to be used, between 4 and 12, I chose 8 as this matches my previous model used 
matlabbatch{1}.spm.tools.shoot.norm.fwhm = 8;

%run the job on spm
spm('defaults','FMRI');
spm_jobman('run', matlabbatch);
