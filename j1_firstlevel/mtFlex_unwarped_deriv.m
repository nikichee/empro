function mtFlex_unwarped(ScanFolder,analysisdir,TR,duration,onsets,conditionnames,svbcons,normalised,jobmode)

% 'swrccvols.nii'
% 'rp_ccvols.nii'
% conditionnames={'80%MT','90%MT','100%MT','110%MT'}; %BL last
% onsets=  {[1 2 3]; [4 4 5 4]; [2 3 4 5 5]; [1 2 3 4]}

clear matlabbatch    
dicomdir=[ScanFolder,'dicom/'];
% niftidir=[ScanFolder,'nifti/'];  
niftidir=[ScanFolder,'/'];   %mod

% rAnatomy=[ScanFolder,'../t1_32ch/nifti/risovols_cropped.nii'];

seq='*.IMA';

if ~isdir(analysisdir)
    mkdir(analysisdir)
end;

if ~isdir(niftidir)
    mkdir(niftidir)
end;

conn=length(conditionnames);
% svbcons=true;


mbx=1;
 if ~exist([niftidir 'vols.nii'], 'file') && ~exist([niftidir 'advols.nii'], 'file')
     dicoms = rsl_ls([dicomdir seq],true);
     setenv('FREESURFER_HOME', '/bilbo/usr/local/freesurfer')
     system(sprintf('/z/fmrilab/lab/freesurfer/bin/mri_convert -it siemens_dicom -ot nii %s %s', dicoms{1}, fullfile(niftidir, 'vols.nii')));
      matlabbatch{mbx}.spm.util.import.dicom.data =rsl_ls([dicomdir seq],true);
      matlabbatch{mbx}.spm.util.import.dicom.root = 'flat';
      matlabbatch{mbx}.spm.util.import.dicom.outdir = {niftidir};
      matlabbatch{mbx}.spm.util.import.dicom.protfilter = '.*';
      matlabbatch{mbx}.spm.util.import.dicom.convopts.format = 'nii';
      matlabbatch{mbx}.spm.util.import.dicom.convopts.icedims = 0;
      mbx=mbx+1;
 end

nii_vols = nifti(fullfile(niftidir, 'advols.nii'));
N = nii_vols.dat.dim(4);
    %prefer biasfield corrected epis
     if exist([niftidir 'ccvols.nii'], 'file')
         nii_file = @(prefix) fullfile(niftidir, [prefix 'ccvols.nii']);
         nii_list = @(prefix) rsl_makelist([nii_file(prefix) ',%u'], 1:N);
         else
        nii_file = @(prefix) fullfile(niftidir, [prefix 'buadvols.nii']);  %%%mod %%% % changed
        nii_list = @(prefix) rsl_makelist([nii_file(prefix) ',%u'], 1:N);    
     end;


 if ~exist(nii_file('r'),'file')
     matlabbatch{mbx}.spm.spatial.realign.estwrite.data = {nii_list('')};
     matlabbatch{mbx}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
     matlabbatch{mbx}.spm.spatial.realign.estwrite.eoptions.sep = 4;
     matlabbatch{mbx}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
     matlabbatch{mbx}.spm.spatial.realign.estwrite.eoptions.rtm = 0;
     matlabbatch{mbx}.spm.spatial.realign.estwrite.eoptions.interp = 2;
     matlabbatch{mbx}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
     matlabbatch{mbx}.spm.spatial.realign.estwrite.eoptions.weight = '';
     matlabbatch{mbx}.spm.spatial.realign.estwrite.roptions.which = [2 1];
     matlabbatch{mbx}.spm.spatial.realign.estwrite.roptions.interp = 4;
     matlabbatch{mbx}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
     matlabbatch{mbx}.spm.spatial.realign.estwrite.roptions.mask = 1;
     matlabbatch{mbx}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
     mbx=mbx+1;
 end;
 
 
 
 if normalised==true
    nipres='wr'; 
 else 
    nipres='r'; 
 end;

     
     
 
  if ~exist(nii_file(['s' nipres]),'file')
      matlabbatch{mbx}.spm.spatial.smooth.data = nii_list(nipres);
     matlabbatch{mbx}.spm.spatial.smooth.fwhm = [6 6 6]; % changed: from [3 3 3];
     matlabbatch{mbx}.spm.spatial.smooth.dtype = 0;
     matlabbatch{mbx}.spm.spatial.smooth.im = 0;
     matlabbatch{mbx}.spm.spatial.smooth.prefix = 's';
     mbx=mbx+1;
  end;
  

