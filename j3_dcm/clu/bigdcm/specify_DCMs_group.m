
% this script specifies DCMs in folders for all subjects based
% on a DCM template specified via the GUI, 
% VOIs extracted using the VOI_allregion.m script
% https://www.jiscmail.ac.uk/cgi-bin/webadmin?A2=spm;f1b5332f.1205

DCMdir = '/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu/';
templatedir = '/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu'; 
group = 'all';

subs = importdata(['/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu/mdd.' group '_current.txt']);
regions = {'V1', 'lDLPFC', 'lVLPFC', 'lAmy', 'mOFC', 'rAmy', 'rVLPFC', 'rDLPFC'}; 

template = 'DCM_tmpl.mat';

TRs = {'1.4'};



for s=1:length(subs);
    for m=2:2
        for dirs =1:3            
            % specify subject VOI directory
            thisdir = fullfile(DCMdir,['m' num2str(m)], ['m000' num2str(dirs)]); % ['/z/fmri/data/empro15/analysis/edt/3_dcm/'m' num2str(m) '/' TRs{t} '/' subs{s} '/'];
            
            thisDCM=fullfile(thisdir, ['DCM_' subs{s} '.mat']);
            copyfile(fullfile(fullfile(DCMdir,['m' num2str(m)], ['m000' num2str(dirs)]), template), thisDCM); % copy template from 'm1/m000x'
            
            VOI_dir = ['/z/fmri/data/clu12/analysis/edt/analysis_spm/fl_preprocv3_wmcsf/m' num2str(m) '/all/' subs{s}]; 
            
            % full names for each region
            voi_filenames = {};% cell(size(regions,2),1);
            for r=1:size(regions,2)
                voi_filenames(r,1) = {fullfile(VOI_dir, ['VOI_' regions{r} '_1.mat'])};
            end

%                 % replace VOIs for sessions 
                spm_dcm_voi(thisDCM,voi_filenames);
              
%                 % replace time series
                spm_dcm_U(thisDCM, fullfile(VOI_dir, 'SPM.mat'), 1, {1, 1}); % {eedt, iedt, odt, face, task}; % spm_dcm_U(DCM_filename,SPM_filename,session,input_nos)

%                 % estimate the DCM: via estimate_all.m   
        end
    end
end

