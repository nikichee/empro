to create the _binsum plots: 

*) in SPM: chose contrast with respective significance level. (e.g. first eedt>odt, p<0.001 uncorr., FWEc)
to export cluster binary: Click Save... -> all clusters (binary) --> enter new filename etc. 

*) add binaries using fslmaths: in 2ndlvl folder: 
>> ls *FWE*
eedt-iedt_FWEc_r1.nii  eedt-odt_FWEc_r1.nii  iedt-odt_FWEc_r1.nii
eedt-iedt_FWEc_r2.nii  eedt-odt_FWEc_r2.nii  iedt-odt_FWEc_r2.nii
eedt-iedt_FWEc_r3.nii  eedt-odt_FWEc_r3.nii  iedt-odt_FWEc_r3.nii
eedt-iedt_FWEc_r4.nii  eedt-odt_FWEc_r4.nii  iedt-odt_FWEc_r4.nii
eedt-iedt_FWEc_r5.nii  eedt-odt_FWEc_r5.nii  iedt-odt_FWEc_r5.nii
eedt-iedt_FWEc_r6.nii  eedt-odt_FWEc_r6.nii  iedt-odt_FWEc_r6.nii
>> fslmaths eedt-iedt_FWEc_r1.nii -add eedt-iedt_FWEc_r2.nii -add eedt-iedt_FWEc_r3.nii -add eedt-iedt_FWEc_r4.nii -add eedt-iedt_FWEc_r5.nii -add eedt-iedt_FWEc_r6.nii eedt-iedt_FWEc_binsum.nii
>> fslmaths eedt-odt_FWEc_r1.nii -add eedt-odt_FWEc_r2.nii -add eedt-odt_FWEc_r3.nii -add eedt-odt_FWEc_r4.nii -add eedt-odt_FWEc_r5.nii -add eedt-odt_FWEc_r6.nii eedt-odt_FWEc_binsum.nii
>> fslmaths iedt-odt_FWEc_r1.nii -add iedt-odt_FWEc_r2.nii -add iedt-odt_FWEc_r3.nii -add iedt-odt_FWEc_r4.nii -add iedt-odt_FWEc_r5.nii -add iedt-odt_FWEc_r6.nii iedt-odt_FWEc_binsum.nii
(now we have maps of 0-6 for number of runs where we have significant activation)

*) to review:
>> fslview /z/fmrilab/lab/preprocessing/template/t1_template_MNI_epi_space.nii *binsum.nii

*) for creating slice render: 
%% first: >> edit /z/fmrilab/lab/spm/spm12/@slover/fill_defaults.m --> in Line 124: change >> obj.img(i).hold = 1; to 0 to stop interpolation. 
go to Render... -> Slice Overlay
First select structural template (Image Type: Structural), then the respective map (Image Type: Blobs).
For Blobs: select colormap (e.g. Hot), Img val range for colormap (0.1 6), Image Orientation (Axial), Slices to dipslay (mm) (-32:2.5:53)


###############
clustersizes: 
eedt>odt: 
448
650
724
325
452
390

iedt>odt: 
343
459
938
371
703
574

eedt>iedt:
1219
1972
646
388
921
318

