function []=V1etc_do_rfx()
% do rfx of certain files and save them accordingly

% DCMfolder = '/z/fmri/data/empro15/analysis/edt/3_dcm/V1_rFus_rAMY';
DCMfolder = '/z/fmri/data/empro15/analysis/edt/3_dcm/V1_rFus_rAmy_1input';
averagesfolder = fullfile(DCMfolder, 'averages'); % '/z/fmri/data/empro15/analysis/edt/3_dcm/V1_rFus_rAMY/averages';
TRs = {'1.4', '0.7'};
for t=1:2
    TR=TRs{t};
    folder = fullfile(averagesfolder, TR);
    if ~exist(folder)
        mkdir(folder); 
    end
    tmp=[];
    for m=1:2
        list=ls([DCMfolder '/m' num2str(m) '/' TR '/empro15_0*/DCM_run*.mat']); list1=strsplit(list); list1(end)=[];
        list1(28)=[];list1(28)=[];list1(28)=[]; % 013 hat nicht funktioniert
        test_DCMs(list1, fullfile(folder, ['DCM_avg_m' num2str(m) '.mat']));
        tmp=[tmp, list1];
        for r=1:3
            list=ls([DCMfolder '/m' num2str(m) '/' TR '/empro15_0*/DCM_run' num2str(r) '.mat']); list1=strsplit(list); list1(end)=[];
            list1(10)=[];
            test_DCMs(list1, fullfile(folder, ['DCM_avg_m' num2str(m) 'r' num2str(r) '.mat']))
        end
    end
    test_DCMs(tmp, fullfile(folder, ['DCM_avg_all.mat']));
end

% list=ls('/z/fmri/data/empro15/analysis/edt/3_dcm/V1_rFus_rAMY/m2/0.7/empro15_0*/DCM_run*.mat'); list1=strsplit(list); list1(end)=[];
% list1(28)=[];
% tests(list1, '/z/fmri/data/empro15/analysis/edt/3_dcm/V1_rFus_rAMY/averages/m2test.mat')
end


% function []=tests(list, newfilepath)
% n=length(list);
% d=load(list{1});
% a=zeros(size(d.DCM.a));
% b=zeros(size(d.DCM.b));
% c=zeros(size(d.DCM.c));
% Cp=zeros(size(d.DCM.Cp));
% models=[];
% for f = 1:length(list)
%     models{f, 1}=list{f};
%     tmp=load(list{f});
%     a = a + tmp.DCM.Ep.A;
%     b = b + tmp.DCM.Ep.B;
%     c = c + tmp.DCM.Ep.C;
%     Cp = Cp + tmp.DCM.Cp;
% end
% 
% d.DCM.Ep.A = a/n;
% d.DCM.Ep.B = b/n;
% d.DCM.Ep.C = c/n;
% d.DCM.Cp = Cp/(n^2);
% d.DCM.Y.name = {'V1', 'rFusFace', 'rFusObj', 'rAmy'}; %% 
% d.DCM.models = char(models);
% DCM=d.DCM;
% save(newfilepath, 'DCM');
% end
