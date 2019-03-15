% ------------------------------------------------------
% create batch for BMS
% ------------------------------------------------------

clear matlabbatch;
interactive = 1; % if interactive or serial matlabbatch

TRs = {'1.4','0.7'};
subs = {
    'empro15_001'
    'empro15_002'
    'empro15_006'
    'empro15_005'
    'empro15_007'
    'empro15_009'
    'empro15_010'
    'empro15_011'
    'empro15_012'
    'empro15_013'
    'empro15_014'
    'empro15_015'
    'empro15_016'
    'empro15_018'
    };

DCMfiles = {
    '_rAmy-OFC_eit.mat'
    '_rAmy-OFC_eit_1.mat'
    };

BMSdir = 'BMS/eit';
DCMdir = '/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/3_dcm/rAmy-OFC/';
matlabbatch{1}.spm.dcm.bms.inference.dir = {fullfile(DCMdir, BMSdir)};

for s=1:length(subs)
    for r=1:3
        for m=1:2
            tmp={};
            for f=1:length(DCMfiles)
                tmp{f,1} = fullfile(DCMdir, ['m' num2str(m)], TRs{1}, subs{s}, ['DCM_run' num2str(r) DCMfiles{f}]);
            end
            matlabbatch{1}.spm.dcm.bms.inference.sess_dcm{s}(r+(m-1)*3).dcmmat = tmp;
        end
    end    
end
matlabbatch{1}.spm.dcm.bms.inference.model_sp = {''};
matlabbatch{1}.spm.dcm.bms.inference.load_f = {''};
matlabbatch{1}.spm.dcm.bms.inference.method = 'RFX';
matlabbatch{1}.spm.dcm.bms.inference.family_level.family_file = {''};
matlabbatch{1}.spm.dcm.bms.inference.bma.bma_yes.bma_famwin = 'fanwin';
matlabbatch{1}.spm.dcm.bms.inference.verify_id = 0;

if interactive
    spm_jobman('interactive',matlabbatch); % 'serial' or 'interactive'
else
    spm_jobman('serial',matlabbatch); % 'serial' or 'interactive'
end

