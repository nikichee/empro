% ------------------------------------------------------
% create batch for BMS
% ------------------------------------------------------

clear matlabbatch;
interactive = 0; % if interactive or serial matlabbatch
effect = 'rfx';
DCMdir = '/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/3_dcm/rAmy-OFC_clu/';
num_DCMfiles = 4;
group = 'hc';
subs = importdata(['/z/fmri/data/empro15/analysis/edt/jobs/j3_dcm/clu/mdd.' group '_current.txt']);

for m=1:2
    BMSdir = ['BMS/variations_4/m' num2str(m)];
    
    if ~exist(fullfile(DCMdir, BMSdir), 'dir')
        mkdir(fullfile(DCMdir, BMSdir));
    end
    
    DCMfiles = cell(num_DCMfiles,1);
    for temp=1:num_DCMfiles
        DCMfiles{temp, 1} = sprintf( 'DCM_m%04d.mat', temp);
    end
    
    matlabbatch{1}.spm.dcm.bms.inference.dir = {fullfile(DCMdir, BMSdir)};
    
    
    for s=1:length(subs)
%         for r=1:3
            tmp=cell(size(DCMfiles,1),1);
            for f=1:size(DCMfiles,1)
                tmp{f,1} = fullfile(DCMdir, ['m' num2str(m)], subs{s},'variations' , DCMfiles{f,1});
            end
            matlabbatch{1}.spm.dcm.bms.inference.sess_dcm{s}(1).dcmmat = tmp;
%         end
    end
    matlabbatch{1}.spm.dcm.bms.inference.model_sp = {''};
    matlabbatch{1}.spm.dcm.bms.inference.load_f = {''};
    matlabbatch{1}.spm.dcm.bms.inference.method = upper(effect); % 'RFX';
    matlabbatch{1}.spm.dcm.bms.inference.family_level.family_file = {''};
    matlabbatch{1}.spm.dcm.bms.inference.bma.bma_yes.bma_famwin = 'fanwin';
    matlabbatch{1}.spm.dcm.bms.inference.verify_id = 0;
    
    if ~interactive
        spm_jobman('serial',matlabbatch); % 'serial' or 'interactive'
    end
end % end for meas
if interactive
    spm_jobman('interactive',matlabbatch); % blödsinn, steht ja überall matlabbatch{1}... geht gar nicht interactive
end
