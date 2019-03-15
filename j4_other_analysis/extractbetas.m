
coo=getclustercoordinates();

% load beta, for example: 
% b=nifti('beta_0001.nii'); 
% to get beta values: 
% beta=b.dat(xcoo, ycoo, zcoo);

s=1;
meas = 'm1'; TR='1.4';
TRs = {'1.4'}; % TRs = {'1.4', '0.7'};
ms = {'m1','m2'};
firstleveldir = '/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/test/analysis_edt_all_newpre_session/';

subsdir = fullfile(firstleveldir, meas, TR, 'empro*'); 
subs = dir(subsdir);
subs(3)=[]; % delete subject 3 because one run is broken
% secondleveldir = ['/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/test/secondlevel_session_TR' TR '_flexiblefactorial_runs-conds-interact/'];

betas = cell(9*size(ms,2)*size(TRs,2),1);
for s=1:size(subs,1)
    betas=getbetapaths(subs(s).name);
% betapath='/z/fmri/data/empro15/analysis/test/secondlevel_session_TR1.4_flexiblefactorial_runs-conds-interact';
% i=1;
% betas={};
% betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
% betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;

allbet=zeros(size(betas,2),size(coo,2));
for bind=1:size(betas,2)
    b=nifti(betas(bind));
    for clu=1:size(coo,2)
        allbet(bind,clu)=b.dat(coo(1,clu),coo(2,clu),coo(3,clu));        
    end
end



function files=getbetapaths(subno)

    bi = 0;
    for mi=1:size(ms,2)
        meas = ms{mi};
        
        for t=1:size(TRs,2)
            TR = TRs{t};
            %ls(fullfile(firstleveldir,meas,TR, subs(s).name))
            betas(bi+1) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0001.nii') ',1']};
            betas(bi+2) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0002.nii') ',1']};
            betas(bi+3) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0003.nii') ',1']};
            betas(bi+4) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0010.nii') ',1']};
            betas(bi+5) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0011.nii') ',1']};
            betas(bi+6) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0012.nii') ',1']};
            betas(bi+7) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0019.nii') ',1']};
            betas(bi+8) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0020.nii') ',1']};
            betas(bi+9) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0021.nii') ',1']};
            
            
            
            % correct for missing RPs:
%             if (strcmp(subs(s).name, 'empro15_006') || strcmp(subs(s).name, 'empro15_014')) && mi==1 && strcmp(TR, '0.7')           
%                 betas(bi+4) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0004.nii') ',1']};
%                 betas(bi+5) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0005.nii') ',1']};
%                 betas(bi+6) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0006.nii') ',1']};
%                 betas(bi+7) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0007.nii') ',1']};
%                 betas(bi+8) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0008.nii') ',1']};
%                 betas(bi+9) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0009.nii') ',1']};
%             elseif strcmp(subs(s).name, 'empro15_011')  && mi==2 && strcmp(TR, '0.7')  
%                 betas(bi+7) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0013.nii') ',1']};
%                 betas(bi+8) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0014.nii') ',1']};
%                 betas(bi+9) = {[fullfile(firstleveldir,meas,TR, subs(s).name, '/beta_0015.nii') ',1']};
%             end
            if strcmp(subs(s).name, 'empro15_003') && mi==1 && strcmp(TR, '0.7')
                bi=bi-3 
                betas(7:9)=[]
                disp(['files for empro15_003, m1, run3, tr0700 deleted. ']);
            end
            bi=bi+9;
        end
    end