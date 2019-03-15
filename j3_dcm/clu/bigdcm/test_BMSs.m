function [rem]=test_BMSs(classification, meas)
% function [results]=test_BMSs(classification, meas)
% classification = 'rem' or 'acute'
% meas = 'm1' or 'm2'
% look if everything is significant..
thres = 1.697; % critical t-value for n=32 (df=31), alpha=0.05 
tempdir=pwd;
cd('/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu');

% for rem: 
subs = importdata(['/z/fmri/data/empro15/analysis/edt/3_dcm/tmp_clu/mdd.' classification '_current.txt']);
n=length(subs);
load([meas '/BMS_' classification '_rfx/BMS.mat']);
regions = {'V1', 'lDLPFC', 'lVLPFC', 'lAmy', 'mOFC', 'rAmy', 'rVLPFC', 'rDLPFC'}; 

rem.regions=regions;
% only looks at part of B for face connection!!
param=BMS.DCM.rfx.bma.mEp.B(:,:,1) + BMS.DCM.rfx.bma.mEp.A;
std = sqrt(BMS.DCM.rfx.bma.sEp.B(:,:,1).^2 + BMS.DCM.rfx.bma.sEp.A .^2);
tvalues = sqrt(n)*param ./ std;
rem.AB.significant = (abs(tvalues)>=thres).*param;
rem.AB.nonsignificant = (abs(tvalues)>0 .* abs(tvalues)<thres).*param;
rem.AB.tvalues = tvalues;
rem.AB.allconnections = param;
rem.AB.std=std;

rem.AB.description = {'from', 'to', 'value'};
dims = size(param);
for i=1:dims(1)
    for j=1:dims(2)
        if(rem.AB.significant(i,j) ~=0)
            rem.AB.description(end+1,1) = regions(j);
            rem.AB.description(end,2) = regions(i);
            rem.AB.description(end,3) = num2cell(rem.AB.significant(i,j));
        end
    end
end

param = BMS.DCM.rfx.bma.mEp.A;
std = BMS.DCM.rfx.bma.sEp.A;
tvalues = sqrt(n)*param ./ std;
rem.A.significant = (abs(tvalues)>=thres).*param;
rem.A.nonsignificant = (abs(tvalues)>0 .* abs(tvalues)<thres).*param;
rem.A.tvalues = tvalues;
rem.A.allconnections = param;
rem.A.std=std;
rem.A.description = {'from', 'to', 'value'};
dims = size(param);
for i=1:dims(1)
    for j=1:dims(2)
        if(rem.A.significant(i,j) ~=0)
            rem.A.description(end+1,1) = regions(j);
            rem.A.description(end,2) = regions(i);
            rem.A.description(end,3) = num2cell(rem.A.significant(i,j));
        end
    end
end

% only for face condition!!
param = BMS.DCM.rfx.bma.mEp.B;
std = BMS.DCM.rfx.bma.sEp.B;
tvalues = sqrt(n)*param ./ std;
rem.B.significant = (abs(tvalues)>=thres).*param;
rem.B.nonsignificant = (abs(tvalues)>0 .* abs(tvalues)<thres).*param;
rem.B.tvalues = tvalues;
rem.B.allconnections = param;
rem.B.std=std;
rem.B.description = {'from', 'to', 'value'};
dims = size(param);
for i=1:dims(1)
    for j=1:dims(2)
        if(rem.B.significant(i,j) ~=0)
            rem.B.description(end+1,1) = regions(j);
            rem.B.description(end,2) = regions(i);
            rem.B.description(end,3) = num2cell(rem.B.significant(i,j));
        end
    end
end


param = BMS.DCM.rfx.bma.mEp.C;
std = BMS.DCM.rfx.bma.sEp.C;
tvalues = sqrt(n)*param ./ std;
rem.C.significant = (abs(tvalues)>=thres).*param;
rem.C.nonsignificant = (abs(tvalues)>0 .* abs(tvalues)<thres).*param;
rem.C.tvalues = tvalues;
rem.C.allconnections = param;
rem.C.std=std;
rem.C.description = {'from', 'to', 'value'};
dims = size(param);
for i=1:dims(1)
    for j=1:dims(2)
        if(rem.C.significant(i,j) ~=0)
            rem.C.description(end+1,1) = regions(j);
            rem.C.description(end,2) = regions(i);
            rem.C.description(end,3) = num2cell(rem.C.significant(i,j));
        end
    end
end



end

