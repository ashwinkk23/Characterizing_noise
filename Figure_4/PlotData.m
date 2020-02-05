clc;
clear;
close all;
%%
addpath('codes');
%%
files = dir(fullfile('data', 'Noise_analysis_*'));
title_list1 = ['A', 'B', 'C', 'D'];
title_list2 = ['E', 'F', 'G', 'H'];
figure;
for i = 1:length(files)
    load(['data/', files(i).name]);
    subplot(3,4,i);
    histogram(noise,x_values,'Normalization','pdf')
    hold on
    plot(x_values,y1,'LineWidth',2)
    %xlabel('Fluctuations','fontWeight','bold','fontSize',16)
    %ylabel('Probability density','fontWeight','bold','fontSize',16)
    xlim([-0.1 0.1])
    title(strcat('Figure 4', title_list1(i)));
    subplot(3,4,i+4);
    plot(t_lag,acf)
    xlim([0,10]);
    ylim([0,1]);
    title(strcat('Figure 4', title_list2(i)));
end
%%
files = dir(fullfile('data', 'varying_resolution_fine_*'));
subplot(3,4,11);
for i = 1:3
    load(['data/', files(i).name]);
    scatter(res, Diffusion_distance)
    hold on;
end
xlim([40,200]);
ylim([0,1]);
title('Figure 4K');
subplot(3,4,9);
for i = 4:6
    load(['data/', files(i).name]);
    scatter(res, Diffusion_distance);
    hold on;
end
xlim([40,200]);
ylim([0,1]);
title('Figure 4I');
%%
files = dir(fullfile('data', 'varying_resolution_coarser_pairwise_N_*'));
subplot(3,4,10);
for i = 1:length(files)
    load(fullfile('data', files(i).name))
    scatter(Dt, dist_diff);
    hold on; 
end
xlim([0,50])
ylim([0,0.6])
%%
files = dir(fullfile('data','varying_resolution_coarser_trenary_N_*'));
subplot(3,4,12);
for i = 1:length(files)
    load(fullfile('data', files(i).name))
    scatter(Dt, dist_diff);
    hold on; 
end
xlim([0,50])
ylim([0,0.8])