
% this script averages the DCMs estimated via estimate_all.m
% 


TRs = {'0.7','1.4'};
subs = {
    'empro15_001'
    'empro15_002'
%     'empro15_003'
    'empro15_005'
    'empro15_007'
    'empro15_009'
    'empro15_010'
    'empro15_011'
    'empro15_012'
    'empro15_013'
    'empro15_014'
    'empro15_015'
    'empro15_016'
    'empro15_018'
    };


allDCMs = {};

% just for explanation: 
allDCMs.subjects = subs; 
allDCMs.TRs = TRs; 
allDCMs.measurements = {'m1', 'm2'};


% init averages: 


average = {};
% average.all.A = zeros(4,4);
% average.all.B = zeros(4,4,3);
% average.all.C = zeros(4,3);
average.all.A = zeros(2,2);
average.all.B = zeros(2,2,3);
average.all.C = zeros(2,3);

average.all.numberOfDCMs = 0;
average.overTRs(1) = average.all; 
average.overTRs(2) = average.all;
average.overMeas(1) = average.all; 
average.overMeas(2) = average.all; 
average.overMeas(1).run(1) = average.all; 
average.overMeas(1).run(2) = average.all; 
average.overMeas(1).run(3) = average.all; 
average.overMeas(2).run(1) = average.all; 
average.overMeas(2).run(2) = average.all; 
average.overMeas(2).run(3) = average.all; 
for i = 1:length(subs)
   average.overSubs(i) = average.all; 
end


%%
for s=1:length(subs);
    allDCMs.subs(s).name = subs(s);
%     allDCMs.subs(s).A = [1, 0; 0, 2];
    
    for m=1:2
        for t=2:2 % 1:2
            
            % make directories in dcm folder
            thisdir = ['/z/fmri/data/empro15/analysis/edt/3_dcm/rAmy-OFC/m' num2str(m) '/' TRs{t} '/' subs{s} '/'];
            
            for r=1:3
%                 thisDCM = [thisdir 'DCM_run' num2str(r) '.mat'];
                thisDCM = [thisdir 'DCM_run' num2str(r) '_rAmy-OFC_eit.mat'];
                disp(thisDCM);
                d = load(thisDCM);
                allDCMs.subs(s).ms(m).TRs(t).runs(r).Ep = d.Ep;
                allDCMs.subs(s).ms(m).TRs(t).runs(r).F = d.F;
                allDCMs.subs(s).ms(m).TRs(t).runs(r).Cp = d.Cp;
                
                average.all.A = average.all.A + d.Ep.A; 
                average.all.B = average.all.B + d.Ep.B; 
                average.all.C = average.all.C + d.Ep.C;
                average.all.numberOfDCMs = average.all.numberOfDCMs + 1;
                
                average.overTRs(t).A = average.overTRs(t).A + d.Ep.A; 
                average.overTRs(t).B = average.overTRs(t).B + d.Ep.B; 
                average.overTRs(t).C = average.overTRs(t).C + d.Ep.C;
                average.overTRs(t).numberOfDCMs = average.overTRs(t).numberOfDCMs + 1;
                
                average.overMeas(m).A = average.overMeas(m).A + d.Ep.A; 
                average.overMeas(m).B = average.overMeas(m).B + d.Ep.B; 
                average.overMeas(m).C = average.overMeas(m).C + d.Ep.C;
                average.overMeas(m).numberOfDCMs = average.overMeas(m).numberOfDCMs + 1;
                
                average.overMeas(m).run(r).A = average.overMeas(m).run(r).A + d.Ep.A; 
                average.overMeas(m).run(r).B = average.overMeas(m).run(r).B + d.Ep.B; 
                average.overMeas(m).run(r).C = average.overMeas(m).run(r).C + d.Ep.C;
                average.overMeas(m).run(r).numberOfDCMs = average.overMeas(m).run(r).numberOfDCMs + 1;
                
                average.overSubs(s).A = average.overSubs(s).A + d.Ep.A; 
                average.overSubs(s).B = average.overSubs(s).B + d.Ep.B; 
                average.overSubs(s).C = average.overSubs(s).C + d.Ep.C;
                average.overSubs(s).numberOfDCMs = average.overSubs(s).numberOfDCMs + 1;
                
                subj(s).sess(r).model(1).fname = thisDCM;
                
            end
        end
    end
end


% divide
average.all.A = average.all.A * (1/average.all.numberOfDCMs);
average.all.B = average.all.B * (1/average.all.numberOfDCMs);
average.all.C = average.all.C * (1/average.all.numberOfDCMs);
average.all.numberOfDCMs = 0;

for i=1:2
    average.overTRs(i).A = average.overTRs(i).A * (1/average.overTRs(i).numberOfDCMs);
    average.overMeas(i).A = average.overMeas(i).A * (1/average.overMeas(i).numberOfDCMs);
    average.overTRs(i).B = average.overTRs(i).B * (1/average.overTRs(i).numberOfDCMs);
    average.overMeas(i).B = average.overMeas(i).B * (1/average.overMeas(i).numberOfDCMs);
    average.overTRs(i).C = average.overTRs(i).C * (1/average.overTRs(i).numberOfDCMs);
    average.overMeas(i).C = average.overMeas(i).C * (1/average.overMeas(i).numberOfDCMs);
    
    for j=1:3
        average.overMeas(i).run(j).A = average.overMeas(i).run(j).A * (1/average.overMeas(i).run(j).numberOfDCMs);
        average.overMeas(i).run(j).B = average.overMeas(i).run(j).B * (1/average.overMeas(i).run(j).numberOfDCMs);
        average.overMeas(i).run(j).C = average.overMeas(i).run(j).C * (1/average.overMeas(i).run(j).numberOfDCMs);
    end
end
for i = 1:length(subs)
    average.overSubs(i).A = average.overSubs(i).A * (1/average.overSubs(i).numberOfDCMs);
    average.overSubs(i).B = average.overSubs(i).B * (1/average.overSubs(i).numberOfDCMs);
    average.overSubs(i).C = average.overSubs(i).C * (1/average.overSubs(i).numberOfDCMs);
end