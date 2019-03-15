

effecttype = 'rfx'; 
TR='1.4';
% TR='0.7';

DCMdir = '/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/3_dcm/rAmy-rslOFC/'; %%% 

% bmspath = fullfile(DCMdir, 'BMS/variations_64', effecttype, ['TR' TR]);
bmspath = fullfile(DCMdir, 'BMS/variations_64','all', ['TR' TR]);

% run=1;
% % for run=1:6
% bmspath = fullfile(DCMdir, 'BMS/variations_64/per_run',['run' num2str(run)], ['TR' TR]);

% TRs = {'1.4','0.7'};
% t=2;
% meas=2;
% bmspath = fullfile(DCMdir, 'BMS/variations_64/per_meas/', ['m' num2str(meas)], ['TR' TR]);

load(fullfile(bmspath, 'BMS.mat'));

if strcmp(effecttype, 'rfx')
    bma = BMS.DCM.rfx.bma;
elseif strcmp(effecttype, 'ffx')
    bma = BMS.DCM.ffx.bma;
else
    disp('wrong effecttype!'); 
    return;
end

if isfield(bma, 'mEps')
    estimates = cell(1,length(bma.mEps));
%     for i=1:length(bma.mEps)
%         estimates.A(i,:,:) = bma.mEps(1,i).A;
%         estimates.B(i,:,:,:) = bma.mEps(1,i).B;
%         estimates.C(i,:,:) = bma.mEps(1,i).C;
% %         estimates.D(i,:,:) = bma.mEps(1,i).D;
%     end
    for i=1:size(bma.a,3)
        estimates.A(i,:,:) = bma.a(:,:,i);
        estimates.B(i,:,:,:) = bma.b(:,:,:,i);
        estimates.C(i,:,:) = bma.c(:,:,i);
    end
end

pvalues.A = squeeze(ttest(estimates.A)); 
means.A = squeeze(mean(estimates.A));
pvalues.B = squeeze(ttest(estimates.B)); 
means.B = squeeze(mean(estimates.B));
pvalues.C = squeeze(ttest(estimates.C)); 
means.C = squeeze(mean(estimates.C));


% displays:
% disp(['run: ' num2str(run)]);
disp('A: ');
means.A .* pvalues.A
% means.A
disp('B: ');
means.B .* pvalues.B
% means.B
disp('C: ');
means.C .* pvalues.C
% means.C

% end % for run=1:6
