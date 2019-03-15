

addpath('/z/fmri/data/empro15/analysis/edt/jobs/j1_firstlevel/')




subs = {
    'EMPRO15_001'
    'EMPRO15_002'
    %     'EMPRO15_003'
    'EMPRO15_005'
    'EMPRO15_006'
    'EMPRO15_007'
    'EMPRO15_009'
    'EMPRO15_010'
    'EMPRO15_011'
    'EMPRO15_012'
    'EMPRO15_013'
    'EMPRO15_014'
    'EMPRO15_015'
    'EMPRO15_016'
    'EMPRO15_018'
    
    };
TRs = {'1400','0700'};
Ms={'_M1','_M2'};

eedtons = [];
iedtons = [];
odtons = [];
eedtdurs = [];
iedtdurs = [];
odtdurs = [];

% next rows of params: s, t, m, r

for s=1:length(subs)
    for r = 1:3
        for m=1:2
            for t=1:2
                [eedton, iedton, odton, eedtdur, iedtdur, odtdur] = getOnsetsPerTriple([subs{s} Ms{m}], TRs{t}, r);
                eedtdurs = [eedtdurs [eedtdur; repmat([s; t; m; r],1,length(eedtdur)) ]];
                iedtdurs = [iedtdurs [iedtdur; repmat([s; t; m; r],1,length(iedtdur)) ]];
                odtdurs = [odtdurs [odtdur; repmat([s; t; m; r],1,length(odtdur)) ]];
                
            end
        end
    end
end

clear eedton iedton odton eedtdur iedtdur odtdur

%%
% correct for last triplet of block (no button press)
eedtdurs_uncorrected = eedtdurs;
lasteedttriplets = ([eedtdurs(3,:) 0] ~= [0 eedtdurs(3,:)]);
lasteedttriplets(end) = []; 
eedtdurs(:,lasteedttriplets)=[];

iedtdurs_uncorrected = iedtdurs;
lastiedttriplets = ([iedtdurs(3,:) 0] ~= [0 iedtdurs(3,:)]);
lastiedttriplets(end) = []; 
iedtdurs(:,lastiedttriplets)=[];

odtdurs_uncorrected = odtdurs;
lastodttriplets = ([odtdurs(3,:) 0] ~= [0 odtdurs(3,:)]);
lastodttriplets(end) = []; 
odtdurs(:,lastodttriplets)=[];

%%
% correct for false button presses (<0.3s?) out: 
threshold_eedt = 0.3;
threshold_iedt = 0.3;
threshold_odt = 0.3;

is_good=(eedtdurs(1,:) >= threshold_eedt);
eedtdurscorr=eedtdurs.*repmat(is_good,5,1);
eedtdurscorr( :, ~any(eedtdurscorr,1) ) = []; 

is_bad=(eedtdurs(1,:) < threshold_eedt);
eedtdursbad=eedtdurs.*repmat(is_bad,5,1);
eedtdursbad( :, ~any(eedtdursbad,1) ) = []; 


is_good=(iedtdurs(1,:) >= threshold_iedt);
iedtdurscorr=iedtdurs.*repmat(is_good,5,1);
iedtdurscorr( :, ~any(iedtdurscorr,1) ) = []; 

is_bad=(iedtdurs(1,:) < threshold_iedt);
iedtdursbad=iedtdurs.*repmat(is_bad,5,1);
iedtdursbad( :, ~any(iedtdursbad,1) ) = []; 

is_good=(odtdurs(1,:) >= threshold_odt);
odtdurscorr=odtdurs.*repmat(is_good,5,1);
odtdurscorr( :, ~any(odtdurscorr,1) ) = []; 

is_bad=(odtdurs(1,:) < threshold_odt);
odtdursbad=odtdurs.*repmat(is_bad,5,1);
odtdursbad( :, ~any(odtdursbad,1) ) = []; 
%%
means_uncorr = [mean(eedtdurs_uncorrected(1,:)), mean(iedtdurs_uncorrected(1,:)), mean(odtdurs_uncorrected(1,:))];
means_corr = [mean(eedtdurscorr(1,:)), mean(iedtdurscorr(1,:)), mean(odtdurscorr(1,:))];


%% plot eedt

i=1; delta=0.05;
for eps=0:delta:5
    below(i) = sum(eedtdurs(1,:)<=eps);
    between(i) = sum((eedtdurs(1,:)<=eps).*(eedtdurs(1,:)>eps-delta));
    i=i+1;
end
figure; plot(0:delta:5, below, 'r'); hold on; plot(0:delta:5, between, 'b'); % plots distribution and density of time taken per trial (image triple)
legend('distribution', 'density')
title('distribution and density of time per eedt triple')
xlabel('seconds')
ylabel('trials')

meansperrun = zeros(3,6); % rows: conditions, columns: runs/sessions
i=1;
for m=1:2
    for r=1:3
        %[s; t; m; r]
        
        tmp1 = eedtdurscorr(1,:).*(eedtdurscorr(4,:)==m).*(eedtdurscorr(5,:)==r);
        tmp2 = iedtdurscorr(1,:).*(iedtdurscorr(4,:)==m).*(iedtdurscorr(5,:)==r);
        tmp3 = odtdurscorr(1,:).*(odtdurscorr(4,:)==m).*(odtdurscorr(5,:)==r);
        
        tmp1( :, ~any(tmp1,1) ) = []; 
        tmp2( :, ~any(tmp2,1) ) = []; 
        tmp3( :, ~any(tmp3,1) ) = []; 
        
        meansperrun(1,i) = mean(tmp1);
        meansperrun(2,i) = mean(tmp2);
        meansperrun(3,i) = mean(tmp3);
        stdperrun(1,i) = std(tmp1);
        stdperrun(2,i) = std(tmp2);
        stdperrun(3,i) = std(tmp3);
        i=i+1;
        
    end
end
figure; plot(meansperrun'); legend('eedt', 'iedt', 'odt'); title('response time per condition'); xlabel('runs'); ylabel('seconds'); xlim([0.5 6.5]);

figure; bar(meansperrun'); legend('eedt', 'iedt', 'odt'); title('response time per condition'); xlabel('runs'); ylabel('seconds'); xlim([0.5 6.5]);