matlabbatch{mbx}.spm.stats.fmri_spec.dir = {analysisdir};
matlabbatch{mbx}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{mbx}.spm.stats.fmri_spec.timing.RT = TR;
matlabbatch{mbx}.spm.stats.fmri_spec.timing.fmri_t = 78; % changed from 70!!
matlabbatch{mbx}.spm.stats.fmri_spec.timing.fmri_t0 = 39; % changed (reference slice = middle)
%matlabbatch{mbx}.spm.stats.fmri_spec.sess.scans(1) = rsl_ls([niftidir 'srf*'],true);


matlabbatch{mbx}.spm.stats.fmri_spec.sess.scans = nii_list(char(['s' nipres]));


%% define conditions

for condi=1:conn
matlabbatch{mbx}.spm.stats.fmri_spec.sess.cond(condi).name = char(conditionnames(condi));
matlabbatch{mbx}.spm.stats.fmri_spec.sess.cond(condi).onset = onsets{condi};
if length(duration)<2
matlabbatch{mbx}.spm.stats.fmri_spec.sess.cond(condi).duration = duration;
else
matlabbatch{mbx}.spm.stats.fmri_spec.sess.cond(condi).duration = duration{condi};
end;
matlabbatch{mbx}.spm.stats.fmri_spec.sess.cond(condi).tmod = 0;
matlabbatch{mbx}.spm.stats.fmri_spec.sess.cond(condi).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{mbx}.spm.stats.fmri_spec.sess.cond(condi).orth = 1;

end;

%%

matlabbatch{mbx}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{mbx}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});


realignfile=nii_file('rp_');  %%mod %%%%%%%%%%%%%%%
realignfile(length(realignfile)-3:length(realignfile))='.txt';

  
% matlabbatch{mbx}.spm.stats.fmri_spec.sess.multi_reg = {[niftidir 'rp_vols.txt']};
if exist(realignfile)
matlabbatch{mbx}.spm.stats.fmri_spec.sess.multi_reg = {realignfile};
else
               load([niftidir 'rbuadvols.nii.par']);           %%%%REALIGNMENT PARAMETERS! % changed to unwarped
                    
           
               % matlabbatch{1}.spm.stats.fmri_spec.sess(ri).regress = struct('name', {}, 'val', {});
                % Spalten: 1 = Global, 2 = Mean CSF, 3:7 CSF, 8 = Mean WM, 9:13 =
                % WM, 14:19 = Realignment Parameter
                matlabbatch{1}.spm.stats.fmri_spec.sess.regress(1).name = 'RP1';
                matlabbatch{1}.spm.stats.fmri_spec.sess.regress(1).val = rbuadvols_nii(:,1); % changed to unwarped
                matlabbatch{1}.spm.stats.fmri_spec.sess.regress(2).name = 'RP2';
                matlabbatch{1}.spm.stats.fmri_spec.sess.regress(2).val = rbuadvols_nii(:,2); % changed to unwarped
                matlabbatch{1}.spm.stats.fmri_spec.sess.regress(3).name = 'RP3';
                matlabbatch{1}.spm.stats.fmri_spec.sess.regress(3).val = rbuadvols_nii(:,3); % changed to unwarped
                matlabbatch{1}.spm.stats.fmri_spec.sess.regress(4).name = 'RP4';
                matlabbatch{1}.spm.stats.fmri_spec.sess.regress(4).val = rbuadvols_nii(:,4); % changed to unwarped
                matlabbatch{1}.spm.stats.fmri_spec.sess.regress(5).name = 'RP5';
                matlabbatch{1}.spm.stats.fmri_spec.sess.regress(5).val = rbuadvols_nii(:,5); % changed to unwarped
                matlabbatch{1}.spm.stats.fmri_spec.sess.regress(6).name = 'RP6';
                matlabbatch{1}.spm.stats.fmri_spec.sess.regress(6).val = rbuadvols_nii(:,6); % changed to unwarped


                
                matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {''}; %%%  {[datadir 'tc_wm_csf_global_rp_wrbadvols.txt']};  %%% {[datadir 'rp_avols.txt']};   %rp_avols.txt
                    
end; 
    
matlabbatch{mbx}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{mbx}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{mbx}.spm.stats.fmri_spec.bases.hrf.derivs = [1 0];  %%% changed for 1st deriv
matlabbatch{mbx}.spm.stats.fmri_spec.volt = 1;
matlabbatch{mbx}.spm.stats.fmri_spec.global = 'None';
matlabbatch{mbx}.spm.stats.fmri_spec.mthresh = -Inf;

