%-----------------------------------------------------------------------
% Job saved on 22-Jan-2016 16:44:01 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
%-----------------------------------------------------------------------

regions = {'V1', 'rAmy', 'lAmy', 'rDLPFC', 'lDLPFC', 'rVLPFC', 'lVLPFC', 'mOFC'}; 
coordinates = {[0 -94 4], [18 -7 -17.5], [-18 -7 -17.5], [46.5 17 27.5], [-45 18.5 29], [46 32 -2.5], [-43.5 29 -1], [3 45.5 -20.5]}; %
interactive = 0; % if interactive or serial matlabbatch

% spm_jobman('initcfg');
i=1;
TRs = {'1.4'};
subs = importdata('/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu/mdd.missingvois_current.txt');

contrastno = [1 2 2 2 2 2 2 2]; % EOI, edt>odt


maskimages = [0 0 0 0 0 0 0 0]; % no masking
%maskpath = '/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/2_secondlevel/sl_s6_TR1.4_wm_csf_flexiblefactorial/';
clear matlabbatch;

for s=1:length(subs);
    for m=1:2
        for reg=1:size(regions,2)
            matlabbatch{i}.spm.util.voi.spmmat = {['/z/fmri/data/clu12/analysis/edt/analysis_spm/fl_preprocv3_wmcsf/m' num2str(m) '/all/' subs{s} '/SPM.mat']};
            matlabbatch{i}.spm.util.voi.adjust = 1; % contrast no. 1 is eoi
            matlabbatch{i}.spm.util.voi.session = 1;
            matlabbatch{i}.spm.util.voi.name = regions{reg}; % ['run' num2str(r) '_' regions{reg}]; % name of region, numeration of runs automatic
            matlabbatch{i}.spm.util.voi.roi{1}.spm.spmmat = {''};
            matlabbatch{i}.spm.util.voi.roi{1}.spm.contrast = contrastno(reg);
            matlabbatch{i}.spm.util.voi.roi{1}.spm.conjunction = 1;
            matlabbatch{i}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
            matlabbatch{i}.spm.util.voi.roi{1}.spm.thresh = 0.05;
            matlabbatch{i}.spm.util.voi.roi{1}.spm.extent = 0;
            matlabbatch{i}.spm.util.voi.roi{1}.spm.mask = struct('contrast', {}, 'thresh', {}, 'mtype', {});
            
            
            matlabbatch{i}.spm.util.voi.roi{2}.sphere.centre = coordinates{reg}; % coordinates
            matlabbatch{i}.spm.util.voi.roi{2}.sphere.radius = 10;
            %if reg==6
            %                         matlabbatch{i}.spm.util.voi.roi{2}.sphere.move.fixed = 0;
            matlabbatch{i}.spm.util.voi.roi{2}.sphere.move.local.spm = 1;
            matlabbatch{i}.spm.util.voi.roi{2}.sphere.move.local.mask = '';
            %else
            %matlabbatch{i}.spm.util.voi.roi{2}.sphere.move.fixed = 1;
            %end
            matlabbatch{i}.spm.util.voi.expression = 'i1 & i2';
            
            %if maskimages(reg)
            
            %matlabbatch{i}.spm.util.voi.roi{3}.mask.image = {[ maskpath '/mask_' regions{reg} '.nii,1']};
            %matlabbatch{i}.spm.util.voi.roi{3}.mask.threshold = 0.5;
            %matlabbatch{i}.spm.util.voi.expression = 'i1 & i2 & i3';
            
            %                     else
            %                         matlabbatch{i}.spm.util.voi.roi{2}.sphere.centre = coordinates{reg}; % coordinates, change accordingly
            %                         matlabbatch{i}.spm.util.voi.roi{2}.sphere.radius = 10;
            %                         matlabbatch{i}.spm.util.voi.roi{2}.sphere.move.fixed = 1;
            %end
            
            
            
            if interactive
                i=i+1;
            else
                spm_jobman('serial',matlabbatch); % 'serial' or 'interactive'
            end
        end
    end
end
if interactive
    spm_jobman('interactive',matlabbatch); % 'serial' or 'interactive'
end
