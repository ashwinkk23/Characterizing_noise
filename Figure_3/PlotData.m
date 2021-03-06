clc;
clear;
close all;
%%
addpath('codes');
%%
files = dir(fullfile('data','*r1_.mat'));
figure;
subplot(2,2,1);
for i = length(files) :-1:  1
    load(['data/', files(i).name]); 
    scatter(Dt,dist_drift,80)
    hold on
end
title('Figure 3A');
%%
files = dir(fullfile('data','*N_.mat'));
%figure;
subplot(2,2,2);
for i = 1: length(files)
    load(['data/', files(i).name])
    scatter(Dt,dist_diff,80)
    hold on
end
title('Figure 3B');
%%
load(['data/', 'opt_Dt_changing_r1.mat'])
%figure;
subplot(2,2,3);
scatter(est_tau, opt_Dt);
title('Figure 3C');
%%
load(['data/', 'opt_Dt_changing_N.mat'])
load(['data/', 'SDE_varying_system_size_est_tau_mean.mat'])
correlation_extraction
%figure;
subplot(2,2,4);
scatter(tau_mean, opt_Dt);
title('Figure 3D');