if normalised==true
matlabbatch{mbx}.spm.stats.fmri_spec.mask = {'/z/fmrilab/lab/preprocessing/template/brainmask_MNI_epi_space.nii,1'};
elseif exist([niftidir 'brainmask.nii'], 'file')
         matlabbatch{mbx}.spm.stats.fmri_spec.mask = {[niftidir 'brainmask.nii']};
     else
        matlabbatch{mbx}.spm.stats.fmri_spec.mask = {''};
     end


matlabbatch{mbx}.spm.stats.fmri_spec.cvi = 'AR(1)';


    mbx=mbx+1;
    matlabbatch{mbx}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{mbx-1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
    matlabbatch{mbx}.spm.stats.fmri_est.write_residuals = 0;
    matlabbatch{mbx}.spm.stats.fmri_est.method.Classical = 1;
    mbx=mbx+1;
    matlabbatch{mbx}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{mbx-1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));

    %%% T Contrast for each Condition (positive)
    eoi=eye(conn);
    for coni=1:conn
        matlabbatch{mbx}.spm.stats.con.consess{coni}.tcon.name = conditionnames{coni};
        matlabbatch{mbx}.spm.stats.con.consess{coni}.tcon.weights = eoi(coni,:);
        matlabbatch{mbx}.spm.stats.con.consess{coni}.tcon.sessrep = 'none';
    end;

    %%% T Contrast for each Condition (negative)
    eoi=eye(conn);
    for coni=1:conn
        matlabbatch{mbx}.spm.stats.con.consess{coni+conn}.tcon.name = ['-' conditionnames{coni}];
        matlabbatch{mbx}.spm.stats.con.consess{coni+conn}.tcon.weights = -eoi(coni,:);
        matlabbatch{mbx}.spm.stats.con.consess{coni+conn}.tcon.sessrep = 'none';
    end;
    coni=2*conn;

    if svbcons==true

        %%% stim > sham
        svb1=eoi;
        svb1(:,conn)=-ones(length(conn))
        for coni=1:conn-1
            matlabbatch{mbx}.spm.stats.con.consess{coni+2*conn}.tcon.name = [conditionnames{coni} '>' conditionnames{conn}];
            matlabbatch{mbx}.spm.stats.con.consess{coni+2*conn}.tcon.weights = svb1(coni,:);
            matlabbatch{mbx}.spm.stats.con.consess{coni+2*conn}.tcon.sessrep = 'none';
        end;


        %%% stim < sham
        svb2=-eoi;
        svb2(:,conn)=ones(length(conn))
        for coni=1:conn-1
            matlabbatch{mbx}.spm.stats.con.consess{coni+3*conn-1}.tcon.name = [conditionnames{coni} '<' conditionnames{conn}];
            matlabbatch{mbx}.spm.stats.con.consess{coni+3*conn-1}.tcon.weights = svb2(coni,:);
            matlabbatch{mbx}.spm.stats.con.consess{coni+3*conn-1}.tcon.sessrep = 'none';
        end;

        coni=coni+3*conn
        %%% F Contrast ShamVsStim
        matlabbatch{mbx}.spm.stats.con.consess{coni}.fcon.name = 'Fstim>sham';
        matlabbatch{mbx}.spm.stats.con.consess{coni}.fcon.weights = svb1;
        matlabbatch{mbx}.spm.stats.con.consess{coni}.fcon.sessrep = 'none';
        coni=coni+1
        %%% F Contrast ShamVsStim
        matlabbatch{mbx}.spm.stats.con.consess{coni}.fcon.name = 'Fstim<sham';
        matlabbatch{mbx}.spm.stats.con.consess{coni}.fcon.weights = svb2;
        matlabbatch{mbx}.spm.stats.con.consess{coni}.fcon.sessrep = 'none';


    end;


    % matlabbatch{mbx}.spm.stats.con.consess{coni}.tcon.name = 'above>below';
    % matlabbatch{mbx}.spm.stats.con.consess{coni}.tcon.weights = [-1 -1 1 1];
    % matlabbatch{mbx}.spm.stats.con.consess{coni}.tcon.sessrep = 'none';



    %%% F Contrast EOI

    coni=coni+1;
    matlabbatch{mbx}.spm.stats.con.consess{coni}.fcon.name = 'eoi';
    matlabbatch{mbx}.spm.stats.con.consess{coni}.fcon.weights = eoi;
    matlabbatch{mbx}.spm.stats.con.consess{coni}.fcon.sessrep = 'none';
    coni=coni+1

    matlabbatch{mbx}.spm.stats.con.delete = 1;

spm_jobman(jobmode,matlabbatch);


end
