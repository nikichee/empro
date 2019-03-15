function [voxelindices, mnicoo, clusternames] = getclustercoordinates_first_eedt_odt()
% function [voxelindices, mnicoo, clusternames] = getclustercoordinates...()
% returns coordinates resulting from contrast: first eedt>odt
% TR1400, incl. wm csf regressors
% unmasked 
% p<0.05 FWE
% 

% cluster coordinates in mm: 
mnicoo=[];
ind=1;
mnicoo(:,ind)=[ % rAmy
    18
    -7
    -17.5
    ]; ind=ind+1;
mnicoo(:,ind)=[ % lAmy
    -19.5000
    -5.5000
    -17.5000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % rFusGyr
    43.5000
    -52.0000
    -22.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % lFusGyr
    -43.5000
    -46.0000
    -22.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % rDLPFC
    51.0000
    32.0000
    15.5000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % lDLPFC
    -51.0000
    27.5000
    23.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % rSupTempGyr (oder: 60, -46, 6.5)
    48.0000
    -47.5000
    12.5000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % lSupTempGyr
    -61.50000
    -55.0000
    9.5000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % rMidTempGyr
    58.5000
    -64.0000
    8.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % lMidTempGyr (laut TR0.7: besser -46.5, -59.5, 8)
    -49.5000
    -61.0000
    8.0000
    ]; ind=ind+1;


mnicoo(:,ind)=[ % rMidTempGyr_
    49.5000
    -13.0000
    -14.5000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % medFronGyr
    -3
    23
    50
    ];ind=ind+1;

% mnicoo(:,ind)=[ % OFC rsl [2, 48, -18] (not in results table)
%     2
%     48
%     -18
%     ];ind=ind+1;
% mnicoo(:,ind)=[ % OFC [4, 36, -20] (not in results table)
%     4
%     36
%     -20
%     ];ind=ind+1;

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
'Inferior_Frontal_Gyr_(DLPFC)_(R)'
'Middle_Frontal_Gyr_(DLPFC)_(L)'
'Superior_Temporal_Gyr(R)'
'Superior_Temporal_Gyr_AND_BA22_(L)'
'Middle_Temporal_Gyr_AND_BA39_(R)'
'Middle_Temporal_Gyr_AND_BA39_(L)'
'Middle_Temporal_Gyr_(R)'
'Medial_Frontal_Gyr_AND_BA8'
% 'OFC rsl [2, 48, -18]'
% 'OFC [4, 36, -20]'
};

end
