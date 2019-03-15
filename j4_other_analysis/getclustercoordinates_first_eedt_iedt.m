function [voxelindices, mnicoo, clusternames] = getclustercoordinates_first_eedt_iedt()
% function [voxelindices, mnicoo, clusternames] = getclustercoordinates...()
% returns coordinates resulting from contrast: first eedt>odt
% TR1400, incl. wm csf regressors
% unmasked 
% p<0.05 FWE
% 

% cluster coordinates in mm: 
mnicoo=[];
ind=1;
% first eedt>iedt:
mnicoo(:,ind)=[ % lVLPFC
    -42
    35
    24
    ]; ind=ind+1;
mnicoo(:,ind)=[ % lDLPFC
    -45
    10
    34
    ]; ind=ind+1;
mnicoo(:,ind)=[ % rMTG
    48
    -31
    -1
    ]; ind=ind+1;
mnicoo(:,ind)=[ % rIFG
    34
    0
    35
    ]; ind=ind+1;
mnicoo(:,ind)=[ % cingulate (MFG)
    -2
    22.0000
    48
    ]; ind=ind+1;
mnicoo(:,ind)=[ % rSTS(insula)
    45
    -42
    18
    ]; ind=ind+1;
mnicoo(:,ind)=[ % rDLPFC
    45.0000
    20
    24
    ]; ind=ind+1;
%all eedt>iedt:
mnicoo(:,ind)=[ % Inferior_Parietal_Lobule_and_BA40
    -56
    -56
    38
    ]; ind=ind+1;

% eedt<iedt: 
mnicoo(:,ind)=[ % Cuneus_(V3)
    9.0000
    -97
    23
    ]; ind=ind+1;
mnicoo(:,ind)=[ % Postcentral_Gyr_and_BA3_(S1)_(L)
    -54
    -19
    44
    ]; ind=ind+1;
mnicoo(:,ind)=[ % Precentral_Gyr_(M1)_(L)
    -38
    -13
    58
    ]; ind=ind+1;
mnicoo(:,ind)=[ % Dentate_(R)
    15
    -55
    -26
    ]; ind=ind+1;
mnicoo(:,ind)=[ % Declive_(R)
    27
    -64
    -20
    ]; ind=ind+1;
mnicoo(:,ind)=[ % Medial_Frontal_Gyr_(OFC)
    -2
    47
    -14
    ]; ind=ind+1;
mnicoo(:,ind)=[ % Paracentral_Lobule_(dPCC)
    -4
    -30
    46
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
'Middle_Frontal_Gyr_(VLPFC)_(L)'
'Middle_Frontal_Gyr_(DLPFC)_(L)'
'Middle_Temporal_Gyr_AND_BA22_(R)'
'Inferior_Frontal_Gyr_(DLPFC)_(R)'
'Medial_Frontal_Gyr_and_BA8_(Cingulate)'
'Insula_and_BA13_(rSTS)_(R)'
'Middle_Frontal_Gyr_(DLPFC)_(R)'
'Cuneus_(V3)'
'Postcentral_Gyr_and_BA3_(S1)_(L)'
'Precentral_Gyr_(M1)_(L)'
'Dentate_(R)'
'Declive_(R)'
'Medial_Frontal_Gyr_(OFC)'
'Paracentral_Lobule_(dPCC)'
};

end
