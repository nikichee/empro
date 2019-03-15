

TR='1.4';



display_legend = 0;
save_plots = 1;
noplots=1;
noplots_accum=0;
datadir = '/data/ngeis/Dropbox/fmri/_ni_/data';

plotsdir = fullfile(datadir, 'autoplots', 'eedt_iedt', ['TR' TR]);
if(~exist(plotsdir))
    mkdir(plotsdir)
end

% [voxelindices, mnicoo, clusternames] = getclustercoordinates_first_eedt_iedt();
% [allbet, allbet_psc, allbet_mean] = extractbetas_allsubsfromfl_wmcsf_coo(voxelindices, TR);
% save(fullfile(datadir, 'parameterestimates_eedt_iedt_TR1.4.mat'), 'voxelindices','mnicoo','clusternames','allbet','allbet_mean','allbet_psc');

% load(fullfile(datadir,'parameterestimates_max_1.4.mat'));
load(fullfile(datadir,'parameterestimates_eedt_iedt_TR1.4.mat'));

regsno = size(allbet,3);
addpath('/z/fmri/data/empro15/analysis/edt/jobs/j4_other_analysis/')


%% plot parameter estimates and standard errors

n=size(allbet,1); % number of subjects

means_paramestimates = squeeze(mean(allbet))';
standarderrors = squeeze(std(allbet))'*(1/sqrt(n));

dims=size(allbet);
allbet_accum=zeros(dims(1)*6,dims(2)/6,dims(3));
for r=1:6
    allbet_accum((1:dims(1))+dims(1)*(r-1), :,:) = allbet(1:dims(1),(1:3)+(r-1)*3,:);
end
means_accum = squeeze(mean(allbet_accum))';
standarderrors_accum = squeeze(std(allbet_accum))'*(1/sqrt(n));

for reg=1:regsno
    % plot with stars:
    % figure; bar(means_paramestimates(reg,:)); hold on; plot(means_paramestimates(reg,:)+standarderrors(reg,:), 'r+'); plot(means_paramestimates(reg,:)-standarderrors(reg,:), 'r+');
    
    % plot single color: -------------------------
    % figure; bar(means_paramestimates(reg,:));
    %     hold on;
    %     plot([(1:18); (1:18)], [means_paramestimates(reg,:)+standarderrors(reg,:); means_paramestimates(reg,:)-standarderrors(reg,:)], 'r-', 'LineWidth', 4);
    
    if ~noplots % plot bar charts over all runs
        
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
    
    
    
    if ~noplots_accum % plot bar charts accumulated
        
        % OR: plot bars in different colors   --------
        figure;
        
        %     hold on;
        for i=1:size(means_accum,2)
            if mod(i,3)==1
                col = [0.3 0.2 1]; % 'blue';
            elseif mod(i,3) == 2
                col = [0.2 1 0.3]; % 'green';
            else
                col = [0.6 0.6 0.6];
            end
            bar(i, means_accum(reg,i), 'FaceColor', col);
            if i==1
                hold on;
            elseif i==3 % for the correct legend!
                plot([(1:3); (1:3)], [means_accum(reg,:)+standarderrors_accum(reg,:); means_accum(reg,:)-standarderrors_accum(reg,:)], 'r-', 'LineWidth', 4);
            end
        end
        %
        
        %     hold on;
        plot([(1:3); (1:3)], [means_accum(reg,:)+standarderrors_accum(reg,:); means_accum(reg,:)-standarderrors_accum(reg,:)], 'r-', 'LineWidth', 4);
        
        %     title(['Parameter estimates for ' clusternames{reg}],'Interpreter', 'none');
        %     ylabel(' parameter estimate ', 'Interpreter', 'none');
        xlim([0.2 3.8]);
        %     set(gca,'position',[0 0 1 1],'units','normalized')
        iptsetpref('ImshowBorder','tight')
        %     axis off
        set(gca, 'XTickLabelMode', 'Manual')
        set(gca, 'XTick', [])
        set(gca,'XColor','w')
        box off
        
        if(display_legend)
            legend('explicit EDT', 'implicit EDT', 'ODT', 'standard error')
            filename = fullfile(plotsdir, ['barcharts_accumulated_' num2str(reg) '_legend']);
            
        else
            filename = fullfile(plotsdir, ['barcharts_accumulated_' num2str(reg)]);
        end
        if(save_plots)
            saveas(gcf, filename, 'pdf');
            
            title(['Parameter estimates for ' clusternames{reg}],'Interpreter', 'none');
            saveas(gcf, filename, 'png');
        else
            title(['Parameter estimates for ' clusternames{reg}],'Interpreter', 'none');
        end
        
    end
    
end

