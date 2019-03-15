%-----------------------------------------------------------------------
% Job saved on 15-May-2015 18:09:34 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
%-----------------------------------------------------------------------
clear matlabbatch;

% function [] = analyze_edt_blocks_new()
measurements_to_analyze = {
    'EMPRO15_002_M1'; 'EMPRO15_002_M2'
% 
%     'EMPRO15_001_M1'; 
%     'EMPRO15_003_M1'; 'EMPRO15_005_M1'; 'EMPRO15_006_M1';
%     'EMPRO15_007_M1'; 'EMPRO15_009_M1'; 'EMPRO15_010_M1'; 'EMPRO15_011_M1';
%     'EMPRO15_012_M1';'EMPRO15_013_M1'; 'EMPRO15_014_M1'; 
%     'EMPRO15_015_M1';
%     'EMPRO15_016_M1'; 'EMPRO15_018_M1';
%     'EMPRO15_001_M2'; 'EMPRO15_003_M2'%; 
%     'EMPRO15_005_M2'; 'EMPRO15_006_M2';
%     'EMPRO15_007_M2'; 'EMPRO15_009_M2'; 'EMPRO15_010_M2'; 'EMPRO15_011_M2'%;
%     'EMPRO15_012_M2';'EMPRO15_013_M2'; 'EMPRO15_014_M2'; 'EMPRO15_015_M2';
%     'EMPRO15_016_M2'; 'EMPRO15_018_M2'
    
    % no realignment parameters for 'EMPRO15_006_M1', EMPRO15_014_M1', 'EMPRO15_011_M2'
    };
TRs = {'1400', '0700'};

addpath(genpath('/z/fmrilab/lab/spm/spm12/'));


clear matlabbatch;
addpath /net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/

folders = dir('/z/fmri/data/empro15/analysis/edt/preproc/m1/1.4/run1/empro15_*');

study_dir = '/z/fmri/data/empro15/analysis/';
ana_dir = fullfile(study_dir, 'test/');
preproc_dir = fullfile(study_dir, 'edt/preproc/');
% log_dir = '/z/fmri/data/clu12p/logs/trio/';
i=1; % for continuous batches, not counting nonexistent preproc files
targetfile = 'iwrbuadvols.nii'; % 'siwrbuadvols.nii'


