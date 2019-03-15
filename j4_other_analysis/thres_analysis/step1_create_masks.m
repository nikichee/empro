function []=step1_create_masks()
% function []=create_masks()

tmp=pwd; 
cd('/z/fmri/data/empro15/analysis/masks/')

addpath /z/fmri/data/empro15/analysis/edt/jobs/j4_other_analysis/
[voxelindices, mnicoo, clusternames] = getclustercoordinates_first_eedt_odt();
clusternames_short = {
'rAmy'
'lAmy'
'rFus'
'lFus'
'rDLPFC'
'lDLPFC'
'rSTS'
'lSTS'
'rMTS'
'lMTS'
'rMTS2'
'mFG'
};

for c=1:size(clusternames_short, 1)
    % create mask
    cmd=['rsroi -i /z/fmrilab/lab/preprocessing/template/7t_epi_template_MNI.nii -m roi_' clusternames_short{c} '.nii -s 5 --center=' num2str(mnicoo(1,c)) ',' num2str(mnicoo(2,c)) ',' num2str(mnicoo(3,c)) ];
    [status, result] = unix(cmd);
    if(status~=0)
        disp(['error! command: ' cmd])
    end
%     disp(cmd)
end

clusternames_merge = {
'Amy'
'Fus'
'DLPFC'
'STS'
'MTS'
};
for c=1:size(clusternames_merge,1)
    cmd=['fslmaths roi_l' clusternames_merge{c} '.nii -add roi_r' clusternames_merge{c} '.nii roi_lr' clusternames_merge{c} '.nii'];
    [status, result] = unix(cmd);
end

cd(tmp)
end
