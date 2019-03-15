
%

addpath('/z/fmri/data/empro15/analysis/edt/jobs/j4_other_analysis/')

% TR='0.7';
TR='1.4';
reg=1; % number of region - e.g. 1=rAmy?
%close all;

display_legend = 1; 
save_plots = 1;
noplots=0;

% regsno = 10;
co=1; 
dist_to_y = 9;
radius = 2;

datadir = '/data/ngeis/Dropbox/fmri/_ni_/data';
% if(strcmp(TR, '1.4'))
%     plotsdir = fullfile(datadir, 'autoplots', '2vx', 'TR1.4');
% elseif(strcmp(TR,'0.7'))
%     plotsdir = fullfile(datadir, 'autoplots', '2vx', 'TR0.7');
% end

% if(radius>1)
%     plotsdir = fullfile(datadir, 'autoplots', [num2str(radius) 'vx'], ['TR' TR]);
% else
%     plotsdir = fullfile(datadir, 'autoplots', 'max', ['TR' TR]);
% end

if(radius>1)
    plotsdir = fullfile(datadir, 'autoplots', [num2str(radius) 'vx_coofromall'], ['TR' TR]);
else
    plotsdir = fullfile(datadir, 'autoplots', 'max_coofromall', ['TR' TR]);
end

% [allbet, allbet_psc, allbet_mean] = extractbetas_allsubsfromfl(TR);

% [voxelindices, mnicoo, clusternames] = getclustercoordinates_first_eedt_odt();
% % [voxelindices, mnicoo, clusternames] = getclustercoordinates_first_eedt_odt_TR07();
[voxelindices, mnicoo, clusternames] = getclustercoordinates_all_eedt_odt();


% or: load extracted parameterestimates from 04_other_analyses
% load(fullfile(datadir, ['parameterestimates_sphere_' TR '_coo0.7.mat']));
%load(fullfile(datadir, ['parameterestimates_sphere' num2str(radius) 'vx_' TR '.mat']));
load(fullfile(datadir, ['parameterestimates_sphere_coofromall_' num2str(radius) 'vx_' TR '.mat']));
% load(fullfile(datadir, ['parameterestimates_max_' TR '.mat']));

regsno = size(allbet,3);

% regions(reg).ssbetas


%% plot parameter estimates and standard errors

n=size(allbet_psc,1); % number of subjects

means_paramestimates = squeeze(mean(allbet_psc))'*100;
standarderrors = squeeze(std(allbet_psc))'*(1/sqrt(n))*100;

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
        %set(gca,'FontSize',10)
        box off
        
        if(display_legend)
            lgd=legend({'explicit EDT', 'implicit EDT', 'ODT', 'standard error'},'FontSize',9);
            % lgd.FontSize = 14;
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

%% plot bar charts for eedt>odt and eedt only

eedtdata = allbet_psc(:,[1 4 7 10 13 16],:) * 100;
eedtcontrastdata = (allbet_psc(:,[1 4 7 10 13 16],:) - allbet_psc(:,[3 6 9 12 15 18],:))*100;

if ~noplots
    for reg=1:regsno
        
        plot_mean_and_standarderror(squeeze(eedtdata(:,:,reg)))
        filename = fullfile(plotsdir, ['barcharts_EEDT_' num2str(reg)]);        
        if(save_plots)
            saveas(gcf, filename, 'pdf');
            
            title(['Parameter estimates for EEDT: ' clusternames{reg}],'Interpreter', 'none');
            saveas(gcf, filename, 'png');
        else
            title(['Parameter estimates for EEDT: ' clusternames{reg}],'Interpreter', 'none');
        end
        
        plot_mean_and_standarderror(squeeze(eedtcontrastdata(:,:,reg)))
        filename = fullfile(plotsdir, ['barcharts_EEDT-ODT_' num2str(reg)]);
        if(save_plots)
            saveas(gcf, filename, 'pdf');
            
            title(['Parameter estimates for EEDT-ODT: ' clusternames{reg}],'Interpreter', 'none');
            saveas(gcf, filename, 'png');
        else
            title(['Parameter estimates for EEDT-ODT: ' clusternames{reg}],'Interpreter', 'none');
        end
    end
end

%% boxplots for TR vergleich - only rAmy - only estimates (not contrasts)
eedt_rAmy_14 = allbet_psc(:,1,2)*100;

load(fullfile(datadir, ['parameterestimates_sphere_coofromall_2vx_0.7.mat']), 'allbet_psc');
allbet_psc_07 = allbet_psc * 100;
eedt_rAmy_07 = allbet_psc_07(:,1,2);
together = [eedt_rAmy_14, eedt_rAmy_07]; 

