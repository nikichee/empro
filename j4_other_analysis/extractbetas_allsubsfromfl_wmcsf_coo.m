function [allbet, allbet_psc, allbet_mean] = extractbetas_allsubsfromfl_wmcsf_coo(voxelcoo, TR)
% function [allbet, allbet_psc, allbet_mean] = extractbetas_allsubsfromfl(voxelcoo)
% extracts all beta values for given clusters in file
% getclustercoordinates();
% betas are returned in allbet(subjectnumber, betanumber, clusternumber)
% psc ... percent signal change
% mean ... mean signal over time
zusatz='';



% load beta, for example:
% b=nifti('beta_0001.nii');
% to get beta values:
% beta=b.dat(xcoo, ycoo, zcoo);

s=1;
meas = 'm1'; % TR='1.4';
TRs = {TR}; % TRs = {'1.4', '0.7'};
ms = {'m1','m2'};
firstleveldir = '/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/1_firstlevel/fl_session_s6_wm_csf/';

subsdir = fullfile(firstleveldir, meas, TR, 'empro*');
subs = dir(subsdir);
subs(3)=[]; % delete subject 3 because one run is broken

betas = cell(9*size(ms,2)*size(TRs,2),1);

% allbet(subject, conditionofrun, region)
allbet=zeros(size(subs,1),size(betas,2),size(voxelcoo,2));
allbet_psc=zeros(size(subs,1),size(betas,2),size(voxelcoo,2));
allbet_mean=zeros(size(subs,1),size(betas,2),size(voxelcoo,2));
for s=1:size(subs,1)
    bi = 0;
    for mi=1:size(ms,2)
        meas = ms{mi};
        for t=1:size(TRs,2)
            TR = TRs{t};
            %ls(fullfile(firstleveldir,meas,TR, subs(s).name))
            betas(bi+1) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0001.nii') ',1']};
            betas(bi+2) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0002.nii') ',1']};
            betas(bi+3) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0003.nii') ',1']};
            betas(bi+4) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0022.nii') ',1']};
            betas(bi+5) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0023.nii') ',1']};
            betas(bi+6) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0024.nii') ',1']};
            betas(bi+7) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0043.nii') ',1']};
            betas(bi+8) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0044.nii') ',1']};
            betas(bi+9) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0045.nii') ',1']};
            
            betameans(bi+1) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0064.nii') ',1']};
            betameans(bi+2) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0064.nii') ',1']};
            betameans(bi+3) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0064.nii') ',1']};
            betameans(bi+4) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0065.nii') ',1']};
            betameans(bi+5) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0065.nii') ',1']};
            betameans(bi+6) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0065.nii') ',1']};
            betameans(bi+7) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0066.nii') ',1']};
            betameans(bi+8) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0066.nii') ',1']};
            betameans(bi+9) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0066.nii') ',1']};
            bi=bi+9;
        end
    end
%     disp(betas)
    
    for bind=1:size(betas,1)
        b=nifti(betas(bind));
        bm=nifti(betameans(bind));
        for clu=1:size(voxelcoo,2)
            allbet(s,bind,clu)=b.dat(voxelcoo(1,clu),voxelcoo(2,clu),voxelcoo(3,clu));
            allbet_mean(s,bind,clu)=bm.dat(voxelcoo(1,clu),voxelcoo(2,clu),voxelcoo(3,clu));
            allbet_psc(s,bind,clu)=b.dat(voxelcoo(1,clu),voxelcoo(2,clu),voxelcoo(3,clu))/bm.dat(voxelcoo(1,clu),voxelcoo(2,clu),voxelcoo(3,clu));
        end
    end
    
end

% datadir = '/data/ngeis/Dropbox/fmri/_ni_/data';
% [voxelindices, mnicoo, clusternames] = getclustercoordinates_first_eedt_odt();
% save(fullfile(datadir, ['parameterestimates_max_' [TR zusatz] '.mat']), 'allbet', 'allbet_psc', 'allbet_mean', 'voxelindices', 'mnicoo', 'clusternames');

end



