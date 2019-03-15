
% estimates all DCMs that start with DCMname
% DCM specified in GUI and copied for each user, VOIs replaced using
% specify_DCMs.m

% DCMname = 'DCM_clu*';
group='all';
meas='m2';
subs = importdata(['/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu/mdd.' group '_current.txt']);
DCMdir = ['/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu/' meas];
dirs = {'m0001', 'm0002', 'm0003'};


if matlabpool('SIZE') == 0
    matlabpool(8);
end;

for d=1:length(dirs)
    parfor i=1:size(subs, 1)
        DCMname = ['DCM_' subs{i} '.mat'];
        spm_dcm_estimate(fullfile(DCMdir, dirs{d}, DCMname));
%         disp(fullfile(DCMdir, dirs{d}, DCMname));
    end
end