function [voxelindices, mnicoo, clusternames] = getclustercoordinates_first_nowmcsf_eedt_odt()
% function [voxelindices, mnicoo, clusternames] = getclustercoordinates...()
% returns coordinates resulting from contrast: first eedt>odt
% TR1400
% unmasked 
% p<0.05 FWE
% 

% cluster coordinates in mm: 
mnicoo=[];
ind=1;
mnicoo(:,ind)=[
    18 % may work better: 19.5 
    -5.5
    -19 % may work better: -17.5 
    ]; ind=ind+1;
mnicoo(:,ind)=[
     -21.0000
   -5.5000
  -17.5000
    ]; ind=ind+1;
mnicoo(:,ind)=[ 43.5000
  -52.0000
  -22.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ -43.5000
  -46.0000
  -22.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ -51.0000
   27.5000
   23.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ 60.0000
  -46.0000
    6.5000
    ]; ind=ind+1;
% add rMidTempGyr
mnicoo(:,ind)=[ 58.5000
  -62.5000
    8.0000
    ]; ind=ind+1;

mnicoo(:,ind)=[49.5000
   30.5000
   15.5000
    ]; ind=ind+1;
mnicoo(:,ind)=[-48.0000
  -59.5000
    8.0000
    ]; ind=ind+1;
% add lSupTempGyr
mnicoo(:,ind)=[-61.50000
  -55.0000
    9.5000
    ]; ind=ind+1;

mnicoo(:,ind)=[49.5000
  -13.0000
  -14.5000
    ]; ind=ind+1;
mnicoo(:,ind)=[-39.0000
  -67.0000
   18.5000
    ];ind=ind+1;
mnicoo(:,ind)=[ -51.0000
   48.5000
    0.5000
    ];ind=ind+1;
mnicoo(:,ind)=[37.5000
    5.0000
   33.5000
    ];ind=ind+1;
mnicoo(:,ind)=[    -3
    23
    50
    ];ind=ind+1;
mnicoo(:,ind)=[ 54
   -79
    -1
    ];ind=ind+1;
mnicoo(:,ind)=[ -39.0000
    3.5000
  -22.0000
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
'Parahippocampal_Gyr_AND_Amygdala_(R)'
'Parahippocampal_Gyr_AND_Amygdala_(L)'
'Fusiform_Gyr_(R)'
'Fusiform_Gyr_(L)'
'Middle_Frontal_Gyr_(DLPFC)_(L)'
'Superior_Temporal_Gyr_AND_BA22_(R)'
'Middle_Temporal_Gyr_AND_BA39_(R)'
'Inferior_Frontal_Gyr_(DLPFC)_(R)'
'Middle_Temporal_Gyr_AND_BA39_(L)'
'Superior_Temporal_Gyr_AND_BA22_(L)'
'Middle_Temporal_Gyr_(R)'
'Middle_Temporal_Gyr_(L)'
'Inferior_Frontal_Gyr_AND_BA10_(L)'
'Inferior_Frontal_Gyr_(DLPFC)_(R)'
'Medial_Frontal_Gyr_AND_BA8'
'Middle_Occipital_Gyr_AND_BA19(V3)_(R)'
'Superior_Temporal_Gyr_(L)'
};

end
