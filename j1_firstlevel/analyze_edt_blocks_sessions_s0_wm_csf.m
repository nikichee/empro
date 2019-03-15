%-----------------------------------------------------------------------
% Job saved on 15-May-2015 18:09:34 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
%-----------------------------------------------------------------------
clear matlabbatch;
interactive = 0;
% spm_jobman('initcfg');

% function [] = analyze_edt_blocks_new()
measurements_to_analyze = {
    
% % 'EMPRO15_001_M1'; 'EMPRO15_002_M1';
% % 'EMPRO15_003_M1'; 'EMPRO15_005_M1'; 'EMPRO15_006_M1';
% % 'EMPRO15_007_M1'; 'EMPRO15_009_M1'; 
% 'EMPRO15_010_M1'; 'EMPRO15_011_M1';
% 'EMPRO15_012_M1';'EMPRO15_013_M1'; 'EMPRO15_014_M1';
% 'EMPRO15_015_M1';
% 'EMPRO15_016_M1'; 'EMPRO15_018_M1';
% 

% 'EMPRO15_001_M2'; 'EMPRO15_002_M2'; 'EMPRO15_003_M2'%;
% 'EMPRO15_005_M2'; 'EMPRO15_006_M2';
% 'EMPRO15_007_M2';
% 'EMPRO15_009_M2';
'EMPRO15_010_M2';
'EMPRO15_011_M2'%;
'EMPRO15_012_M2';'EMPRO15_013_M2'; 'EMPRO15_014_M2'; 'EMPRO15_015_M2';
'EMPRO15_016_M2'; 'EMPRO15_018_M2'
    
    
    
%  'EMPRO15_006_M1'; 'EMPRO15_011_M1';'EMPRO15_014_M1'; 
%  'EMPRO15_005_M2';'EMPRO15_007_M2';'EMPRO15_011_M2'

% % 'EMPRO15_004_M1'
    % no realignment parameters for 'EMPRO15_006_M1'; 'EMPRO15_014_M1'; 'EMPRO15_011_M2': resolved, runs generally broken    
    };
TRs = {'1400', '0700'};

% addpath(genpath('/z/fmrilab/lab/spm/spm12/'));
% spm fmri

clear matlabbatch;
addpath /net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/

% folders = dir('/z/fmri/data/empro15/analysis/edt/preproc/m1/1.4/run1/empro15_*');

study_dir = '/z/fmri/data/empro15/analysis/';
preproc_dir = fullfile(study_dir, 'edt','preproc');
firstleveldir = fullfile(study_dir, 'edt', '1_firstlevel', 'fl_session_s0_wm_csf');
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
        TR=(str2double(tr)/1000); % TR=0.7; in sserial
        analysisdir = [firstleveldir '/' cm '/' num2str(TR) '/' csubj '/'];
        
        
% %         dafür muss noch matlabbatch in einzelne batches geteilt werden,
% %         sonst werden die files alle am anfang erstellt... 
% 
%         if(exist(fullfile(analysisdir, 'calculating.txt'), 'file'))
%             continue
%             disp([fullfile(analysisdir, 'calculating.txt') 'exists, continuing... ']);
%         else
%             % create directory
%             if(~exist(analysisdir,'dir'))
%                 disp(['creating directory ' analysisdir]);
%                 mkdir(analysisdir)
%             end
%             
%             % create file
%             fid = fopen( fullfile(analysisdir, 'calculating.txt'), 'wt' );
%             fprintf( fid, '%f, %f\n', 'calculating: ', clock);
%             fclose(fid);
%         end
        


        % matlabbatch{3*i-2}.spm.stats.fmri_spec.dir = {'/net/mri.meduniwien.ac.at/projects/physics/fmri/data/clu12p/analysis/fvas/ngeis/firstlevel/clu12-p004/'};
        matlabbatch{3*i-2}.spm.stats.fmri_spec.dir = {analysisdir};
        matlabbatch{3*i-2}.spm.stats.fmri_spec.timing.units = 'secs';
        matlabbatch{3*i-2}.spm.stats.fmri_spec.timing.RT = TR;
        
        if(TR==0.7)
            matlabbatch{3*i-2}.spm.stats.fmri_spec.timing.fmri_t = 39;
            matlabbatch{3*i-2}.spm.stats.fmri_spec.timing.fmri_t0 = 20;
        else
            matlabbatch{3*i-2}.spm.stats.fmri_spec.timing.fmri_t = 78;
        matlabbatch{3*i-2}.spm.stats.fmri_spec.timing.fmri_t0 = 39;
        
        end
        %%
        
        for r=1:3
            
            
            crun = r;
            
            
            scanpath=fullfile(preproc_dir, [cm '/' num2str(TR) '/run' num2str(crun) '/' csubj '/']);
            
            
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
            wmcsfrpfile = 'tc_wm_csf_rp_iwrbuadvols.txt';
            % tmp = load('/net/mri.meduniwien.ac.at/projects/physics/fmri/data/clu12p/analysis/fva4s/preproc/clu12-p004/tc_wm_csf_global_rp_wrbadvols.txt');
            if exist(fullfile(scanpath, wmcsfrpfile), 'file') %'tc_wm_csf_global_rp_iwrbuadvols.txt'
                realignmentparameters = load(fullfile(scanpath, wmcsfrpfile)); % 'rbuadvols.nii.par.txt'
                
                
                % ${meanCsfRegressor} 1
                % ${csfRegressors}    2:6
                % ${meanWmRegressor}  7
                % ${wmRegressors}     8:12
                % ${realignmentParameters} 13:18
                
                
                for rpi = 1:size(realignmentparameters,2)
                        matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(rpi).name = ['RP' num2str(rpi)];% sprintf( 'rpi%02d', rpi);
                        matlabbatch{3*i-2}.spm.stats.fmri_spec.sess(r).regress(rpi).val = realignmentparameters(:,rpi);
                end
                    
                
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
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.fcon.name = 'edt-odt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.fcon.weights = [1 0 -1; 0 1 -1];
        matlabbatch{3*i}.spm.stats.con.consess{coni}.fcon.sessrep = 'both';
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
         matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = '-eedt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = -1;
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.sessrep = 'both';
        coni = coni+1;
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = '-iedt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = [0 -1];
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.sessrep = 'both';
        coni = coni+1;
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = '-oedt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = [0 0 -1];
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.sessrep = 'both';
        coni = coni+1;
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = 'iedt>odt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = [0 1 -1];
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.sessrep = 'both';
        coni = coni+1;
        
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.name = 'iedt<odt';
        matlabbatch{3*i}.spm.stats.con.consess{coni}.tcon.weights = [0 -1 1];
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
        if ~interactive
            spm_jobman('serial',matlabbatch); % 'serial' or 'interactive'
        end
    end
end


if interactive
    spm_jobman('interactive',matlabbatch); % 'serial' or 'interactive'
end

    %%
    

