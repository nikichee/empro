%-----------------------------------------------------------------------
% Job saved on 22-Jan-2016 16:44:01 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
%-----------------------------------------------------------------------

regions = {'V1', 'rFusFace', 'rFusObj', 'rAmy'};
coordinates = {[0 -89.5 0.5], [43.5 -52 -22], [28.5 -64 -8.5], [18 -5.5 -19]};

clear matlabbatch;


                
matlabbatch{1}.spm.util.voi.spmmat = {'/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/1_firstlevel/fl_session_s6/m1/1.4/empro15_001/SPM.mat'};
matlabbatch{1}.spm.util.voi.adjust = 1; % contrast no. 1 is eoi
matlabbatch{1}.spm.util.voi.session = 1;
matlabbatch{1}.spm.util.voi.name = 'rAmy'; % name of region, change accordingly
matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''};
matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 12; %contrast 12: 110>80%MT
matlabbatch{1}.spm.util.voi.roi{1}.spm.conjunction = 1;
matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.1; %significance threshold
matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0;
matlabbatch{1}.spm.util.voi.roi{1}.spm.mask = struct('contrast', {}, 'thresh', {}, 'mtype', {});
matlabbatch{1}.spm.util.voi.roi{2}.sphere.centre = [18 -5.5 -19]; % coordinates, change accordingly
matlabbatch{1}.spm.util.voi.roi{2}.sphere.radius = 10;

matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.fixed = 1;
% matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.spm = 12; % contrast 12, to select maximum, optional! 
% matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.mask = '';
matlabbatch{1}.spm.util.voi.expression = 'i1 & i2';

spm_jobman('interactive',matlabbatch); % 'serial' or 'interactive'


