% ------------------------------------------------------
% create batch for BMS
% ------------------------------------------------------

clear matlabbatch;
interactive = 0; % if interactive or serial matlabbatch
meas='m2';
classification = 'rem'; % 'hc', 'rem' oder 'acute'
family = 0;

if family
    zusatz = '_fam';
else
    zusatz = '';
end

DCMdir = '/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu/';
subs = importdata(['/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu/mdd.' classification '_current.txt']);
BMSdir = [meas '/BMS_' classification '_rfx' zusatz];
dirs={'m0001', 'm0002', 'm0003'};

if ~exist(fullfile(DCMdir, BMSdir))
    mkdir(fullfile(DCMdir,BMSdir));
end
matlabbatch{1}.spm.dcm.bms.inference.dir = {fullfile(DCMdir, BMSdir)};

for s=1:length(subs)
    tmp={};
    for f=1:length(dirs)
        tmp{f,1} = fullfile(DCMdir, meas, dirs{f}, ['DCM_' subs{s} '.mat']);
    end
    matlabbatch{1}.spm.dcm.bms.inference.sess_dcm{s}(1).dcmmat = tmp;
end
matlabbatch{1}.spm.dcm.bms.inference.model_sp = {''};
matlabbatch{1}.spm.dcm.bms.inference.load_f = {''};
matlabbatch{1}.spm.dcm.bms.inference.method = 'RFX';
if family
    matlabbatch{1}.spm.dcm.bms.inference.family_level.family_file = {'/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu/family.mat'};
else
    matlabbatch{1}.spm.dcm.bms.inference.family_level.family_file = {''};
end
matlabbatch{1}.spm.dcm.bms.inference.bma.bma_yes.bma_famwin = 'fanwin';
matlabbatch{1}.spm.dcm.bms.inference.verify_id = 0;

if interactive
    spm_jobman('interactive',matlabbatch); % 'serial' or 'interactive'
else
    spm_jobman('serial',matlabbatch); % 'serial' or 'interactive'
end
