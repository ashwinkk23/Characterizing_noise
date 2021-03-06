clc;
clear;
close all;
%%
addpath('codes');
%% Pairwise Fine Varying resolution 
clear;
tic
N_list = [50, 100, 200]; 
r1 = 0.01; 
r2 = 1; 
r3 = 0; 
r4 = 0; 
res = 1:1:200; 
for N = N_list
    disp(strcat('Generating data for N =', num2str(N))); 
    varying_resolution
    save(['data/','varying_resolution_fine_pairwise_N_', num2str(N), '.mat'],'Diffusion_distance','res');
end
toc
%% Trenary Fine Varying Resolution
clear;
tic
N_list = [50, 100, 200]; 
r1 = 0.01; 
r2 = 1; 
r3 = 0.08; 
r4 = 0; 
res = 1:1:200; 
for N = N_list
    disp(strcat('Generating data for N =', num2str(N))); 
    varying_resolution
    save(['data/','varying_resolution_fine_Ternary_N_', num2str(N), '.mat'],'Diffusion_distance','res');
end
toc
%% Pairwise Coarser Varying Resolution
N_list = [50, 100, 200];
r1 = 0.01; 
r2 = 1; 
r3 = 0; 
r4 = 0;
Tint = 50;
for N = N_list
    disp(strcat('Running for N=', num2str(N)));
    Gillespie_stochastic_process
    disp('Running SDE');
    SDE_continuous_Dt
    save(['data/', 'varying_resolution_coarser_pairwise_N_', num2str(N)], 'dist_diff', 'Dt');
end
%% Ternary Coarser Varying Resolution
N_list = [50, 100, 200];
r1 = 0.01; 
r2 = 1; 
r3 = 0.08; 
r4 = 0;
Tint = 50;
for N = N_list
    disp(strcat('Running for N=', num2str(N)));
    Gillespie_stochastic_process
    disp('Running SDE');
    SDE_continuous_Dt
    save(['data/', 'varying_resolution_coarser_trenary_N_', num2str(N)], 'dist_diff', 'Dt');
end
%% Noise Analysis Pairwise
clear;
N = 50;
r1 = 0.01; 
r2 = 1; 
r3 = 0; 
r4 = 0; 
Tint_list = [10, 50];
for Tint = Tint_list
    disp(strcat('Running for Tint = ', num2str(Tint)));
    Gillespie_stochastic_process
    noise_analysis
    save(['data/', 'Noise_analysis_Pairwise_delta_t_', num2str(Tint), '.mat'], 'noise', 'x_values', 'y1', 't_lag', 'acf')
end
%% Noise Analysis Ternary
clear;
N = 50;
r1 = 0.01; 
r2 = 1; 
r3 = 0.08; 
r4 = 0; 
Tint_list = [10, 50];
for Tint = Tint_list
    disp(strcat('Running for Tint = ', num2str(Tint)));
    Gillespie_stochastic_process
    noise_analysis
    save(['data/', 'Noise_analysis_Ternary_delta_t_', num2str(Tint), '.mat'], 'noise', 'x_values', 'y1', 't_lag', 'acf')
end