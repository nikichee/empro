
coo=getclustercoordinates_first_eedt_odt();

% load beta, for example: 
% b=nifti('beta_0001.nii'); 
% to get beta values: 
% beta=b.dat(xcoo, ycoo, zcoo);

s=1;
bi=1;
betapath='/z/fmri/data/empro15/analysis/edt/2_secondlevel/flexiblefactorial_TR1.4_runs-conds-interact';
i=1;
betas={};
betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_000' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;
betas(bi+i-1) = {[fullfile(betapath,['/beta_00' num2str(i) '.nii']) ',1']}; i=i+1;

allbet=zeros(size(betas,2),size(coo,2));
for bind=1:size(betas,2)
    b=nifti(betas(bind));
    for clu=1:size(coo,2)
        allbet(bind,clu)=b.dat(coo(1,clu),coo(2,clu),coo(3,clu));        
    end
end