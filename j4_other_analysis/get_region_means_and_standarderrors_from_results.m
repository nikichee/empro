
%

% TR='0.7';
TR='1.4';
reg=1; % number of region - e.g. 1=rAmy?
%close all;

display_legend = 0; 
save_plots = 1;
noplots=1;

% regsno = 10;
co=1; 
dist_to_y = 9;

datadir = '/data/ngeis/Dropbox/fmri/_ni_/data';
if(strcmp(TR, '1.4'))
    plotsdir = fullfile(datadir, 'autoplots');
elseif(strcmp(TR,'0.7'))
    plotsdir = fullfile(datadir, 'autoplots', 'TR0.7');
end

% [allbet, allbet_psc, allbet_mean] = extractbetas_allsubsfromfl(TR);

% [voxelindices, mnicoo, clusternames] = getclustercoordinates_first_eedt_odt();
% % [voxelindices, mnicoo, clusternames] = getclustercoordinates_first_eedt_odt_TR07();

% or: load extracted parameterestimates from 04_other_analyses
% load(fullfile(datadir, ['parameterestimates_sphere_' TR '_coo0.7.mat']));
load(fullfile(datadir, ['parameterestimates_sphere_' TR '_nowmcsf.mat']));
% load(fullfile(datadir, ['parameterestimates_max_' TR '.mat']));

regsno = size(allbet,3);

% regions(reg).ssbetas

addpath('/z/fmri/data/empro15/analysis/edt/jobs/j4_other_analysis/')


%% plot parameter estimates and standard errors

n=size(allbet,1); % number of subjects

means_paramestimates = squeeze(mean(allbet))';
standarderrors = squeeze(std(allbet))'*(1/sqrt(n));

for reg=1:regsno
    %     means_paramestimates(reg,:) = mean(allbet(:,:,reg)); % calculates means over all subjects and for all runs
    %     standarderrors(reg,:) = std(allbet(:,:,reg))*(1/sqrt(n)); % calculates standarderrors (ste=std/sqrt(n))
    
    
    % plot with stars: 
    % figure; bar(means_paramestimates(reg,:)); hold on; plot(means_paramestimates(reg,:)+standarderrors(reg,:), 'r+'); plot(means_paramestimates(reg,:)-standarderrors(reg,:), 'r+');
    
    % plot single color: -------------------------
    % figure; bar(means_paramestimates(reg,:)); 
    %     hold on;
    %     plot([(1:18); (1:18)], [means_paramestimates(reg,:)+standarderrors(reg,:); means_paramestimates(reg,:)-standarderrors(reg,:)], 'r-', 'LineWidth', 4);
    
    if ~noplots
        
        % OR: plot bars in different colors   --------
        figure;
        
        %     hold on;
        for i=1:size(means_paramestimates,2)
            if mod(i,3)==1
                col = [0.3 0.2 1]; % 'blue';
            elseif mod(i,3) == 2
                col = [0.2 1 0.3]; % 'green';
            else
                col = [0.6 0.6 0.6];
            end
            bar(i, means_paramestimates(reg,i), 'FaceColor', col);
            if i==1
                hold on;
            elseif i==3 % for the correct legend!
                plot([(1:18); (1:18)], [means_paramestimates(reg,:)+standarderrors(reg,:); means_paramestimates(reg,:)-standarderrors(reg,:)], 'r-', 'LineWidth', 4);
            end
        end
        %
        
        %     hold on;
        plot([(1:18); (1:18)], [means_paramestimates(reg,:)+standarderrors(reg,:); means_paramestimates(reg,:)-standarderrors(reg,:)], 'r-', 'LineWidth', 4);
        
        %     title(['Parameter estimates for ' clusternames{reg}],'Interpreter', 'none');
        %     ylabel(' parameter estimate ', 'Interpreter', 'none');
        xlim([0.2 18.8]);
        %     set(gca,'position',[0 0 1 1],'units','normalized')
        iptsetpref('ImshowBorder','tight')
        %     axis off
        set(gca, 'XTickLabelMode', 'Manual')
        set(gca, 'XTick', [])
        set(gca,'XColor','w')
        box off
        
        if(display_legend)
            legend('explicit EDT', 'implicit EDT', 'ODT', 'standard error')
            filename = fullfile(plotsdir, ['barcharts_' num2str(reg) '_legend']);
            
        else
            filename = fullfile(plotsdir, ['barcharts_' num2str(reg)]);
        end
        if(save_plots)
            saveas(gcf, filename, 'pdf');
            
            title(['Parameter estimates for ' clusternames{reg}],'Interpreter', 'none');
            saveas(gcf, filename, 'png');
        else
            title(['Parameter estimates for ' clusternames{reg}],'Interpreter', 'none');
        end
        
        %     print(fig, fullfile(plotsdir, 'test'), 'pdf');
        
    end
