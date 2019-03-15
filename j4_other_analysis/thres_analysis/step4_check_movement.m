
fd=1; % if we want to create means of framewise displacement
res=1; % if we want to get residuals

% calculates mean and rootmeansquare of framewise displacement of each run,
% for each subject

subs = importdata('/z/fmri/data/empro15/analysis/edt/good_subjects.txt');

if(fd)
    fds.mean = zeros(length(subs),6);
    fds.rms = zeros(length(subs),6); % root mean square
    
    
    for s = 1:length(subs)
        for m=1:2
            for r=1:3
                %             disp(['/z/fmri/data/empro15/analysis/edt/preproc/m' num2str(m) '/1.4/run' num2str(r) '/' subs{s} '/ms_fd.txt']);
                fd = importdata(['/z/fmri/data/empro15/analysis/edt/preproc/m' num2str(m) '/1.4/run' num2str(r) '/' subs{s} '/ms_fd.txt']);
                fds.mean(s,r+3*(m-1)) = mean(fd);
                fds.rms(s,r+3*(m-1)) = sqrt(mean(fd .^2));
            end
        end
    end
end

if(res)
    % correlate fds with t-value:
    % load('/z/fmri/data/empro15/analysis/edt/jobs/j4_other_analysis/thres_analysis/clusterresults.mat');
    % active voxels in cluster per subject
    
    addpath('/z/fmri/data/empro15/analysis/edt/jobs/j4_other_analysis');
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
    firstleveldir = '/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/1_firstlevel/fl_session_s6_wm_csf/'; % m1/1.4/empro15_010'
    TRs={'1.4', '0.7'};
    % fds.ResMS = zeros(length(subs),6); % residual mean square
    for s = 1:length(subs)
        for m=1:2
            for t=1:2
                subjectdir = fullfile(firstleveldir, ['m' num2str(m) '/' TRs{t} '/' subs{s}]);
                for c = 1:length(clusternames_short)
                    if(s==m==t==1)
                        residuals(c).name = clusternames_short{c};
                    end
                    residuals(c).TR(t).val(s,m) = get_value_from_nifti( mnicoo(:,c)', fullfile(subjectdir, 'ResMS.nii') );
                end
            end
        end
    end
    
end


% now compare visually: fds.mean and fds.rms and residuals(c) to
% clusterresults(c) from previous step. also could be researched: residuals
% from each run, calculate resMS=T/beta? 