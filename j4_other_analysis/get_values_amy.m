
study = 'amy*';
% study = 'clu*';

cDir = pwd;

% dDir = '/z/fmri/data/clu12/analysis/edt/analysis_spm/fl_fo_wmcsf_s6/m1/hc'; %
dDir = '/z/fmri/data/amy16/analysis/edt/1_firstlevel/fl_0_clu_wm_csf_no_global/m1';

subjects = dir(fullfile(dDir, study));

coord = [4 36 -20].';

betas = [1 2 21 22];

clear vals;

for s = 1:length(subjects)
    load(fullfile(dDir, subjects(s).name, 'SPM.mat'));
    for c = 1:length(betas)
        fprintf('Subject: %s, beta: %u\n', subjects(s).name, betas(c));
        cd(fullfile(dDir, subjects(s).name));
        nii = SPM.Vbeta(betas(c)).private;
        V = nii.dat(:,:,:);
        idx = round(nii.mat \ [coord ; 1]);
        
        subjects(s).contrast(c).value = V(idx(1), idx(2), idx(3));
        vals(s,c) = subjects(s).contrast(c).value;
        cd(cDir)
    end
end
%%
figure
mean_vals = mean(vals,1);
standarderrors = std(vals).*(1/sqrt(size(vals,1)));

bar(mean_vals);
hold on;
plot([(1:size(vals,2)); (1:size(vals,2))], [mean_vals+standarderrors; mean_vals-standarderrors], 'r-', 'LineWidth', 4);
xlim = ([0 size(vals,2)+1]); 
