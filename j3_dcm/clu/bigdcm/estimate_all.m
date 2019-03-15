
% estimates all DCMs that start with DCMname
% DCM specified in GUI and copied for each user, VOIs replaced using
% specify_DCMs.m

DCMname = 'DCM_clu*';
DCMdir = '/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu/m2';
dirs = {'m0001', 'm0002', 'm0003'};


if matlabpool('SIZE') == 0
    matlabpool(8);
end;

for d=1:length(dirs)
    DCMs = dir(fullfile(DCMdir, dirs{d}, DCMname));
    parfor i=1:size(DCMs, 1)
       spm_dcm_estimate(fullfile(DCMdir, dirs{d}, DCMs(i).name)); 
%         dir(fullfile(DCMdir, dirs{d}, DCMs(i).name));
    end
end