%-----------------------------------------------------------------------
% Job saved on 22-Jan-2016 16:44:01 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
%-----------------------------------------------------------------------

regions = {'V1', 'rFusFace', 'rFusObj', 'rAmy', 'OFC', 'rslOFC'}; % 
coordinates = {[0 -94 4], [43.5 -52 -22], [28.5 -64 -8.5], [18 -7 -17.5], [4.5 39.5 -13], [2 48 -18]}; % ronnyOFC from SAD habituation paper and disrupted DCM paper; V1 from Allan. old V1: [0 -89.5 0.5]
interactive = 1; % if interactive or serial matlabbatch


i=1;
TRs = {'0.7','1.4'};
subs = {
% %     'empro15_001'
% %     'empro15_002'
% %     'empro15_003'
% %     'empro15_005'
% %     'empro15_006'
    'empro15_007'
%     'empro15_009'
%     'empro15_010'
%     'empro15_011'
%     'empro15_012'
%     'empro15_013'
%     'empro15_014'
%     'empro15_015'    
%     'empro15_016'
%     'empro15_018'
    };
contrastno = [0 4 8 4 0 0]; % EOI, edt>odt, edt<odt, edt>odt, EOI % = contrastno-1 
% contrastno = [1 2 19 2 1 1]; % EOI, edt>odt, edt-odt, edt>odt, EOI % wrong, numbers are from SL! -_-
% contrastno = [1 2 6 2 1]; % EOI, first edt-odt, first odt>eedt, first edt-odt

maskimages = [0 1 1 1 0 0]; % V1 uses sphere instead of mask, OFC also. 
maskpath = '/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/2_secondlevel/sl_s6_TR1.4_wm_csf_flexiblefactorial/';
clear matlabbatch;

for s=1:length(subs);
    for m=2:2
        for t=1:1
            for r=1:3
                for reg=1:size(regions,2)
                    matlabbatch{i}.spm.util.voi.spmmat = {['/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/1_firstlevel/fl_session_s6_wm_csf/m' num2str(m) '/' TRs{t} '/' subs{s} '/SPM.mat']};
                    matlabbatch{i}.spm.util.voi.adjust = r; % F-contrast no. 1-3 is eoi of each run
                    matlabbatch{i}.spm.util.voi.session = r;
                    matlabbatch{i}.spm.util.voi.name = regions{reg}; % ['run' num2str(r) '_' regions{reg}]; % name of region, numeration of runs automatic
                    matlabbatch{i}.spm.util.voi.roi{1}.spm.spmmat = {''};
                    matlabbatch{i}.spm.util.voi.roi{1}.spm.contrast = contrastno(reg)+1; % new 
                    matlabbatch{i}.spm.util.voi.roi{1}.spm.conjunction = 1;
                    matlabbatch{i}.spm.util.voi.roi{1}.spm.threshdesc = 'none';
                    matlabbatch{i}.spm.util.voi.roi{1}.spm.thresh = 0.05;
                    matlabbatch{i}.spm.util.voi.roi{1}.spm.extent = 0;
                    matlabbatch{i}.spm.util.voi.roi{1}.spm.mask = struct('contrast', {}, 'thresh', {}, 'mtype', {});
                    
                    
                    matlabbatch{i}.spm.util.voi.roi{2}.sphere.centre = coordinates{reg}; % coordinates
                    matlabbatch{i}.spm.util.voi.roi{2}.sphere.radius = 10;
                    if reg==6
%                         matlabbatch{i}.spm.util.voi.roi{2}.sphere.move.fixed = 0;
                        matlabbatch{i}.spm.util.voi.roi{2}.sphere.move.local.spm = 1;
                        matlabbatch{i}.spm.util.voi.roi{2}.sphere.move.local.mask = '';
                    else
                        matlabbatch{i}.spm.util.voi.roi{2}.sphere.move.fixed = 1;                    
                    end
                    matlabbatch{i}.spm.util.voi.expression = 'i1 & i2';
                    
                    if maskimages(reg)
                        
                        matlabbatch{i}.spm.util.voi.roi{3}.mask.image = {[ maskpath '/mask_' regions{reg} '.nii,1']};
                        matlabbatch{i}.spm.util.voi.roi{3}.mask.threshold = 0.5;
                        matlabbatch{i}.spm.util.voi.expression = 'i1 & i2 & i3';
                    
%                     else
%                         matlabbatch{i}.spm.util.voi.roi{2}.sphere.centre = coordinates{reg}; % coordinates, change accordingly
%                         matlabbatch{i}.spm.util.voi.roi{2}.sphere.radius = 10;
%                         matlabbatch{i}.spm.util.voi.roi{2}.sphere.move.fixed = 1;
                    end
                    

                    
                    if interactive                        
                        i=i+1;
                    else                        
                        spm_jobman('serial',matlabbatch); % 'serial' or 'interactive'
                    end
                end
            end
        end
    end
end
if interactive
    spm_jobman('interactive',matlabbatch); % 'serial' or 'interactive'
end