figure;
boxplot(together);
filename = fullfile(plotsdir, 'boxplot_TRs');
saveas(gcf, filename, 'pdf');
saveas(gcf, filename, 'png');

%% boxplots for TR vergleich - all regions

%[allbet, allbet_psc, allbet_mean] = extractbetas_allsubsfromfl_sphere_wmcsf_coofromall('0.7');

data_14 = load(fullfile(datadir, 'parameterestimates_sphere_coofromall_2vx_1.4.mat'));
data_07 = load(fullfile(datadir, 'parameterestimates_sphere_coofromall_2vx_0.7.mat'));

eedtcontrastdata_14 = (data_14.allbet_psc(:,[1 4 7 10 13 16],:) - data_14.allbet_psc(:,[3 6 9 12 15 18],:))*100;
eedtcontrastdata_07 = (data_07.allbet_psc(:,[1 4 7 10 13 16],:) - data_07.allbet_psc(:,[3 6 9 12 15 18],:))*100;

regsno = size(data_14.allbet,3);

if(save_plots)
    mkdir(fullfile(plotsdir, 'boxplots'))
end

for r=1:regsno
    together = [data_14.allbet_psc(:,1,r)*100, data_07.allbet_psc(:,1,r)*100];
    figure;
    boxplot(together) 
    filename = fullfile(plotsdir, 'boxplots', ['boxplot_TRs_reg' num2str(r)]);
    title(['Boxplot TR1.4 vx TR0.7: ' data_14.clusternames{r}], 'Interpreter', 'none');
    if(save_plots)
        saveas(gcf, filename, 'pdf');
        saveas(gcf, filename, 'png');
    end
end

