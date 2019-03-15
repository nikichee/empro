
addpath('/z/fmri/data/empro15/analysis/edt/jobs/j4_other_analysis/');

TR = '1.4';

if strcmp(TR, '1.4')
    [voxelindices, mnicoo, clusternames] = getclustercoordinates_first_eedt_odt();
    %(copy cell array from matlab directly, csv doesn't have regionnames and coordinates...)
    exportfilename = '/z/fmri/data/empro15/analysis/edt/4_other_analysis/results_per_region_TR1.4_test.csv';
elseif strcmp(TR, '0.7')
    [voxelindices, mnicoo, clusternames] = getclustercoordinates_first_eedt_odt_TR07();
    exportfilename = '/z/fmri/data/empro15/analysis/edt/4_other_analysis/results_per_region_TR0.7_test.csv';
end

extractbetas_secondlevelonly;

for i=1:size(coo,2)
    regions(i).name=clusternames{i};
    regions(i).bet=allbet(:,i);
end


%%
[allbet, allbet_psc, allbet_mean] = extractbetas_allsubsfromfl(TR);



for i=1:size(regions,2)
    j=1;
    
    regions(i).results(j).name='All_runs_eedt_mean';
    regions(i).results(j).val=mean(regions(i).bet([1 4 7 10 13 16]));
    j=j+1;    
    regions(i).results(j).name='All_runs_eedt_std';
    regions(i).results(j).val=std(regions(i).bet([1 4 7 10 13 16]));
    j=j+1;
    regions(i).results(j).name='All_runs_iedt_mean';
    regions(i).results(j).val=mean(regions(i).bet([2 5 8 11 14 17]));
    j=j+1;
    regions(i).results(j).name='All_runs_iedt_std';
    regions(i).results(j).val=std(regions(i).bet([2 5 8 11 14 17]));
    j=j+1;
    regions(i).results(j).name='All_runs_odt_mean';
    regions(i).results(j).val=mean(regions(i).bet([3 6 9 12 15 18]));
    j=j+1;
    regions(i).results(j).name='All_runs_odt_std';
    regions(i).results(j).val=std(regions(i).bet([3 6 9 12 15 18]));
    j=j+1;
        
    [h,p,ci,stats] = ttest2(regions(i).bet([1 4 7 10 13 16]), regions(i).bet([3 6 9 12 15 18]));
    regions(i).results(j).name='E_vs_O_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='E_vs_O_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='E_vs_O_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
%     regions(i).results(j).name='E_vs_O_tTest_stat';
%     regions(i).results(j).val=stats;
%     j=j+1;
    
    [h,p,ci,stats] = ttest2(regions(i).bet([2 5 8 11 14 17]), regions(i).bet([3 6 9 12 15 18]));
    regions(i).results(j).name='I_vs_O_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='I_vs_O_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='I_vs_O_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
%     regions(i).results(j).name='I_vs_O_tTest_stat';
%     regions(i).results(j).val=stats;
%     j=j+1;
    [h,p,ci,stats] = ttest2(regions(i).bet([1 4 7 10 13 16]), regions(i).bet([2 5 8 11 14 17]));
    regions(i).results(j).name='E_vs_I_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='E_vs_I_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='E_vs_I_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
%     regions(i).results(j).name='E_vs_I_tTest_stat';
%     regions(i).results(j).val=stats;
%     j=j+1;
    
    [h,p,ci,stats] = ttest2(regions(i).bet([1 4 7]), regions(i).bet([10 13 16]));
    regions(i).results(j).name='Sess1_vs_Sess2_eedt_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='Sess1_vs_Sess2_eedt_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='Sess1_vs_Sess2_eedt_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
%     regions(i).results(j).name='Sess1_vs_Sess2_eedt_tTest_stat';
%     regions(i).results(j).val=stats;
%     j=j+1;
    
    [h,p,ci,stats] = ttest2(regions(i).bet([2 5 8]), regions(i).bet([11 14 17]));
    regions(i).results(j).name='Sess1_vs_Sess2_iedt_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='Sess1_vs_Sess2_iedt_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='Sess1_vs_Sess2_iedt_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
%     regions(i).results(j).name='Sess1_vs_Sess2_iedt_tTest_stat';
%     regions(i).results(j).val=stats;
%     j=j+1;
    
    [h,p,ci,stats] = ttest2(regions(i).bet([3 6 9]), regions(i).bet([12 15 18]));
    regions(i).results(j).name='Sess1_vs_Sess2_odt_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='Sess1_vs_Sess2_odt_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='Sess1_vs_Sess2_odt_tTest_ci';
    regions(i).results(j).val=ci;
%     j=j+1;
%     regions(i).results(j).name='Sess1_vs_Sess2_odt_tTest_stat';
%     regions(i).results(j).val=stats;
    
    j=j+1;
    b = [ones(6,1) [(1:3) (1:3)]']\regions(i).bet([1 4 7 10 13 16]);
    regions(i).results(j).name='Hab_all_sess_eedt_regressor_slope';
    regions(i).results(j).val=b(2);
    j=j+1;
    regions(i).results(j).name='Hab_all_sess_eedt_regressor_intercept';
    regions(i).results(j).val=b(1);    
    j=j+1;
    b = [ones(6,1) [(1:3) (1:3)]']\regions(i).bet([2 5 8 11 14 17]);
    regions(i).results(j).name='Hab_all_sess_iedt_regressor_slope';
    regions(i).results(j).val=b(2);
    j=j+1;
    regions(i).results(j).name='Hab_all_sess_iedt_regressor_intercept';
    regions(i).results(j).val=b(1);
    j=j+1;
    b = [ones(6,1) [(1:3) (1:3)]']\regions(i).bet([3 6 9 12 15 18]);
    regions(i).results(j).name='Hab_all_sess_odt_regressor_slope';
    regions(i).results(j).val=b(2);
    j=j+1;
    regions(i).results(j).name='Hab_all_sess_odt_regressor_intercept';
    regions(i).results(j).val=b(1);
    
    j=j+1;
    b = [ones(3,1) (1:3)']\regions(i).bet([1 4 7]);
    regions(i).results(j).name='Hab_1st_sess_eedt_regressor_slope';
    regions(i).results(j).val=b(2);
    j=j+1;
    regions(i).results(j).name='Hab_1st_sess_eedt_regressor_intercept';
    regions(i).results(j).val=b(1);    
    j=j+1;
    b = [ones(3,1) (1:3)']\regions(i).bet([2 5 8]);
    regions(i).results(j).name='Hab_1st_sess_iedt_regressor_slope';
    regions(i).results(j).val=b(2);
    j=j+1;
    regions(i).results(j).name='Hab_1st_sess_iedt_regressor_intercept';
    regions(i).results(j).val=b(1);    
    j=j+1;
    b = [ones(3,1) (1:3)']\regions(i).bet([3 6 9]);
    regions(i).results(j).name='Hab_1st_sess_odt_regressor_slope';
    regions(i).results(j).val=b(2);
    j=j+1;
    regions(i).results(j).name='Hab_1st_sess_odt_regressor_intercept';
    regions(i).results(j).val=b(1);
    
    
    j=j+1;
    b = [ones(3,1) (1:3)']\regions(i).bet([10 13 16]);
    regions(i).results(j).name='Hab_2nd_sess_eedt_regressor_slope';
    regions(i).results(j).val=b(2);
    j=j+1;
    regions(i).results(j).name='Hab_2nd_sess_eedt_regressor_intercept';
    regions(i).results(j).val=b(1);
    j=j+1;
    b = [ones(3,1) (1:3)']\regions(i).bet([11 14 17]);
    regions(i).results(j).name='Hab_2nd_sess_iedt_regressor_slope';
    regions(i).results(j).val=b(2);
    j=j+1;
    regions(i).results(j).name='Hab_2nd_sess_iedt_regressor_intercept';
    regions(i).results(j).val=b(1);    
    j=j+1;
    b = [ones(3,1) (1:3)']\regions(i).bet([12 15 18]);
    regions(i).results(j).name='Hab_2nd_sess_odt_regressor_slope';
    regions(i).results(j).val=b(2);
    j=j+1;
    regions(i).results(j).name='Hab_2nd_sess_odt_regressor_intercept';
    regions(i).results(j).val=b(1);
    j=j+1;
    
    % calculate regression on single subject level, and analyse with t-test
    % if slope >0: 
    addpath('/net/mri.meduniwien.ac.at/projects/physics/fmri/data/empro15/analysis/test/');
    
    slopes=zeros(size(allbet,1),9);
    intercepts=zeros(size(allbet,1),9);
    for s=1:size(allbet,1) % for each subject
        for cond=0:2
            b = [ones(6,1) [(1:3) (1:3)]']\squeeze(allbet(s,([1 4 7 10 13 16]+cond),i))';
            slopes(s,cond+1)=b(2);
            intercepts(s,cond+1)=b(1);
        end
        for m=0:1
            for cond=0:2
                b = [ones(3,1) (1:3)']\squeeze(allbet(s,([1 4 7]+m*9+cond),i))';
                slopes(s,cond+4+m*3)=b(2);
                intercepts(s,cond+4+m*3)=b(1);
            end
        end
    end
    
    regions(i).slopes=slopes;
    regions(i).intercepts=intercepts;
    regions(i).ssbetas=squeeze(allbet(:,:,i));
    
    [h,p,ci,stats] = ttest(slopes(:,1));
    regions(i).results(j).name='Hab_eedt_all_sess_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='Hab_eedt_all_sess_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='Hab_eedt_all_sess_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
    
    [h,p,ci,stats] = ttest(slopes(:,2));
    regions(i).results(j).name='Hab_iedt_all_sess_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='Hab_iedt_all_sess_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='Hab_iedt_all_sess_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
    
    [h,p,ci,stats] = ttest(slopes(:,3));
    regions(i).results(j).name='Hab_odt_all_sess_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='Hab_odt_all_sess_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='Hab_odt_all_sess_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
    
    [h,p,ci,stats] = ttest(slopes(:,4));
    regions(i).results(j).name='Hab_eedt_1st_sess_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='Hab_eedt_1st_sess_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='Hab_eedt_1st_sess_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
    
    [h,p,ci,stats] = ttest(slopes(:,5));
    regions(i).results(j).name='Hab_iedt_1st_sess_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='Hab_iedt_1st_sess_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='Hab_iedt_1st_sess_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
    [h,p,ci,stats] = ttest(slopes(:,6));
    regions(i).results(j).name='Hab_odt_1st_sess_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='Hab_odt_1st_sess_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='Hab_odt_1st_sess_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
    
    [h,p,ci,stats] = ttest(slopes(:,7));
    regions(i).results(j).name='Hab_eedt_2nd_sess_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='Hab_eedt_2nd_sess_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='Hab_eedt_2nd_sess_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
    
    
    [h,p,ci,stats] = ttest(slopes(:,8));
    regions(i).results(j).name='Hab_iedt_2nd_sess_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='Hab_iedt_2nd_sess_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='Hab_iedt_2nd_sess_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
    
    [h,p,ci,stats] = ttest(slopes(:,9));
    regions(i).results(j).name='Hab_odt_2nd_sess_tTest_H';
    regions(i).results(j).val=h;
    j=j+1; 
    regions(i).results(j).name='Hab_odt_2nd_sess_tTest_p';
    regions(i).results(j).val=p;
    j=j+1;
    regions(i).results(j).name='Hab_odt_2nd_sess_tTest_ci';
    regions(i).results(j).val=ci;
    j=j+1;
    
    
    
    % 2-sample t tests!?
%     cond=1;se=2;
%     [h,P,CI,STATS] = ttest2(regions(i).ssbetas(:,cond+(se-1)*9), regions(i).ssbetas(:,cond+6+(se-1)*9))
%     regions(i).results(j).name='Hab_eedt_all_sess_tTest_H';
%     regions(i).results(j).val=h;
%     j=j+1;
%


% figure; plot(regions(i).ssbetas', '+-', 'LineWidth', 3); legend(num2str((1:14)')); title([clusternames(i) ' lines'], 'Interpreter', 'none'); % axis([0, 19, -3, 4]); 
% figure; boxplot(regions(i).ssbetas); title([clusternames(i) ' boxplot'], 'Interpreter', 'none');


%% useless

%     
%     [p,table,stats] = anova1([regions(i).bet([1 4 7]), regions(i).bet([10 13 16])]');
%     regions(i).results(j).name='Habituation all sess, eedt: anova1: p';
%     regions(i).results(j).val=p;
%     j=j+1;
%     regions(i).results(j).name='Habituation all sess, eedt: anova1: table';
%     regions(i).results(j).val=table;
%     j=j+1;
%     regions(i).results(j).name='Habituation all sess, eedt: anova1: stats';
%     regions(i).results(j).val=stats;
%     j=j+1;
%     [p,table,stats] = anova1([regions(i).bet([2 5 8]), regions(i).bet([11 14 17])]');
%     regions(i).results(j).name='Habituation all sess, iedt: anova1: p';
%     regions(i).results(j).val=p;
%     j=j+1;
%     regions(i).results(j).name='Habituation all sess, iedt: anova1: table';
%     regions(i).results(j).val=table;
%     j=j+1;
%     regions(i).results(j).name='Habituation all sess, iedt: anova1: stats';
%     regions(i).results(j).val=stats;
%     j=j+1;
%     [p,table,stats] = anova1([regions(i).bet([3 6 9]), regions(i).bet([12 15 18])]');
%     regions(i).results(j).name='Habituation all sess, odt: anova1: p';
%     regions(i).results(j).val=p;
%     j=j+1;
%     regions(i).results(j).name='Habituation all sess, odt: anova1: table';
%     regions(i).results(j).val=table;
%     j=j+1;
%     regions(i).results(j).name='Habituation all sess, odt: anova1: stats';
%     regions(i).results(j).val=stats;
%     j=j+1;
%     
%     
%     [p,table,stats] = anova1([regions(i).bet([1 4 7])]');
%     regions(i).results(j).name='Habituation 1st sess, eedt: anova1: p';
%     regions(i).results(j).val=p;
%     j=j+1;
%     regions(i).results(j).name='Habituation 1st sess, eedt: anova1: table';
%     regions(i).results(j).val=table;
%     j=j+1;
%     regions(i).results(j).name='Habituation 1st sess, eedt: anova1: stats';
%     regions(i).results(j).val=stats;
%     j=j+1;
%     [p,table,stats] = anova1([regions(i).bet([2 5 8])]');
%     regions(i).results(j).name='Habituation 1st sess, iedt: anova1: p';
%     regions(i).results(j).val=p;
%     j=j+1;
%     regions(i).results(j).name='Habituation 1st sess, iedt: anova1: table';
%     regions(i).results(j).val=table;
%     j=j+1;
%     regions(i).results(j).name='Habituation 1st sess, iedt: anova1: stats';
%     regions(i).results(j).val=stats;
%     j=j+1;
%     [p,table,stats] = anova1([regions(i).bet([3 6 9])]');
%     regions(i).results(j).name='Habituation 1st sess, odt: anova1: p';
%     regions(i).results(j).val=p;
%     j=j+1;
%     regions(i).results(j).name='Habituation 1st sess, odt: anova1: table';
%     regions(i).results(j).val=table;
%     j=j+1;
%     regions(i).results(j).name='Habituation 1st sess, odt: anova1: stats';
%     regions(i).results(j).val=stats;
%     j=j+1;
%     
%     
%     [p,table,stats] = anova1([regions(i).bet([10 13 16])]');
%     regions(i).results(j).name='Habituation 2nd sess, eedt: anova1: p';
%     regions(i).results(j).val=p;
%     j=j+1;
%     regions(i).results(j).name='Habituation 2nd sess, eedt: anova1: table';
%     regions(i).results(j).val=table;
%     j=j+1;
%     regions(i).results(j).name='Habituation 2nd sess, eedt: anova1: stats';
%     regions(i).results(j).val=stats;
%     j=j+1;
%     [p,table,stats] = anova1([regions(i).bet([11 14 17])]');
%     regions(i).results(j).name='Habituation 2nd sess, iedt: anova1: p';
%     regions(i).results(j).val=p;
%     j=j+1;
%     regions(i).results(j).name='Habituation 2nd sess, iedt: anova1: table';
%     regions(i).results(j).val=table;
%     j=j+1;
%     regions(i).results(j).name='Habituation 2nd sess, iedt: anova1: stats';
%     regions(i).results(j).val=stats;
%     j=j+1;
%     [p,table,stats] = anova1([regions(i).bet([12 15 18])]');
%     regions(i).results(j).name='Habituation 2nd sess, odt: anova1: p';
%     regions(i).results(j).val=p;
%     j=j+1;
%     regions(i).results(j).name='Habituation 2nd sess, odt: anova1: table';
%     regions(i).results(j).val=table;
%     j=j+1;
%     regions(i).results(j).name='Habituation 2nd sess, odt: anova1: stats';
%     regions(i).results(j).val=stats;
%     j=j+1;
%     


%     regions(i).results(j).name='';
%     regions(i).results(j).val=
%     j=j+1;

end


%% export into csv: 
C={};
for k=1:size(regions(1).results,2)
    %     disp(regions(1).results(k).name);
    %     regions(1).results(k).val
    C(1,k)={regions(1).results(k).name};
    for l=1:size(regions,2)        
        C(l+1,k)={regions(l).results(k).val};
    end
end
ds = cell2dataset(C);
export(ds, 'file', exportfilename, 'Delimiter','semi')

% other export approach: does not work that well..
% fileID = fopen('celldata.dat','w');
% formatSpec = [repmat(['%s '],1,size(C,2))  ' \n '];
% [nrows,ncols] = size(C);
% for row = 1:nrows
%     fprintf(fileID,formatSpec,C{row,1:10});
% end
% fclose(fileID);


%% 
% table for copying and pasting into xls incl. regionnames and coordinates: 
D={};
D{1,1}={'RegionName'};
D{1,2}={'coordinates'};
for k=1:size(regions(1).results,2)
    D(1,k+2)={regions(1).results(k).name};
    for l=1:size(regions,2)
        D(l+1,k+2)={regions(l).results(k).val};
    end
end
for l=1:size(regions,2)
    D{l+1,1}={regions(l).name};
    D{l+1,2}=mnicoo(:,l);
end

% useful variables: D for full table, regions(i).ssbetas [is the same as 
% squeeze(allbet(:,:,i))] for single subject parameter estimates
