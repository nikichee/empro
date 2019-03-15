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
mnicoo(:,ind)=[ % rAmy
    16.5000
    -8.5000
    -19.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % lAmy
    -19.5000
    -7.0000
    -20.5000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % rFusGyr
    43.5000
    -55.0000
    -22.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % lFusGyr
    -43.5000
    -47.5000
    -22.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % rSupTempGyr
    48.0000
    -47.5000
    11.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % lSupTempGyr
    -60.00000
    -58.0000
    5.0000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % rMidTempGyr
    45.0000
    -70.0000
    15.5000
    ]; ind=ind+1;
mnicoo(:,ind)=[ % lMidTempGyr
    -46.5000
    -59.5000
    8.0000
    ]; ind=ind+1;


mnicoo(:,ind)=[ % rMidTempGyr_
    51.0000
    -16.0000
    -14.5000
    ]; ind=ind+1;


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
'Superior_Temporal_Gyr(R)'
'Superior_Temporal_Gyr_AND_BA22_(L)'
'Middle_Temporal_Gyr_AND_BA39_(R)'
'Middle_Temporal_Gyr_AND_BA39_(L)'
'Middle_Temporal_Gyr_(R)'
};


end
