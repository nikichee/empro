addpath('/z/fmri/data/empro15/analysis/edt/jobs/j4_other_analysis/thres_analysis/');

% step1_create_masks(); % create masks for spheres of regions
% clusterresults=step2_get_thresholds(); % get number of active voxels in each region sphere

% or: 
load('/z/fmri/data/empro15/analysis/edt/jobs/j4_other_analysis/thres_analysis/clusterresults.mat'); % instead of step2, just load results


minclusters = [10 1];
n=size(subs,1);
TRs={'1.4','0.7'};

% plot parameters
make_all_plots=0;
save_plots=0;
datadir = '/data/ngeis/Dropbox/fmri/_ni_/data';
plotsdir = fullfile(datadir, 'autoplots', 'ss_activity');
% bins = ['m1r1', 'm1r2', 'm1r3', 'm2r1', 'm2r2', 'm2r3'];
for c = 1:size(clusterresults,2)
    for t=1:2
        for mi=1:size(minclusters,2)
            
            mins(mi, :) = sum(clusterresults(c).TR(t).uncorr>minclusters(mi));
            mins(mi,:) = mins(mi,:) - sum(mins(1:mi-1,:),1);
            
            mins_all(mi, :) = sum(clusterresults(c).TR(t).allruns_uncorr>minclusters(mi));
            mins_all(mi,:) = mins_all(mi,:) - sum(mins_all(1:mi-1,:),1);
        end
        
        if make_all_plots
            % single run bar charts
            figure; bar(mins'*100/n, 'stacked');
            %         title(['\fontsize{16}Subjects showing activity in ' clusterresults(c).name ', T=3.10 (p<0.001), TR=' TRs{t}]);
            legend('10 vx', '1 vx'); xlabel('run'); ylabel('% of subjects'); ylim([0 100]);
            
            filename = fullfile(plotsdir, ['active_subjects_' num2str(c) '_' clusterresults(c).name '_TR' TRs{t}]);
            if(save_plots)
                saveas(gcf, [filename '.pdf'], 'pdf');
                title(['\fontsize{16}Subjects showing activity in ' clusterresults(c).name ', T=3.10 (p<0.001), TR=' TRs{t}]);
                %             saveas(gcf, filename, 'png');
                saveas(gcf, [filename '.png'], 'png');
            else
                title(['\fontsize{16}Subjects showing activity in ' clusterresults(c).name ', T=3.10 (p<0.001), TR=' TRs{t}]);
            end
                                    
            % runs accumulated bar chart
            figure; bar(mins_all'*100/n, 'stacked');legend('10 vx', '1 vx'); xlabel('run'); ylabel('% of subjects'); ylim([0 100]);
            filename = fullfile(plotsdir, ['active_subjects_allruns_' num2str(c) '_' clusterresults(c).name '_TR' TRs{t}]);
            if(save_plots)
                saveas(gcf, [filename '.pdf'], 'pdf');
                title(['\fontsize{16}Subjects showing activity in ' clusterresults(c).name ', 3 runs, T=3.10 (p<0.001), TR=' TRs{t}]);
                %             saveas(gcf, filename, 'png');
                saveas(gcf, [filename '.png'], 'png');
            else
                title(['\fontsize{16}Subjects showing activity in ' clusterresults(c).name ', T=3.10 (p<0.001), TR=' TRs{t}]);
            end
        end
    end
end

% sum(clusterresults(2).TR(2).uncorr>0)
% mean(clusterresults(1).TR(1).uncorr)