for r=1:regsno
    together = [eedtcontrastdata_14(:,1,r), eedtcontrastdata_07(:,1,r)];
    figure;
    boxplot(together);
    %ylimit=round(max(max(together))*2)/2;
    %ylim([0 ylimit])%ylim([0 3])
    if(r<=4)
        ylim([-0.1 3.1])
    end
    filename = fullfile(plotsdir, 'boxplots', ['boxplot_EEDT-ODT_reg' num2str(r)]);
    title(['Boxplot EEDT-ODT TR1.4 vx TR0.7: ' data_14.clusternames{r}], 'Interpreter', 'none');
    if(save_plots)
        saveas(gcf, filename, 'pdf');
        saveas(gcf, filename, 'png');
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
        set(gca, 'FontSize', 10);
        % title(['single subject contrasts ' clusternames{reg} ' ' mat2str(mnicoo(:,reg)')], 'Interpreter', 'none');
        title([clusternames{reg}], 'Interpreter', 'none');
        l=legend({'1st run', '2nd run', '3rd run', 'mean over runs'});
        xlabel('eedt > odt in 1st session', 'Interpreter', 'none'); ylabel('eedt > odt in 2nd session', 'Interpreter', 'none');
        %set(gca,'FontSize',20)
        %fig=gcf; ax=fig.CurrentAxes;
        %set(ax,'FontSize',20)
        %
        set(l,'FontSize',10)
        % figure; plot((allbet(:,cond,reg)+allbet(:,cond+3,reg)+allbet(:,cond+6,reg))*(1/3), allbet(:,cond+dist_to_y,reg), 'ro'); cond=cond+3;
        
        xl=xlim; yl=ylim; lims = [min(xl(1), yl(1)), max(xl(2), yl(2))]; plot(lims, lims, 'k:');
        xlim(lims); ylim(lims);
        axis equal;
        
        if(save_plots)% && reg>12)
            saveas(gcf, fullfile(plotsdir, ['xyplots_' num2str(reg)]), 'epsc');
            saveas(gcf, fullfile(plotsdir, ['xyplots_' num2str(reg)]), 'png');
        end
            
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
%     [h(reg,2),p(reg,2)]=ttest(tmp1(:)-tmp2(:)); % same results!
    
    [h_runs(reg,:),p_runs(reg,:)]=ttest(con_sess1,con_sess2);
    
    % habituation first run - last run per session: first session, second session, and for both sessions (concatenated) 
    [h_hab(reg,1),p_hab(reg,1)]=ttest(allbet(:,[cond],reg)-allbet(:,[cond]+2,reg), allbet(:,[cond+6],reg)-allbet(:,[cond+6]+2,reg));
    [h_hab(reg,2),p_hab(reg,2)]=ttest(allbet(:,[cond]+dist_to_y,reg)-allbet(:,[cond]+2+dist_to_y,reg), allbet(:,[cond+6]+dist_to_y,reg)-allbet(:,[cond+6]+2+dist_to_y,reg));
    [h_hab(reg,3),p_hab(reg,3)]=ttest([allbet(:,[cond],reg)-allbet(:,[cond]+2,reg); allbet(:,[cond]+dist_to_y,reg)-allbet(:,[cond]+2+dist_to_y,reg)], [allbet(:,[cond+6],reg)-allbet(:,[cond+6]+2,reg); allbet(:,[cond+6]+dist_to_y,reg)-allbet(:,[cond+6]+2+dist_to_y,reg)]);
    
    % habituation2 SECOND run - last run per session: first session, second session, and for both sessions (concatenated)    
    [h_hab2(reg,1),p_hab2(reg,1)]=ttest(allbet(:,[cond+3],reg)-allbet(:,[cond+3]+2,reg), allbet(:,[cond+6],reg)-allbet(:,[cond+6]+2,reg));
    [h_hab2(reg,2),p_hab2(reg,2)]=ttest(allbet(:,[cond+3]+dist_to_y,reg)-allbet(:,[cond+3]+2+dist_to_y,reg), allbet(:,[cond+6]+dist_to_y,reg)-allbet(:,[cond+6]+2+dist_to_y,reg));
    [h_hab2(reg,3),p_hab2(reg,3)]=ttest([allbet(:,[cond+3],reg)-allbet(:,[cond+3]+2,reg); allbet(:,[cond+3]+dist_to_y,reg)-allbet(:,[cond+3]+2+dist_to_y,reg)], [allbet(:,[cond+6],reg)-allbet(:,[cond+6]+2,reg); allbet(:,[cond+6]+dist_to_y,reg)-allbet(:,[cond+6]+2+dist_to_y,reg)]);
    
    clear('con_sess1', 'con_sess2')
end

%% habituation effect: t-test on single subject slopes of eedt-odt
cond=1;
for reg=1:size(allbet_psc, 1)
    con_sess1=allbet_psc(:,[cond, cond+3, cond+6],reg)-allbet_psc(:,[cond, cond+3, cond+6]+2,reg);
    con_sess2=allbet_psc(:,[cond, cond+3, cond+6]+dist_to_y,reg)-allbet_psc(:,[cond, cond+3, cond+6]+2+dist_to_y,reg);

    mean_and_slopes = [1 1;1 2;1 2]\con_sess1';
    [H, P, CI, stats] = ttest(mean_and_slopes(2,:));
    %disp(['Region: ' clusternames(reg) ', session: 1. P-value: ' ])
    %disp(P)
    slope_ttest_p(reg,1) = P;
    
    
    mean_and_slopes = [1 1;1 2;1 2]\con_sess2';
    [H, P, CI, stats] = ttest(mean_and_slopes(2,:));
%     disp(['Region: ' clusternames(reg) ', session: 2. P-value: ' ])
%     disp(P)
    slope_ttest_p(reg, 2) = P;
end

save(fullfile(plotsdir, 'slope_ttest_p'),'slope_ttest_p')
csvwrite(fullfile(plotsdir, 'slope_ttest_p.csv'),slope_ttest_p)

 %%
% 
reg=1;

% plot timecourse of eedt-beta per subject
figure; plot(allbet(:,[1,4,7,10,13,16],reg)')
xlim([0.5 6.5])
title('eedt>odt per subject');
filename=fullfile(datadir, ['eedt_odt_timecourse_per_subject_' num2str(reg)]);
saveas(gcf, filename, 'pdf');
saveas(gcf, filename, 'png');

% plot contrast eedt-odt
diffs = allbet(:,[1,4,7,10,13,16],reg) - allbet(:,[1,4,7,10,13,16]+2,reg);
figure; plot(diffs(:,1:3), 'o'); hold on;
plot(diffs(:,4:6), '*')
legend('s1 r1', 's1 r2', 's1 r3', 's2 r1', 's2 r2', 's2 r3'); title('eedt>odt per subject');
xlabel('subject'); ylabel('beta contrast value');
xlim([0.5 14.5])

filename=fullfile(datadir, ['eedt_odt_per_subject_' num2str(reg)]);
saveas(gcf, filename, 'pdf');
saveas(gcf, filename, 'png');

%% calculate anova of all parameter estimates

% create dataset:
firstreg=1;
lastreg = 11; % size(allbet,3); % for TR=0.7: reg 12: only NaN
nosess=2;
noruns=3;
% noconds=3;
noconds=2;

TRs = {'1.4', '0.7'};


load(fullfile(datadir, 'parameterestimates_max_0.7_coo0.7.mat'))

n=size(allbet(:,:,reg),1); % number of subjects
%     k=size(allbet(:,:,reg),2); % number of conditions
%     vals = reshape(allbet(:,:,reg), n*k,1);

% moved here
subs = repmat(1:n,nosess*noconds*noruns,1); subs=reshape(subs,numel(subs),1);
run = sort(repmat(1:noruns,noconds*n,1)); run=reshape(run,numel(run),1); run=repmat(run,nosess,1);
sess = sort(repmat(1:nosess,noconds*noruns*n,1)); sess=sort(sess(:));
conds = repmat(1:noconds,n,1); conds=repmat(sort(conds(:)),noruns*nosess,1);


for reg=firstreg:lastreg % for each brain region individually:
    allvals=[];
    allsubs=[];
    allrun=[];
    allsess=[];
    allconds=[];
    allcontrasts=[];
    alltirep=[];
    
    for t=2:size(TRs,2)
        TR=TRs{t};
%         load(fullfile(datadir, ['parameterestimates_sphere_' TR '.mat']));
%         load(fullfile(datadir, ['parameterestimates_max_' TR '.mat']));
        
       
        
%         condsvec = [(1:1+noconds-1) (4:4+noconds-1) (7:7+noconds-1) (10:10+noconds-1) (13:13+noconds-1) (16:16+noconds-1) ];
%         vals = reshape(allbet(:,condsvec,reg), n*nosess*noruns*noconds,1);
        
        % moved subs, run, sess, conds
                 
        
            
            eedtvec = [1 4 7 10 13 16];
            if(noconds==1)
                condsvec = eedtvec;
                vals = reshape(allbet(:,condsvec,reg), n*nosess*noruns*noconds,1);
                
                contrasts = reshape(allbet(:,eedtvec,reg) - allbet(:,eedtvec+2,reg), n*nosess*noruns*noconds,1);
                [anovaresults(t).p_c(:,reg),anovaresults(t).table_c{reg},anovaresults(t).stats_c{reg}]  = anovan(contrasts,{run, sess}, 'varnames', {'run', 'session'}, 'display', 'off'); % , conds});
            elseif(noconds==2)
                condsvec = sort([eedtvec eedtvec+1]);
                vals = reshape(allbet(:,condsvec,reg), n*nosess*noruns*noconds,1);
                
                odttemp = allbet(:,eedtvec+2,reg); odttemp=repmat(odttemp(:),1,2); odttemp=reshape(odttemp',numel(odttemp),1);
                contrasts = reshape(allbet(:,condsvec,reg),numel(odttemp),1) - odttemp;
                
                [anovaresults(t).p_c(:,reg),anovaresults(t).table_c{reg},anovaresults(t).stats_c{reg}] = anovan(contrasts,{run, sess, conds}, 'varnames', {'run', 'session', 'condition'}, 'display', 'off'); % , conds});
            end
            tirep = ones(numel(vals),1)*t;
       
        allvals=[allvals; vals];
        allsubs=[allsubs; subs];
        allrun=[allrun; run];
        allsess=[allsess; sess];
        allconds=[allconds; conds];
        allcontrasts=[allcontrasts; contrasts];
        alltirep = [alltirep; tirep];
        