% for k=1:length(folders) % k going through subjects
for s=1:size(measurements_to_analyze,1)
    name = measurements_to_analyze{s};
    for t=1:2
        
        tr=TRs{t}; %in ms
        cm=lower(name(end-1:end)); % cm='m1';
        csubj=lower(name(1:end-3)); % csubj='empro15_001';
        TR=(str2double(tr)/1000); % TR=0.7; in s
        analysisdir = ['/z/fmri/data/empro15/analysis/edt/1_firstlevel/fl_session_s0/' cm '/' num2str(TR) '/' csubj '/'];
        
        
        % matlabbatch{3*i-2}.spm.stats.fmri_spec.dir = {'/net/mri.meduniwien.ac.at/projects/physics/fmri/data/clu12p/analysis/fvas/ngeis/firstlevel/clu12-p004/'};
        matlabbatch{3*i-2}.spm.stats.fmri_spec.dir = {analysisdir};% {fullfile(ana_dir, folders(k).name)};
        matlabbatch{3*i-2}.spm.stats.fmri_spec.timing.units = 'secs';
        matlabbatch{3*i-2}.spm.stats.fmri_spec.timing.RT = TR;
        matlabbatch{3*i-2}.spm.stats.fmri_spec.timing.fmri_t = 78;
        matlabbatch{3*i-2}.spm.stats.fmri_spec.timing.fmri_t0 = 39;
        %%
        
        for r=1:3
            
            
            crun = r;
            
            
            scanpath=['/z/fmri/data/empro15/analysis/edt/preproc/' cm '/' num2str(TR) '/run' num2str(crun) '/' csubj '/'];
            
            
            %     scanpath = fullfile(preproc_dir, folders(k).name, 'siwrbadvols.nii');
            if ~exist(fullfile(scanpath, targetfile), 'file') % if no swrbadvols.nii exists for this subject, continue with next subject
                continue
            end
            
            %             if ~(exist(folders(k).name, 'file') == 7) % if the folder for this subject does not exist yet, create it
            %                 mkdir(folders(k).nam disp(['no realignment parameters for ' name '!! ']);e);
            %             end
            
            % create cell array with scans
            
            tmp = nifti(fullfile(scanpath, targetfile));
            scanfiles = cell(tmp.dat.dim(4),1);
            for j=1:tmp.dat.dim(4)
                scanfiles(j) = {[fullfile(scanpath, targetfile), ',', num2str(j)]};
            end
            clear tmp;
            matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).scans = scanfiles;
            clear scans;
            %%
            
            [eedton, iedton, odton] = getblocks(name, tr, r);
            conditionnames={'eedt','iedt','odt'};
            onsets={eedton iedton odton};
            dur=20;
            
            for conds=1:size(conditionnames,2)
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).cond(conds).name = conditionnames{conds};
                %%
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).cond(conds).onset = onsets{conds};
                %%
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).cond(conds).duration = dur;
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).cond(conds).tmod = 0;
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).cond(conds).pmod = struct('name', {}, 'param', {}, 'poly', {});
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).cond(conds).orth = 1;
            end
            matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).multi = {''};
            
            clear eedton iedton odton conditionnames onsets duration;
            
            %%
            % tmp = load('/net/mri.meduniwien.ac.at/projects/physics/fmri/data/clu12p/analysis/fva4s/preproc/clu12-p004/tc_wm_csf_global_rp_wrbadvols.txt');
            if exist(fullfile(scanpath, 'rbuadvols.nii.par.txt'), 'file') %'tc_wm_csf_global_rp_iwrbuadvols.txt'
                realignmentparameters = load(fullfile(scanpath, 'rbuadvols.nii.par.txt')); % 'tc_wm_csf_global_rp_iwrbuadvols.txt'
                
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(1).name = 'RP1';
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(1).val = realignmentparameters(:,end-5);
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(2).name = 'RP2';
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(2).val = realignmentparameters(:,end-4);
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(3).name = 'RP3';
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(3).val = realignmentparameters(:,end-3);
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(4).name = 'RP4';
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(4).val = realignmentparameters(:,end-2);
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(5).name = 'RP5';
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(5).val = realignmentparameters(:,end-1);
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(6).name = 'RP6';
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(6).val = realignmentparameters(:,end);
                
                clear realignmentparameters;
            else
                disp(['no realignment parameters for ' name ', ' cm ', ' num2str(TR) ', run' num2str(r) '!! ']);
                matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress = struct('name', {}, 'val', {});
            end
            
            
            
            % matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress = struct('name', {}, 'val', {});
            
            matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).multi_reg = {''};
            matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).hpf = 128;
        end
        
        matlabbatch{3*i-2}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
        matlabbatch{3*i-2}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
        matlabbatch{3*i-2}.spm.stats.fmri_spec.volt = 1;
        matlabbatch{3*i-2}.spm.stats.fmri_spec.global = 'None';
        matlabbatch{3*i-2}.spm.stats.fmri_spec.mthresh = 0;
        matlabbatch{3*i-2}.spm.stats.fmri_spec.mask = {'/z/fmrilab/lab/preprocessing/template/brainmask_MNI_epi_space.nii,1'};
        %         matlabbatch{3*i-2}.spm.stats.fmri_spec.mask = {'/bilbo/usr/local/spm12/tpm/brainmask.nii,1'};
        matlabbatch{3*i-2}.spm.stats.fmri_spec.cvi = 'AR(1)';
        
        
        matlabbatch{3*i-1}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{3*i-2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
        matlabbatch{3*i-1}.spm.stats.fmri_est.write_residuals = 0;
        matlabbatch{3*i-1}.spm.stats.fmri_est.method.Classical = 1;
        
        
        matlabbatch{3*i}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{3*i-1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
        coni = 1;
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.fcon.name = 'EOI';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.fcon.weights = eye(3);
        matlabbatch{3*i}.spm.stats.con.consess{coni}.fcon.sessrep = 'both';
        coni = coni+1;
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = 'edt>odt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = [1 1 -2];
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.sessrep = 'both';
        coni = coni+1;
        
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = 'edt<odt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = [-1 -1 2];
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.sessrep = 'both';
        coni = coni+1;
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = 'eedt>odt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = [1 0 -1];
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.sessrep = 'both';
        coni = coni+1;
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = 'eedt<odt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = [-1 0 1];
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.sessrep = 'both';
        coni = coni+1;
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = 'eedt>iedt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = [1 -1];
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.sessrep = 'both';
        coni = coni+1;
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = 'eedt<iedt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = [-1 1];
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.sessrep = 'both';
        coni = coni+1;
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = 'eedt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = 1;
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.sessrep = 'both';
        coni = coni+1;
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = 'iedt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = [0 1];
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.sessrep = 'both';
        coni = coni+1;
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = 'oedt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = [0 0 1];
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.sessrep = 'both';
        coni = coni+1;
        
        matlabbatch{3*i}.spm.stats.con.delete = 1;
        
        i = i+1;
        
        %             for jobmode='interactive':
        %         y = input('Continue? ', 's');
        %         if y=='n'
        %             return
        %         end
        %
    end
end


%     spm_jobman('serial',matlabbatch); % 'serial' or 'interactive'
spm_jobman('interactive',matlabbatch); % 'serial' or 'interactive'
%%



%
% for s=1:size(measurements_to_analyze,1)
%     name = measurements_to_analyze{s};
%     for t=1:2
%         for r=1:3
%             tr=TRs{t}; %in ms
%             [eedton, iedton, odton] = getblocks(name, tr, r);
%
%             csubj=lower(name(1:end-3)); % csubj='empro15_001';
%             cm=lower(name(end-1:end)); % cm='m1';
%             crun = r;
%             TR=(str2double(tr)/1000); % TR=0.7; in s
%
%             analysisdir=['/z/fmri/data/empro15/analysis/test/analysis_edt_all_newpre/' cm '/' num2str(TR) '/run' num2str(crun) '/' csubj '/'];
%             ScanFolder=['/z/fmri/data/empro15/analysis/edt/preproc/' cm '/' num2str(TR) '/run' num2str(crun) '/' csubj '/'];
%
%
%             conditionnames={'eedt','iedt','odt'};
%             onsets={eedton iedton odton};
%             duration=20;
%
%             % mtFlex_unwarped(ScanFolder,analysisdir,TR,duration,onsets,conditionnames,svbcons,normalised,jobmode)
%             disp([ScanFolder, analysisdir, TR, duration, onsets, conditionnames,true,true,'serial'])
%             mtFlex_unwarped(ScanFolder,analysisdir,TR,duration,onsets,conditionnames,true,true,'interactive')
%
% %             for jobmode='interactive':
%             y = input('Continue? ', 's');
%             if y=='n'
%                 return
%             end
%
%         end
%     end
% end

% 
% 
% 
%     function [eedton, iedton, odton] = getblocks(name, TR, r)
%         % function [eedton, iedton, odton] = getblocks(name, TR, r)
%         % name ... subjectname incl. measturementnumber, e.g. EMPRO15_001_M1
%         % TR in {'0700', '1400'}
%         % r in {1, 2, 3} .. run number
%         
%         % for each subject, measurement, run... e.g.
%         %name = 'EMPRO15_001_M1';
%         %TR = '0700'; r=2;
%         
%         ID = strcat('/z/fmri/data/empro15/logs/', name, '/edt_run',num2str(r),'_TR', TR, '_*');
%         disp(ID);
%         
%         %logfilename = ls('../../logs/EMPRO15_002_M1*/edt_run1_TR0700_*'); %to account for timestamp in name
%         ls(ID)
%         logfilename = ls(ID);% ls(ID{1,1})
%         logfilename = cellstr(logfilename);
%         logfilename = logfilename{1,1};
%         
%         fid = fopen(logfilename, 'r');
%         log = textscan(fid, repmat('%s',1,8), 'delimiter',';', 'CollectOutput',true);
%         log = log{1};
%         fclose(fid);
%         
%         % get trigger and block onsets
%         trigger = 0;
%         eedton = [];
%         iedton = [];
%         odton = [];
%         
%         [lines, ~] = size(log);
%         for i=1:lines
%             if strcmp(log(i,2),'trigger')
%                 trigger = str2double(log{i,1});
%             elseif strcmp(log(i,2),'starting_block_eedt')
%                 eedton(end+1) = str2double(log{i,1}) - trigger;
%             elseif strcmp(log(i,2),'starting_block_iedt')
%                 iedton(end+1) = str2double(log{i,1}) - trigger;
%             elseif strcmp(log(i,2),'starting_block_odt')
%                 odton(end+1) = str2double(log{i,1}) - trigger;
%             end
%         end
%         
%         
%     end
% end
