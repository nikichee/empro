function clusterresults=step2_get_thresholds()

addpath /z/fmri/data/empro15/analysis/edt/jobs/j4_other_analysis/
firstleveldir = '/z/fmri/data/empro15/analysis/edt/1_firstlevel/fl_session_s6_wm_csf/';
masksdir='/z/fmri/data/empro15/analysis/masks/';
tthres_uncorr = 3.1; % uncorrected
tthres_corr = 4.9; % corrected

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

% clusternames_both = {
% 'Amy'
% 'Fus'
% 'DLPFC'
% 'STS'
% 'MTS'
% };

subs = {
    'empro15_001'
    'empro15_002'%
    'empro15_005'%
    'empro15_006'
    'empro15_007'%%
    'empro15_009'
    'empro15_010'%% T=2.27r/2.43l
    'empro15_011'
    'empro15_012'
    'empro15_013'
    'empro15_014'
    'empro15_015'
    'empro15_016'
    'empro15_018'
    };
TRs = {'1.4', '0.7'};

contrastfiles = { % for eedt>odt, run 1-3
    'spmT_0013.nii'
    'spmT_0014.nii'
    'spmT_0015.nii'
    'spmT_0016.nii'
    };


for c=1:size(clusternames_short, 1)
    maskfile = fullfile(masksdir, ['roi_' clusternames_short{c} '.nii']);
    clusterresults(c).name = clusternames_short{c};
    for t=1:2
        clusterresults(c).TR(t).uncorr = zeros(size(subs,1),6);
        clusterresults(c).TR(t).corr = zeros(size(subs,1),6);
        
        for s=1:size(subs,1)
            clusterresults(c).TR(t).subjects = subs;
            for m=1:2
                subdir = fullfile(firstleveldir,['m' num2str(m)], TRs{t}, subs{s});
                for con=1:size(contrastfiles,1)
                    confile = fullfile(subdir, contrastfiles{con});
                    
%                     cmd=['fslstats /z/fmri/data/empro15/analysis/edt/1_firstlevel/fl_session_s6/m1/1.4/empro15_009/spmT_0024.nii -k /z/fmri/data/empro15/analysis/masks/roi_lrAmy.nii -l 3 -V'];
                    cmd_uncorr=['fslstats ' confile ' -k ' maskfile ' -l ' num2str(tthres_uncorr) ' -V'];
                    disp(cmd_uncorr);
                    [status,result] = unix(cmd_uncorr);
                    if(status~=0)
                        disp('some error...');
                    end
                    vox_num_uncorr = str2num(strtok(result));
%                     disp(['vox num: ' vox_num]);
%                     disp('uncorr: ' );
%                     disp(clusterresults(c).TR(t).uncorr)
                    
                    cmd_corr=['fslstats ' confile ' -k ' maskfile ' -l ' num2str(tthres_corr) ' -V'];
                    disp(cmd_corr);
                    [status,result] = unix(cmd_corr);
                    if(status~=0)
                        disp('some error...');
                    end
                    vox_num_corr = str2num(strtok(result));
%                     disp(['vox num: ' vox_num]);
%                     disp('corr: ');
%                     disp(clusterresults(c).TR(t).corr)
                    if(con<4)
                        clusterresults(c).TR(t).uncorr(s,(m-1)*3+con) = vox_num_uncorr;
                        clusterresults(c).TR(t).corr(s,(m-1)*3+con) = vox_num_corr;
                    else
                        clusterresults(c).TR(t).allruns_uncorr(s,m) = vox_num_uncorr;
                        clusterresults(c).TR(t).allruns_corr(s,m) = vox_num_corr;
                    end
                    
                end
            end
        end
    end
end


end