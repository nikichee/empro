%-----------------------------------------------------------------------
% Job saved on 20-Oct-2015 17:24:05 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
%-----------------------------------------------------------------------

clear matlabbatch;

meas = 'm1'; TR='1.4'; % replace TR
% run = 'run1';
% TR = '1.4';
TRs = {TR}; % TRs = {'1.4', '0.7'}; 
ms = {'m1','m2'};
firstleveldir = '/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/noDC/1_firstlevel/fl_session_s6_wm_csf/';

subsdir = fullfile(firstleveldir, meas, TR, 'empro*'); %['/z/fmri/data/empro15/analysis/test/analysis_edt_all_unwarped_with_derivative/' meas '/1.4/' run '/empro*'];
subs = dir(subsdir);
subs(3)=[]; % delete subject 3 because one run is broken
secondleveldir = ['/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/edt/noDC/2_secondlevel/sl_s6_TR' TR '_wm_csf_flexiblefactorial/'];

matlabbatch{1}.spm.stats.factorial_design.dir = {fullfile(secondleveldir)};
ifac=1;

% matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).name = 'measurement';
% matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).dept = 1;
% matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).variance = 0;
% matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).gmsca = 0;
% matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).ancova = 0;
% ifac=ifac+1;

% matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).name = 'TR';
% matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).dept = 1;
% matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).variance = 0;
% matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).gmsca = 0;
% matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).ancova = 0;
% ifac=ifac+1;

matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).name = 'run';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).dept = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).variance = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).ancova = 0;
ifac=ifac+1;

matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).name = 'condition';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).dept = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).variance = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(ifac).ancova = 0;
ifac=ifac+1;

%% 
betas = cell(9*size(ms,2)*size(TRs,2),1);
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
%     disp(betas)    
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(s).scans = betas;
%     condmat = [sort(repmat(1:size(ms,2),1,size(TRs,2)*9)); % meas
% %         repmat(sort(repmat(1:size(TRs,2),1,9)),1,size(ms,2)); % TR
%         repmat(sort(repmat(1:3,1,3)),1,size(TRs,2)*size(ms,2)); % run
%         repmat(1:3,1, size(ms,2)*size(TRs,2)*3)]'; % condition
    condmat = [
        repmat(sort(repmat(1:3*size(ms,2),1,3)),1,size(TRs,2)); % run
        repmat(1:3,1, size(ms,2)*size(TRs,2)*3)]'; % condition
    
%     if strcmp(subs(s).name, 'empro15_003') && strcmp(TR, '0.7') % nur für reine 0.7 auswertungen
%         condmat(7:9,:)=[];
%     end
        
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(s).conds = condmat; 
    
end

%% 

% matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{1}.fmain.fnum = 3; % for factor 3
matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{1}.inter.fnums = [1
                                                                                    2]; % for interaction of run and condition

matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;


matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;


% 
% matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
% i=1;
% matlabbatch{3}.spm.stats.con.consess{i}.fcon.name = 'eoi';
% matlabbatch{3}.spm.stats.con.consess{i}.fcon.weights = eye(3);
% matlabbatch{3}.spm.stats.con.consess{i}.fcon.sessrep = 'none';
% i=i+1;
% 
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.name = 'edt > odt';
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.weights = [1 1 -2];
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.sessrep = 'none';
% i=i+1;
% 
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.name = 'edt < odt';
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.weights = [-1 -1 2];
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.sessrep = 'none';
% i=i+1;
% 
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.name = 'eedt > odt';
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.weights = [1 0 -1];
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.sessrep = 'none';
% i=i+1;
% 
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.name = 'eedt < odt';
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.weights = [-1 0 1];
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.sessrep = 'none';
% i=i+1;
% 
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.name = 'eedt > iedt';
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.weights = [1 -1];
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.sessrep = 'none';
% i=i+1;
% 
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.name = 'eedt < iedt';
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.weights = [-1 1];
% matlabbatch{3}.spm.stats.con.consess{i}.tcon.sessrep = 'none';
% i=i+1;
% 
% matlabbatch{3}.spm.stats.con.delete = 0;

spm_jobman('interactive',matlabbatch); % 'serial' or 'interactive'


