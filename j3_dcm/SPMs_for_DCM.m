% ------------------------------------------------------
% for creating SPMs for face-task condition
% ------------------------------------------------------

clear matlabbatch;
interactive = 0; % if interactive or serial matlabbatch

% spm_jobman('initcfg');

% function [] = analyze_edt_blocks_new()
measurements_to_analyze = {

    'EMPRO15_001_M1'; 'EMPRO15_002_M1';
%     'EMPRO15_003_M1'; 
    'EMPRO15_005_M1'; 'EMPRO15_006_M1';
    'EMPRO15_007_M1'; 'EMPRO15_009_M1'; 'EMPRO15_010_M1'; 'EMPRO15_011_M1';
    'EMPRO15_012_M1';'EMPRO15_013_M1'; 'EMPRO15_014_M1'; 
    'EMPRO15_015_M1';
    'EMPRO15_016_M1'; 'EMPRO15_018_M1';
    
    
    'EMPRO15_001_M2'; 'EMPRO15_002_M2'; 
%     'EMPRO15_003_M2'%; 
    'EMPRO15_005_M2'; 'EMPRO15_006_M2';
    'EMPRO15_007_M2'; 
    'EMPRO15_009_M2';
    'EMPRO15_010_M2'; 
    'EMPRO15_011_M2'%;    
    'EMPRO15_012_M2';'EMPRO15_013_M2'; 'EMPRO15_014_M2'; 'EMPRO15_015_M2';
    'EMPRO15_016_M2'; 'EMPRO15_018_M2'
    
    };
TRs = {'1400', '0700'};

% addpath(genpath('/z/fmrilab/lab/spm/spm12/'));
% spm fmri

clear matlabbatch;
addpath /net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/
addpath('/z/fmri/data/empro15/analysis/edt/jobs/j1_firstlevel/')

% folders = dir('/z/fmri/data/empro15/analysis/edt/preproc/m1/1.4/run1/empro15_*');

study_dir = '/z/fmri/data/empro15/analysis/';
ana_dir = fullfile(study_dir, 'test/');
preproc_dir = fullfile(study_dir, 'edt/preproc/');
% log_dir = '/z/fmri/data/clu12p/logs/trio/';
i=1; % for continuous batches, not counting nonexistent preproc files
targetfile = 'siwrbuadvols.nii'; % 'siwrbuadvols.nii'


% for k=1:length(folders) % k going through subjects
for s=1:size(measurements_to_analyze,1)
    name = measurements_to_analyze{s};
    for t=1:2
        
        tr=TRs{t}; %in ms
        cm=lower(name(end-1:end)); % cm='m1';
        csubj=lower(name(1:end-3)); % csubj='empro15_001';
        TR=(str2double(tr)/1000); % TR=0.7; in sserial
        analysisdir = ['/z/fmri/data/empro15/analysis/edt/3_dcm/rAmy-rslOFC/' cm '/' num2str(TR) '/' csubj '/'];
