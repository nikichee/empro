function [] = plot_mean_and_standarderror(data)
% function [] = plot_mean_and_standarderror(data, title)
% plots mean and standard error of data stored in vals (arranged in
% columns)
% optional: title [string]

figure;
mean_vals = mean(data,1);
standarderrors = std(data).*(1/sqrt(size(data,1)));

bar(mean_vals);
hold on;
plot([(1:size(data,2)); (1:size(data,2))], [mean_vals+standarderrors; mean_vals-standarderrors], 'r-', 'LineWidth', 4);
xlim = ([0 size(data,2)+1]); 
title('mean and standard error')
