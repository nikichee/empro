
% this script estimates DCMs for all subjects and sessions based
% on DCMs specified in the specify_all_variations_cludata.m script
%

DCMdir = '/z/fmri/data/empro15/analysis/edt/3_dcm/rAmy-OFC_clu/';

group = 'hc';
setenv('LC_ALL','C'); % if importdata doesn't work, this helps
subs = importdata(['/z/fmri/data/empro15/analysis/edt/jobs/j3_dcm/clu/mdd.' group '_current.txt']);


if matlabpool('SIZE') == 0
    matlabpool(8);
end;

for s=1:length(subs);
    for m=1:2
        parfor temp = 1:16
            thisdir = fullfile(DCMdir, ['m' num2str(m)], subs{s}, 'variations'); % ['/z/fmri/data/empro15/analysis/edt/3_dcm/'m' num2str(m) '/' TRs{t} '/' subs{s} '/'];
            thisDCMname = sprintf( 'DCM_m%04d.mat', temp);
            thisDCM = fullfile(thisdir, thisDCMname);
            disp(thisDCM);
%             ls thisDCM
            spm_dcm_estimate(thisDCM)
        end
    end
end