%         mkdir(analysisdir);
           


        % matlabbatch{i}.spm.stats.fmri_spec.dir = {'/net/mri.meduniwien.ac.at/projects/physics/fmri/data/clu12p/analysis/fvas/ngeis/firstlevel/clu12-p004/'};
        matlabbatch{i}.spm.stats.fmri_spec.dir = {analysisdir};% {fullfile(ana_dir, folders(k).name)};
        matlabbatch{i}.spm.stats.fmri_spec.timing.units = 'secs';
        matlabbatch{i}.spm.stats.fmri_spec.timing.RT = TR;
        
        if(TR==0.7)
            matlabbatch{i}.spm.stats.fmri_spec.timing.fmri_t = 39;
            matlabbatch{i}.spm.stats.fmri_spec.timing.fmri_t0 = 20;
        else
            matlabbatch{i}.spm.stats.fmri_spec.timing.fmri_t = 78;
        matlabbatch{i}.spm.stats.fmri_spec.timing.fmri_t0 = 39;
        
        end
        %%
        
        for r=1:3
            
            
            crun = r;            
            
            scanpath=['/z/fmri/data/empro15/analysis/edt/preproc/' cm '/' num2str(TR) '/run' num2str(crun) '/' csubj '/'];
                      
            if ~exist(fullfile(scanpath, targetfile), 'file') % if no swrbadvols.nii exists for this subject, continue with next subject
                continue
            end
            
            tmp = nifti(fullfile(scanpath, targetfile));
            scanfiles = cell(tmp.dat.dim(4),1);
            for j=1:tmp.dat.dim(4)
                scanfiles(j) = {[fullfile(scanpath, targetfile), ',', num2str(j)]};
            end
            clear tmp;
            matlabbatch{i}.spm.stats.fmri_spec.sess(r).scans = scanfiles;
            clear scans;
            %%
            
            [eedton, iedton, odton] = getblocks(name, tr, r);
            conditionnames={'eedt','iedt','odt', 'faces', 'task'};
            onsets={eedton iedton odton sort([eedton iedton]) sort([eedton iedton odton])};
            dur=20;
            
            for conds=1:size(conditionnames,2)
                matlabbatch{i}.spm.stats.fmri_spec.sess(r).cond(conds).name = conditionnames{conds};
                %%
                matlabbatch{i}.spm.stats.fmri_spec.sess(r).cond(conds).onset = onsets{conds};
                %%
                matlabbatch{i}.spm.stats.fmri_spec.sess(r).cond(conds).duration = dur;
                matlabbatch{i}.spm.stats.fmri_spec.sess(r).cond(conds).tmod = 0;
                matlabbatch{i}.spm.stats.fmri_spec.sess(r).cond(conds).pmod = struct('name', {}, 'param', {}, 'poly', {});
                matlabbatch{i}.spm.stats.fmri_spec.sess(r).cond(conds).orth = 1;
            end
            matlabbatch{i}.spm.stats.fmri_spec.sess(r).multi = {''};
            
            clear eedton iedton odton conditionnames onsets duration;
            
            if exist(fullfile(scanpath, 'tc_wm_csf_rp_iwrbuadvols.txt'), 'file') %'tc_wm_csf_global_rp_iwrbuadvols.txt'
                realignmentparameters = load(fullfile(scanpath, 'tc_wm_csf_rp_iwrbuadvols.txt')); % 'rbuadvols.nii.par.txt'
                                
                % ${meanCsfRegressor} 1
                % ${csfRegressors}    2:6
                % ${meanWmRegressor}  7
                % ${wmRegressors}     8:12
                % ${realignmentParameters} 13:18
                
                for rpi = 1:size(realignmentparameters,2)
                        matlabbatch{i}.spm.stats.fmri_spec.sess(r).regress(rpi).name = ['RP' num2str(rpi)];% sprintf( 'rpi%02d', rpi);
                        matlabbatch{i}.spm.stats.fmri_spec.sess(r).regress(rpi).val = realignmentparameters(:,rpi);
                end                    
                
                clear realignmentparameters;
            else
                disp(['no realignment parameters for ' name ', ' cm ', ' num2str(TR) ', run' num2str(r) '!! ']);
                matlabbatch{i}.spm.stats.fmri_spec.sess(r).regress = struct('name', {}, 'val', {});
            end
            
            
            
            % matlabbatch{i}.spm.stats.fmri_spec.sess(r).regress = struct('name', {}, 'val', {});
            
            matlabbatch{i}.spm.stats.fmri_spec.sess(r).multi_reg = {''};
            matlabbatch{i}.spm.stats.fmri_spec.sess(r).hpf = 128;
        end
        
        matlabbatch{i}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
        matlabbatch{i}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
        matlabbatch{i}.spm.stats.fmri_spec.volt = 1;
        matlabbatch{i}.spm.stats.fmri_spec.global = 'None';
        matlabbatch{i}.spm.stats.fmri_spec.mthresh = 0;
        matlabbatch{i}.spm.stats.fmri_spec.mask = {'/z/fmrilab/lab/preprocessing/template/brainmask_MNI_epi_space.nii,1'};
        matlabbatch{i}.spm.stats.fmri_spec.cvi = 'AR(1)';
        
        
        if interactive
            i=i+1;
        else
            spm_jobman('serial',matlabbatch); % 'serial' or 'interactive'
        end
        
        %             for jobmode='interactive':
        %         y = input('Continue? ', 's');
        %         if y=='n'
        %             return
        %         end
        %
    end
end

if interactive
    spm_jobman('interactive',matlabbatch); % 'serial' or 'interactive'
end