%         t
%         reg
    end
    
%     disp(['out of t']);
        [anovaresults(3).p_b(:,reg),anovaresults(3).table_b{reg},anovaresults(3).stats_b{reg}] =anovan(allvals,{allrun, allsess, allconds, alltirep}, 'varnames', {'run', 'session', 'condition', 'TR'}, 'display', 'off'); % , conds});
        [anovaresults(3).p_c(:,reg),anovaresults(3).table_c{reg},anovaresults(3).stats_c{reg}] = anovan(allcontrasts,{allrun, allsess, allconds, alltirep}, 'varnames', {'run', 'session', 'condition', 'TR'}, 'display', 'off'); % , conds});
end

%% anova for common regions, max per TR: 
commonregs{1} = [1 2 3 4 7 8 9 10 11]; % for comparison
% commonregs{1} = [5 6 12]; %for rest!! 

commonregs{2} = 1:9;

TRs = {'1.4', '0.7'};
% TRs = {'1.4'};


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
    
    
    [anovaresults(3).p_b(:,reg),anovaresults(3).table_b{reg},anovaresults(3).stats_b{reg}] =anovan(allvals,{allrun, allsess, allconds, alltirep}, 'varnames', {'run', 'session', 'condition', 'TR'}, 'display', 'off'); % , conds});
    [anovaresults(3).p_c(:,reg),anovaresults(3).table_c{reg},anovaresults(3).stats_c{reg}] = anovan(allcontrasts,{allrun, allsess, allconds, alltirep}, 'varnames', {'run', 'session', 'condition', 'TR'}, 'display', 'off'); % , conds});
    
    
end
