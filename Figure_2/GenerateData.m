%%
clc;
clear;
close all;
%%
addpath('codes');
%% Pairwise Model Parameters
clear;
% Population size
N = 50; 
% spontaneous reaction rate
r1 = 0.01; 
% pairwise reaction rate
r2 = 1;  
% Ternary reaction rate  
r3 = 0; 
% pairwise negative reaction rate
r4 = 0; 
disp('Running Gillispie Stocastic Process pairwise Model');
Gillespie_stochastic_process
save(['data/', 'Gillespie_stochastic_process_pairwise_output.mat'], 'tSample', 'S', 'r1', 'r2', 'r3', 'r4', 'N'); 

disp('Running SDE for different Dt Pairwise');
SDE_different_Dt
save(['data/', 'SDE_different_Dt_pairwise_output.mat'], 'op', 'Drift', 'exp_drift', 'Diffusion_mod', 'exp_diff', 'Dt', 'dist_drift', 'dist_diff', 'tSample', 'S', 'xi', 'f', 'N', 'r1', 'r2', 'r3', 'r4')

disp('Running SDE for continuous Dt Pairwise');
%% Ternary Model Parameters
clear;
% Population size
N = 50; 
% spontaneous reaction rate
r1 = 0.01; 
% pairwise reaction rate
r2 = 1;  
% Ternary reaction rate  
r3 = 0.08; 
% pairwise negative reaction rate
r4 = 0; 
disp('Running Gillispie Stocastic Process Ternary Model');
Gillespie_stochastic_process
save(['data/', 'Gillespie_stochastic_process_ternary_output.mat'], 'tSample', 'S', 'r1', 'r2', 'r3', 'r4', 'N'); 
disp('Running SDE for different Dt Ternary');
SDE_different_Dt
save(['data/', 'SDE_different_Dt_ternary_output.mat'], 'op', 'Drift', 'exp_drift', 'Diffusion_mod', 'exp_diff', 'Dt', 'dist_drift', 'dist_diff', 'tSample', 'S', 'xi', 'f', 'N', 'r1', 'r2', 'r3', 'r4')
%%
