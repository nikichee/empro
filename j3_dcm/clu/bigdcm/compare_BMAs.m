function [tvalues]=compare_BMAs(classification1, meas1, classification2, meas2)
% function [results]=test_BMSs(classification, meas)
% classification = 'rem' or 'acute'
% meas = 'm1' or 'm2'
% look if everything is significant..
thres = 1.697; % critical t-value for n=32 (df=31), alpha=0.05 
tempdir=pwd;
cd('/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu');

subs1 = importdata(['/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu/mdd.' classification1 '_current.txt']);
n=length(subs1);
subs2 = importdata(['/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu/mdd.' classification1 '_current.txt']);
m=length(subs2);

BMS1=load([meas1 '/BMS_' classification1 '_rfx/BMS.mat']);
BMS2=load([meas2 '/BMS_' classification2 '_rfx/BMS.mat']);
regions = {'V1', 'lDLPFC', 'lVLPFC', 'lAmy', 'mOFC', 'rAmy', 'rVLPFC', 'rDLPFC'}; 

% BMS1.BMS.DCM.rfx.bma.mEp.A
% BMS1.BMS.DCM.rfx.bma.mEp.B(:,:,1)
% BMS2.BMS.DCM.rfx.bma.mEp.A
% BMS2.BMS.DCM.rfx.bma.mEp.B(:,:,1)
tvalues.A = (BMS1.BMS.DCM.rfx.bma.mEp.A - BMS2.BMS.DCM.rfx.bma.mEp.A) ./ sqrt((BMS1.BMS.DCM.rfx.bma.sEp.A .^2 ./ n) + (BMS2.BMS.DCM.rfx.bma.sEp.A .^2 ./ m)); 
tvalues.B = (BMS1.BMS.DCM.rfx.bma.mEp.B - BMS2.BMS.DCM.rfx.bma.mEp.B) ./ sqrt((BMS1.BMS.DCM.rfx.bma.sEp.B .^2 ./ n) + (BMS2.BMS.DCM.rfx.bma.sEp.B .^2 ./ m)); 
ABmean1=BMS1.BMS.DCM.rfx.bma.mEp.B(:,:,1) + BMS1.BMS.DCM.rfx.bma.mEp.A
ABstd1 = sqrt(BMS1.BMS.DCM.rfx.bma.sEp.B(:,:,1).^2 + BMS2.BMS.DCM.rfx.bma.sEp.A .^2)
ABmean2=BMS2.BMS.DCM.rfx.bma.mEp.B(:,:,1) + BMS2.BMS.DCM.rfx.bma.mEp.A
ABstd2 = sqrt(BMS2.BMS.DCM.rfx.bma.sEp.B(:,:,1).^2 + BMS2.BMS.DCM.rfx.bma.sEp.A .^2)
tvalues.AB = (ABmean1 - ABmean2) ./ (sqrt(ABstd1 .^2 ./n) + (ABstd2 .^2 ./m));


% result.AB.significant = (abs(tvalues)>=thres).*param;
% result.AB.nonsignificant = (abs(tvalues)>0 .* abs(tvalues)<thres).*param;
% result.AB.tvalues = tvalues;
% result.AB.allconnections = param;
% result.AB.std=std;


cd(pwd);
end