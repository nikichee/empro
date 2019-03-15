
% extractbetas_allsubsfromfl;
% figure; plot((allbet(:,[cond, cond+3, cond+6],reg)-allbet(:,[cond, cond+3, cond+6]+2,reg))')
% figure; plot((allbet(:,[cond, cond+3, cond+6],reg)-allbet(:,[cond, cond+3, cond+6]+2,reg))', (allbet(:,[cond, cond+3, cond+6]+dist_to_y,reg)-allbet(:,[cond, cond+3, cond+6]+2+dist_to_y,reg))', 'LineWidth', 2);
% figure; plot((allbet(:,[cond, cond+3, cond+6],reg)-allbet(:,[cond, cond+3, cond+6]+2,reg))'*(-1), (allbet(:,[cond, cond+3, cond+6]+dist_to_y,reg)-allbet(:,[cond, cond+3, cond+6]+2+dist_to_y,reg))'*(-1), 'LineWidth', 2);
%  

%% anova for common regions, max per TR: 
% commonregs{1} = [1 2 3 4 6 8 9]; % for comparison
commonregs{1} = [5 7 10 11 12 13]; %for rest!! 

commonregs{2} = [4 2 1 5 3 6 7];

TRs = {'1.4', '0.7'};

for t=1:size(TRs,2)
        TR=TRs{t};
%         load(fullfile(datadir, ['parameterestimates_sphere_' TR '.mat']));
        load(fullfile(datadir, ['parameterestimates_sphere_' TR '.mat']));
        allbetsafe{t}.allbet = allbet(:,:,commonregs{t});
end

% create dataset:
firstreg=1;
lastreg = size(allbetsafe{1}.allbet, 3); % size(allbet,3)
nosess=2;
noruns=3;
% noconds=3;
noconds=2;

clear anovaresults

% load(fullfile(datadir, 'parameterestimates_max_0.7_coo0.7.mat'))

n=size(allbetsafe{1}.allbet(:,:,reg),1); % number of subjects
%     k=size(allbet(:,:,reg),2); % number of conditions
%     vals = reshape(allbet(:,:,reg), n*k,1);
        
for reg=firstreg:lastreg % for each brain region individually:
    allvals=[];
    allsubs=[];
    allrun=[];
    allsess=[];
    allconds=[];
    allcontrasts=[];
    alltirep=[];
    
    for t=1:size(TRs,2)
        TR=TRs{t};
               
        condsvec = [(1:1+noconds-1) (4:4+noconds-1) (7:7+noconds-1) (10:10+noconds-1) (13:13+noconds-1) (16:16+noconds-1) ];
        vals = reshape(allbetsafe{t}.allbet(:,condsvec,reg), n*nosess*noruns*noconds,1);
        
        
        subs = repmat(1:n,nosess*noconds*noruns,1); subs=reshape(subs,numel(subs),1);
        run = sort(repmat(1:noruns,noconds*n,1)); run=reshape(run,numel(run),1); run=repmat(run,nosess,1);
        sess = sort(repmat(1:nosess,noconds*noruns*n,1)); sess=sort(sess(:));
        conds = repmat(1:noconds,n,1); conds=repmat(sort(conds(:)),noruns*nosess,1);
        tirep = ones(numel(vals),1)*t;
                
        eedtvec = [1 4 7 10 13 16];
        if(noconds==1)
            contrasts = reshape(allbetsafe{t}.allbet(:,eedtvec,reg) - allbetsafe{t}.allbet(:,eedtvec+2,reg), n*nosess*noruns*noconds,1);
            [anovaresults(t).p_c(:,reg),anovaresults(t).table_c{reg},anovaresults(t).stats_c{reg}]  = anovan(contrasts,{run, sess}, 'varnames', {'run', 'session'}, 'display', 'off'); % , conds});
        elseif(noconds==2)
            odttemp = allbetsafe{t}.allbet(:,eedtvec+2,reg); odttemp=repmat(odttemp(:),1,2); odttemp=reshape(odttemp',numel(odttemp),1);
            contrasts = reshape(allbetsafe{t}.allbet(:,condsvec,reg),numel(odttemp),1) - odttemp;
            
            [anovaresults(t).p_c(:,reg),anovaresults(t).table_c{reg},anovaresults(t).stats_c{reg}] = anovan(contrasts,{run, sess, conds}, 'varnames', {'run', 'session', 'condition'}, 'display', 'off'); % , conds});
        end
        
        allvals=[allvals; vals];
        allsubs=[allsubs; subs];
        allrun=[allrun; run];
        allsess=[allsess; sess];
        allconds=[allconds; conds];
        allcontrasts=[allcontrasts; contrasts];
        alltirep = [alltirep; tirep];
        
    end
    
    if(reg==13)
        
    else
        [anovaresults(3).p_b(:,reg),anovaresults(3).table_b{reg},anovaresults(3).stats_b{reg}] =anovan(allvals,{allrun, allsess, allconds, alltirep}, 'varnames', {'run', 'session', 'condition', 'TR'}, 'display', 'off'); % , conds});
        [anovaresults(3).p_c(:,reg),anovaresults(3).table_c{reg},anovaresults(3).stats_c{reg}] = anovan(allcontrasts,{allrun, allsess, allconds, alltirep}, 'varnames', {'run', 'session', 'condition', 'TR'}, 'display', 'off'); % , conds});
        
    end
end
