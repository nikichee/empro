function []=V1etc_do_rfx_1()
% do rfx of certain files and save them accordingly

% DCMfolder = '/z/fmri/data/empro15/analysis/edt/3_dcm/V1_rFus_rAMY';
DCMfolder = '/z/fmri/data/empro15/analysis/edt/3_dcm/V1_rFus_rAmy_1input';
averagesfolder = fullfile(DCMfolder, 'averages'); % '/z/fmri/data/empro15/analysis/edt/3_dcm/V1_rFus_rAMY/averages';
TRs = {'1.4', '0.7'};
subs = dir(fullfile(DCMfolder, 'm1', '1.4', 'empro*'));

for t=1:2
    TR=TRs{t};
    folder = fullfile(averagesfolder, TR);
    if ~exist(folder)
        mkdir(folder);
    end
%     tmp=[];
%     for m=1:2
%         list=ls([DCMfolder '/m' num2str(m) '/' TR '/empro15_0*/DCM_run*.mat']); list1=strsplit(list); list1(end)=[];
%         list1(28)=[];list1(28)=[];list1(28)=[]; % 013 hat nicht funktioniert
%         test_DCMs(list1, fullfile(folder, ['DCM_avg_m' num2str(m) '.mat']));
%         tmp=[tmp, list1];
%         for r=1:3
%             list=ls([DCMfolder '/m' num2str(m) '/' TR '/empro15_0*/DCM_run' num2str(r) '.mat']); list1=strsplit(list); list1(end)=[];
%             list1(10)=[];
%             test_DCMs(list1, fullfile(folder, ['DCM_avg_m' num2str(m) 'r' num2str(r) '.mat']))
%         end
%     end
%     test_DCMs(tmp, fullfile(folder, ['DCM_avg_all.mat']));
    
    % one average per subject over all runs
    folder = fullfile(folder, 'oversubs');
    if ~exist(folder)
        mkdir(folder);
    end
    for s=1:length(subs)
        list=ls([DCMfolder '/m*/' TR '/' subs(s).name '/DCM_run*.mat']); list1=strsplit(list); list1(end)=[];
%         list1(28)=[];list1(28)=[];list1(28)=[]; % 013 hat nicht funktioniert
        test_DCMs(list1, fullfile(folder, ['DCM_avg_' subs(s).name '.mat']));
        for m=1:2
            list=ls([DCMfolder '/m' num2str(m) '/' TR '/' subs(s).name '/DCM_run*.mat']); list1=strsplit(list); list1(end)=[];
%             list1(10)=[];
            test_DCMs(list1, fullfile(folder, ['DCM_avg_' subs(s).name '_m' num2str(m) '.mat']))
        end
    end
end

end

