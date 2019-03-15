% ------------------------------------------------------
% create batch for BMS
% ------------------------------------------------------

clear matlabbatch;
interactive = 0; % if interactive or serial matlabbatch
% variations = 1;
TRs = {'1.4','0.7'};
nums = [16, 64];
effects = {'rfx', 'rem', 'hc'};
effect = 'rfx';
% meas=2;
DCMdir = '/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/3_dcm/rAmy-OFC/';

for m=1:2
    %         t=1;
    for t=1:2
        %   num_DCMfiles = 16;
        for nu=1:2
            
            num_DCMfiles = nums(nu);
            
            
            % BMSdir = fullfile('BMS/variations_16', effect, ['TR' TRs{t}]);
            BMSdir = ['BMS/variations_' num2str(num_DCMfiles) '/per_meas/m' num2str(m) '/TR' TRs{t}];
            
            if ~exist(fullfile(DCMdir, BMSdir), 'dir')
                mkdir(fullfile(DCMdir, BMSdir));
            end
            
            subs = {
                'empro15_001'
                'empro15_002'
                'empro15_005'
                'empro15_006'
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
            
            DCMfiles = cell(num_DCMfiles,3);
            for temp=1:num_DCMfiles
                for r=1:3
                    DCMfiles{temp, r} = sprintf( 'DCM_m%04d_run%01d.mat', temp, r );
                end
            end
            
            matlabbatch{1}.spm.dcm.bms.inference.dir = {fullfile(DCMdir, BMSdir)};
            
            
            for s=1:length(subs)
                %     for m=meas:meas
                for r=1:3
                    %             for t=1:1
                    tmp=cell(size(DCMfiles,1),1);
                    for f=1:size(DCMfiles,1)
                        tmp{f,1} = fullfile(DCMdir, ['m' num2str(m)], TRs{t}, subs{s},'variations' , DCMfiles{f,r});
                    end
                    matlabbatch{1}.spm.dcm.bms.inference.sess_dcm{s}(r).dcmmat = tmp;
                    %             end
                end
                %     end
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
        end % for nu
    end % end for t
end % end for meas
if interactive
    spm_jobman('interactive',matlabbatch); % blödsinn, steht ja überall matlabbatch{1}... geht gar nicht interactive
end
