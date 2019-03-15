function [allbet, allbet_psc, allbet_mean] = extractbetas_allsubsfromfl_sphere(TR)
% function [allbet, allbet_psc, allbet_mean] = extractbetas_allsubsfromfl()
% extracts all beta values for given clusters in file
% getclustercoordinates();
% betas are returned in allbet(subjectnumber, betanumber, clusternumber)
% psc ... percent signal change
% mean ... mean signal over time

% if strcmp(TR, '1.4')
%     [voxelcoo, ~, ~]=getclustercoordinates_first_eedt_odt();
% elseif strcmp(TR, '0.7')
%     [voxelcoo, ~, ~]=getclustercoordinates_first_eedt_odt_TR07();
% else
%     disp('what TR?')
%     return
% end

% to compare regions!!
[voxelcoo, ~, ~]=getclustercoordinates_first_eedt_odt();


radius=2; % radius of sphere around coordinate in voxels

% load beta, for example:
% b=nifti('beta_0001.nii');
% to get beta values:
% beta=b.dat(xcoo, ycoo, zcoo);

s=1;
meas = 'm1'; %TR='1.4';
TRs = {TR}; % TRs = {'1.4', '0.7'};
ms = {'m1','m2'};
firstleveldir = '/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/1_firstlevel/fl_session_s6/';

subsdir = fullfile(firstleveldir, meas, TR, 'empro*');
subs = dir(subsdir);
subs(3)=[]; % delete subject 3 because one run is broken
% secondleveldir = ['/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/test/secondlevel_session_TR' TR '_flexiblefactorial_runs-conds-interact/'];

betas = cell(9*size(ms,2)*size(TRs,2),1);
%% 
% allbet(subject, conditionofrun, region)
allbet=zeros(size(subs,1),size(betas,2),size(voxelcoo,2));
allbet_psc=zeros(size(subs,1),size(betas,2),size(voxelcoo,2));
allbet_mean=zeros(size(subs,1),size(betas,2),size(voxelcoo,2));
for s=1:size(subs,1)
    bi = 0;
    for mi=1:size(ms,2)
        meas = ms{mi};
%         for t=1:size(TRs,2)
%             TR = TRs{t};
            %ls(fullfile(firstleveldir,meas,TR, subs(s).name))
            betas(bi+1) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0001.nii')]};
            betas(bi+2) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0002.nii')]};
            betas(bi+3) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0003.nii')]};
            betas(bi+4) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0010.nii')]};
            betas(bi+5) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0011.nii')]};
            betas(bi+6) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0012.nii')]};
            betas(bi+7) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0019.nii')]};
            betas(bi+8) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0020.nii')]};
            betas(bi+9) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0021.nii')]};
            
            betameans(bi+1) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0028.nii')]};
            betameans(bi+2) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0028.nii')]};
            betameans(bi+3) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0028.nii')]};
            betameans(bi+4) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0029.nii')]};
            betameans(bi+5) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0029.nii')]};
            betameans(bi+6) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0029.nii')]};
            betameans(bi+7) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0030.nii')]};
            betameans(bi+8) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0030.nii')]};
            betameans(bi+9) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0030.nii')]};
            bi=bi+9;
%         end
    end
    %     disp(betas)
    
    for bind=1:size(betas,1)
%         b=nifti(betas(bind));
%         bm=nifti(betameans(bind));
        for clu=1:size(voxelcoo,2)
            
            if (s==1 & bind==1)
                [allbet(s,bind,clu), ~] = meanInSphere(betas{bind}, voxelcoo(:,clu), radius);
                [allbet_mean(s,bind,clu), ~] = meanInSphere(betameans{bind}, voxelcoo(:,clu), radius);
                copyfile(fullfile(firstleveldir,ms{1},TR, subs(1).name, 'W_beta_0001.nii'),['W_region_' num2str(clu) '_.nii']);
            else
                [allbet(s,bind,clu), ~] = meanInSphere(betas{bind},['W_region_' num2str(clu) '_.nii']);
                [allbet_mean(s,bind,clu), ~] = meanInSphere(betameans{bind}, ['W_region_' num2str(clu) '_.nii']);
            end
% %             allbet(s,bind,clu)=b.dat(voxelcoo(1,clu),voxelcoo(2,clu),voxelcoo(3,clu));
% %             allbet_mean(s,bind,clu)=bm.dat(voxelcoo(1,clu),voxelcoo(2,clu),voxelcoo(3,clu));
            allbet_psc(s,bind,clu)= allbet(s,bind,clu) / allbet_mean(s,bind,clu); % b.dat(voxelcoo(1,clu),voxelcoo(2,clu),voxelcoo(3,clu))/bm.dat(voxelcoo(1,clu),voxelcoo(2,clu),voxelcoo(3,clu));
            
            
        end
    end
    
end
end



