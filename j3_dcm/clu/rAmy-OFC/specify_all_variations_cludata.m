
% this script specifies DCMs for all subjects, runs, sessions and TRs based
% on a DCM template specified via the GUI,
% VOIs extracted using the VOI_allregion.m script
% https://www.jiscmail.ac.uk/cgi-bin/webadmin?A2=spm;f1b5332f.1205
% after specifying, following steps are done:
% estimation of models
% comparison / averaging / inference on models

DCMdir = '/z/fmri/data/empro15/analysis/edt/3_dcm/rAmy-OFC_clu/'; % !!!!
templatedirs = {
    '/z/fmri/data/empro15/analysis/edt/3_dcm/templates/rAmy-OFC_eo_TR1.4/'
    '/z/fmri/data/empro15/analysis/edt/3_dcm/templates/rAmy-OFC_eo_TR0.7/'
    };

templatedir=templatedirs{1};
templatename = 'DCM_m*';
tmp = ls(fullfile(templatedir, templatename));
template=strsplit(tmp); tmp(end)=[];
firstleveldir = '/z/fmri/data/clu12/analysis/edt/analysis_spm/fl_preprocv3_wmcsf/';

group = 'hc';
subs = importdata(['/z/fmri/data/empro15/analysis/edt/jobs/j3_dcm/clu/mdd.' group '_current.txt']);

for s=1:length(subs);
    for m=1:2
        for temp=1:16% length(template);
            
            % make directories in dcm folder
            thisdir = fullfile(DCMdir, ['m' num2str(m)], subs{s}); % ['/z/fmri/data/empro15/analysis/edt/3_dcm/'m' num2str(m) '/' TRs{t} '/' subs{s} '/'];
            d = [thisdir '/variations'];
            mkdir(d);
            
            % copy the DCM template for each run:            
            thisDCM = sprintf( '%sDCM_m%04d.mat', 'variations/', temp );
            thisDCM = fullfile(thisdir, thisDCM);
            disp(thisDCM);
            disp(template{temp});
            copyfile(template{temp}, thisDCM);
            
            
            % replace VOIs for sessions
            voi_filenames = {fullfile(firstleveldir, ['m' num2str(m) '/all/'  subs{s} '/VOI_rAmy_1']),fullfile(firstleveldir, ['m' num2str(m) '/all/'  subs{s} '/VOI_mOFC_1'])}; % spm_dcm_voi(DCM_filename,voi_filenames)
            spm_dcm_voi(thisDCM,voi_filenames)
            
            % replace time series
            spm_dcm_U(thisDCM, fullfile(firstleveldir, ['m' num2str(m) '/all/'  subs{s} '/SPM.mat']), 1, {1, 1}); % {edt, odt}; % spm_dcm_U(DCM_filename,SPM_filename,session,input_nos)
            
            
            % estimate the DCM: via estimate_all_variations_cludata.m
        end
    end
end