end



%%
% plot first against second session
% reg=3;

% close all;
% regsno=10;

if ~noplots
    for reg=1:regsno
        
        
        cond=co;
        
        
        % % plot betas:
        % figure; plot(allbet(:,cond,reg), allbet(:,cond+dist_to_y,reg), 'ro'); cond=cond+3;
        % hold on; plot(allbet(:,cond,reg), allbet(:,cond+dist_to_y,reg), 'b+'); cond=cond+3;
        % plot(allbet(:,cond,reg), allbet(:,cond+dist_to_y,reg), 'g*');
        % title(['single subject betas of condition ' int2str(co) ' in ' regions(reg).name ' ' mat2str(mnicoo(:,reg)')], 'Interpreter', 'none');
        % xlabel('$\beta$ in 1st session', 'Interpreter', 'latex'); ylabel('$\beta$ in 2nd session', 'Interpreter', 'latex'); % xlim([-0.5 2.5]); ylim([-0.5 2.5]);
        % legend('1st run', '2nd run', '3rd run');
        
        % % plot contrasts eedt>odt (beta1-beta3)
        figure; cond=co;
        plot(allbet(:,cond,reg)-allbet(:,cond+2,reg), allbet(:,cond+dist_to_y,reg)-allbet(:,cond+2+dist_to_y,reg), 'ro'); cond=cond+3;
        hold on; plot(allbet(:,cond,reg)-allbet(:,cond+2,reg), allbet(:,cond+dist_to_y,reg)-allbet(:,cond+2+dist_to_y,reg), 'b+'); cond=cond+3;
        plot(allbet(:,cond,reg)-allbet(:,cond+2,reg), allbet(:,cond+dist_to_y,reg)-allbet(:,cond+2+dist_to_y,reg), 'g*');
        title(['single subject contrasts ' clusternames{reg} ' ' mat2str(mnicoo(:,reg)')], 'Interpreter', 'none');
        xlabel('eedt>odt in 1st session', 'Interpreter', 'none'); ylabel('eedt > odt in 2nd session', 'Interpreter', 'none'); % xlim([-0.5 2.5]); ylim([-0.5 2.5]);
        legend('1st run', '2nd run', '3rd run');
        
        
%         % plot contrasts iedt>odt (beta2-beta3)
%         cond=co+1;
%         plot(allbet(:,cond,reg)-allbet(:,cond+1,reg), allbet(:,cond+dist_to_y,reg)-allbet(:,cond+1+dist_to_y,reg), 'mo'); cond=cond+3;
%         plot(allbet(:,cond,reg)-allbet(:,cond+1,reg), allbet(:,cond+dist_to_y,reg)-allbet(:,cond+1+dist_to_y,reg), 'm+'); cond=cond+3;
%         plot(allbet(:,cond,reg)-allbet(:,cond+1,reg), allbet(:,cond+dist_to_y,reg)-allbet(:,cond+1+dist_to_y,reg), 'm*');
%         title(['single subject contrasts ' clusternames{reg} ' ' mat2str(mnicoo(:,reg)')], 'Interpreter', 'none');
%         xlabel('eedt>odt in 1st session', 'Interpreter', 'none'); ylabel('eedt > odt in 2nd session', 'Interpreter', 'none'); % xlim([-0.5 2.5]); ylim([-0.5 2.5]);
%         legend('1st run', '2nd run', '3rd run');

        
        % % plot means over runs of contrast eedt>odt (beta1-beta3)
        % % figure;
        cond=co;
        plot(mean(allbet(:,[cond, cond+3, cond+6],reg)-allbet(:,[cond, cond+3, cond+6]+2,reg), 2), mean(allbet(:,[cond, cond+3, cond+6]+dist_to_y,reg)-allbet(:,[cond, cond+3, cond+6]+2+dist_to_y,reg), 2), 'kx', 'LineWidth', 2); cond=cond+3;
        hold on;
        title(['single subject contrasts ' clusternames{reg} ' ' mat2str(mnicoo(:,reg)')], 'Interpreter', 'none');
        legend('1st run', '2nd run', '3rd run', 'mean over runs');
        xlabel('eedt > odt in 1st session', 'Interpreter', 'none'); ylabel('eedt > odt in 2nd session', 'Interpreter', 'none');
        %
        
        % figure; plot((allbet(:,cond,reg)+allbet(:,cond+3,reg)+allbet(:,cond+6,reg))*(1/3), allbet(:,cond+dist_to_y,reg), 'ro'); cond=cond+3;
        
        xl=xlim; yl=ylim; lims = [min(xl(1), yl(1)), max(xl(2), yl(2))]; plot(lims, lims, 'k:');
        xlim(lims); ylim(lims);
        axis equal;
        
        
        %     saveas(gcf, fullfile(plotsdir, ['xyplots_' num2str(reg)]), 'epsc');
        %     saveas(gcf, fullfile(plotsdir, ['xyplots_' num2str(reg)]), 'png');
    end
end

%% calculate correlation values: for DIFFERENCES eedt-odt


% load(fullfile(datadir, 'parameterestimates_max_0.7_coo0.7.mat'))

regsno=size(allbet,3);
corrs = zeros(regsno, 2);
n = size(allbet,1);

for reg=1:regsno
    
    % ICCs
    if co==1
    cond=co;
    con_sess1=allbet(:,[cond, cond+3, cond+6],reg)-allbet(:,[cond, cond+3, cond+6]+2,reg);
    con_sess2=allbet(:,[cond, cond+3, cond+6]+dist_to_y,reg)-allbet(:,[cond, cond+3, cond+6]+2+dist_to_y,reg);
    
    elseif co==2
    cond=co;
    con_sess1=allbet(:,[cond, cond+3, cond+6],reg)-allbet(:,[cond, cond+3, cond+6]+1,reg);
    con_sess2=allbet(:,[cond, cond+3, cond+6]+dist_to_y,reg)-allbet(:,[cond, cond+3, cond+6]+1+dist_to_y,reg);
        
    end
    % figure;plot(tmp1,tmp2,'.');
    cons_sess1(:,:,reg)=con_sess1;
    cons_sess2(:,:,reg)=con_sess2;
    
    
    
    % false: because we look at single measurements, not mean! 
%     corrs(reg, 2) = ICCsf(3,'k',[con_sess1';con_sess2']');
    
    % ICC(3,1)
    corrs(reg, 1) = ICCsf(3,'single',[con_sess1';con_sess2']');
    
    % ICC(3,1) r1s1 vs r1s2
    corrs(reg, 3) = ICCsf(3,'single',[con_sess1(1:n);con_sess2(1:n)]');
    
    
    % ICC(3,k) over MEANS OVER RUNS
    corrs(reg,2) = ICCsf(3,'k',[mean(con_sess1');mean(con_sess2')]');
    
%     % ICC(2,1)
%     corrs(reg, 4) = ICCsf(2,'single',[con_sess1';con_sess2']');
%     
%     % ICC(2,k)  
%     corrs(reg,5) = ICCsf(2,'k',[mean(con_sess1');mean(con_sess2')]');
%     

    % ICC(3,1) over all runs except first
    corrs(reg, 4) = ICCsf(3,'single',[con_sess1(:,2:3)'; con_sess2(:,2:3)']');
    
    % ICC(3,1) 2nd and 3rd run, first session
    corrs(reg, 5) = ICCsf(3,'single',con_sess1(:,2:3));
    
    
    % pearson's corrcoeff for all runs individually
    corrs(reg,6) = corr(con_sess1(:),con_sess2(:));
    
    % pearson's corrcoeff over mean of runs
    corrs(reg,7) = corr(mean(con_sess1')', mean(con_sess2')');
    
    
    % ICC(3,1) for only first session
    corrs(reg, 8) = ICCsf(3,'single',con_sess1);
    corrs(reg, 9) = ICCsf(3,'single',con_sess2);
    
    
    % regression
    [B(reg), BINT(reg,:), R(:,reg)] = regress(con_sess1(:),con_sess2(:));
    
    [h_sess(reg,1),p_sess(reg,1)]=ttest(con_sess1(:),con_sess2(:));
%     [h(reg,2),p(reg,2)]=ttest(con_sess1(:)-con_sess2(:)); % same results!
    
    [h_runs(reg,:),p_runs(reg,:)]=ttest(con_sess1,con_sess2);
    
    % habituation first run - last run per session: first session, second
    % session, and for both sessions (concatenated)
    [h_hab(reg,1),p_hab(reg,1)]=ttest(allbet(:,[cond],reg)-allbet(:,[cond]+2,reg), allbet(:,[cond+6],reg)-allbet(:,[cond+6]+2,reg));
    [h_hab(reg,2),p_hab(reg,2)]=ttest(allbet(:,[cond]+dist_to_y,reg)-allbet(:,[cond]+2+dist_to_y,reg), allbet(:,[cond+6]+dist_to_y,reg)-allbet(:,[cond+6]+2+dist_to_y,reg));
    [h_hab(reg,3),p_hab(reg,3)]=ttest([allbet(:,[cond],reg)-allbet(:,[cond]+2,reg); allbet(:,[cond]+dist_to_y,reg)-allbet(:,[cond]+2+dist_to_y,reg)], [allbet(:,[cond+6],reg)-allbet(:,[cond+6]+2,reg); allbet(:,[cond+6]+dist_to_y,reg)-allbet(:,[cond+6]+2+dist_to_y,reg)]);
    
    clear('con_sess1', 'con_sess2')    
end

 %%
% 
reg=1;

% plot timecourse per subject
figure; plot(allbet(:,[1,4,7,10,13,16],reg)')
xlim([0.5 6.5])


% % plot contrast eedt-odt
% diffs = allbet(:,[1,4,7,10,13,16],reg) - allbet(:,[1,4,7,10,13,16]+2,reg);
% figure; plot(diffs(:,1:3), 'o'); hold on;
% plot(diffs(:,4:6), '*')
% legend('s1 r1', 's1 r2', 's1 r3', 's2 r1', 's2 r2', 's2 r3'); title('eedt>odt per subject');
% xlabel('subject'); ylabel('beta contrast value');
% xlim([0.5 14.5])


%% calculate anova of all parameter estimates

% create dataset:
firstreg=1;
lastreg = 15; % size(allbet,3)
nosess=2;
noruns=3;
% noconds=3;
noconds=2;

TRs = {'1.4', '0.7'};


% load(fullfile(datadir, 'parameterestimates_max_0.7_coo0.7.mat'))

n=size(allbet(:,:,reg),1); % number of subjects
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
        load(fullfile(datadir, ['parameterestimates_sphere_' TR '.mat']));
%         load(fullfile(datadir, ['parameterestimates_max_' TR '.mat']));
        
       
        
        condsvec = [(1:1+noconds-1) (4:4+noconds-1) (7:7+noconds-1) (10:10+noconds-1) (13:13+noconds-1) (16:16+noconds-1) ];
        vals = reshape(allbet(:,condsvec,reg), n*nosess*noruns*noconds,1);
        
        
        subs = repmat(1:n,nosess*noconds*noruns,1); subs=reshape(subs,numel(subs),1);
        run = sort(repmat(1:noruns,noconds*n,1)); run=reshape(run,numel(run),1); run=repmat(run,nosess,1);
        sess = sort(repmat(1:nosess,noconds*noruns*n,1)); sess=sort(sess(:));
        conds = repmat(1:noconds,n,1); conds=repmat(sort(conds(:)),noruns*nosess,1);
        tirep = ones(numel(vals),1)*t;
        
        %     tmp=dataset(vals,subs,run,sess,conds);
        %     mdl = LinearModel.fit(ds);
        
        %     p=anovan(vals,{run, sess}, 'varnames', {'run', 'session'}); % , conds});
        %     p=anovan(vals,{subs, run, sess}, 'varnames', {'subjects', 'run', 'session'}); % , conds});
        
        if(reg==13 && t==2)
            
        else
        
        eedtvec = [1 4 7 10 13 16];
        if(noconds==1)
            contrasts = reshape(allbet(:,eedtvec,reg) - allbet(:,eedtvec+2,reg), n*nosess*noruns*noconds,1);
            [anovaresults(t).p_c(:,reg),anovaresults(t).table_c{reg},anovaresults(t).stats_c{reg}]  = anovan(contrasts,{run, sess}, 'varnames', {'run', 'session'}, 'display', 'off'); % , conds});
        elseif(noconds==2)
            odttemp = allbet(:,eedtvec+2,reg); odttemp=repmat(odttemp(:),1,2); odttemp=reshape(odttemp',numel(odttemp),1);
            contrasts = reshape(allbet(:,condsvec,reg),numel(odttemp),1) - odttemp;
            
            [anovaresults(t).p_c(:,reg),anovaresults(t).table_c{reg},anovaresults(t).stats_c{reg}] = anovan(contrasts,{run, sess, conds}, 'varnames', {'run', 'session', 'condition'}, 'display', 'off'); % , conds});
        end
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

%% anova for common regions, max per TR: 
commonregs{1} = [1 2 3 4 6 8 9]; % for comparison
% commonregs{1} = [5 7 10 11 12 13]; %for rest!! 

commonregs{2} = [4 2 1 5 3 6 7];

TRs = {'1.4', '0.7'};

for t=1:size(TRs,2)
        TR=TRs{t};
%         load(fullfile(datadir, ['parameterestimates_max_' TR '.mat']));
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

n=size(allbetsafe{1}.allbet,1); % number of subjects
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
