function [voxelindices, mnicoo, clusternames] = getclustercoordinates_first_eedt_odt_TR07()
% function [voxelindices clusternames] = getclustercoordinates()
% returns coordinates resulting from contrast: first eedt>odt
% TR1400
% unmasked 
% p<0.05 FWE
% 

% cluster coordinates in mm: 
mnicoo=[];
ind=1;
mnicoo(:,ind)=[
	43.5000
  -53.5000
  -22.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[
   -19.5000
   -7.0000
  -19.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ 
	58.5000
  -49.0000
    8.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ 
	16.5000
   -7.0000
  -19.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ 
  -43.5000
  -47.5000
  -22.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ 
  -46.5000
  -59.5000
    8.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[
    51
   -16
   -16
    ]; ind=ind+1;
mnicoo(:,ind)=[
	-40.5000
  -68.5000
   17.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[
	30.0000
    0.5000
  -23.5000
    ]; ind=ind+1;
mnicoo(:,ind)=[
	-49.5000
   36.5000
    8.0000
    ];ind=ind+1;
mnicoo(:,ind)=[ 
	-52.5000
   38.0000
   -4.0000
    ];ind=ind+1;
mnicoo(:,ind)=[
	54.0000
  -79.0000
   -2.5000
    ];ind=ind+1;
mnicoo(:,ind)=[
   57.0000
   33.5000
   14.0000
    ];ind=ind+1;
mnicoo(:,ind)=[ 
  -34.5000
    8.0000
  -28.0000
    ];ind=ind+1;
mnicoo(:,ind)=[ 
   -45
    47
    -1
    ];ind=ind+1;

mnicoo=[mnicoo; ones(1,size(mnicoo,2))]; % add row of ones for offset

% % or: do following
% xSPM.u=0.001;          %T/F Threshold
% xSPM.k=0;                   %cluster threshold
% xSPM.Ic=1;
% 
% xSPM.thresDesc='none';
% % spm_results_ui('Setup',xSPM);
% % xSPM.thresDesc='none';
% [SPM,xSPM] = spm_getSPM(xSPM);
% 
% xSPM.title='';
% %     xSPM.k=xSPM.uc(3);
% 
% xSPM.u=xSPM.uc(1);          %T/F Threshold
% xSPM.k=0;                   %cluster threshold
% xSPM.Ic=Ic;
% 
% xSPM.thresDesc='none';
% spm_results_ui('Setup',xSPM);
% xSPM.thresDesc='none';
% [SPM,xSPM] = spm_getSPM(xSPM);
% TabDat = spm_list('List',xSPM,hReg,4,8);
% % TabDat.dat: table of cluster results


ind2vox=[   -1.5000         0         0   79.5000
         0    1.5000         0 -113.5000
         0         0    1.5000  -71.5000
         0         0         0    1.0000];
% voxelindices=inv(ind2vox)*mnicoo;
voxelindices=ind2vox\mnicoo; % more effective and integer

voxelindices = voxelindices(1:end-1,:);
mnicoo = mnicoo(1:end-1,:);
clusternames = {
'Fusiform_Gyr_(R)'
'Parahippocampal_Gyr_AND_Amygdala_(L)'
'Superior_Temporal_Gyr_AND_BA21_(R)'
'Parahippocampal_Gyr_AND_Amygdala_(R)'
'Fusiform_Gyr_(L)'
'Middle_Temporal_Gyr_AND_BA39_(L)'
'Middle_Temporal_Gyr_(R)'
'Middle_Temporal_Gyr_(L)'
'Uncus_(R)'
'Inferior_Frontal_Gyr_(L)'
'Inferior_Frontal_Gyr_(L)'
'Middle_Occipital_Gyr_AND_BA19(V3)_(R)'
'Inferior_Frontal_Gyr_AND_BA46(DLPFC)_(R)'
'Superior_Temporal_Gyr_(L)'
'Middle_Frontal_Gyr_(L)'
};


end
