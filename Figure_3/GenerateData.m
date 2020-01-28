%%
clc;
clear;
close all;
%%
addpath('codes');
%%
%% Pairwise Model Parameters
clear;
% Population size
N = 50; 
% spontaneous reaction rate
r1_list = [0.01, 0.005, 0.0025]; 
% pairwise reaction rate
r2 = 1;  
% Ternary reaction rate  
r3 = 0; 
% pairwise negative reaction rate
r4 = 0; 
Dt = 1:1:150;
for r1 = r1_list
    disp(strcat('Running Gillispie Stocastic Process Pairwise Model for r1 = ', num2str(r1)));
    Gillespie_stochastic_process
    save(['data/', 'Gillespie_stochastic_process_pairwise_output_r1_', num2str(r1), '_.mat'], 'tSample', 'S', 'r1', 'r2', 'r3', 'r4', 'N');
    
    disp(strcat('Running SDE for continuous Dt Pairwise Model for r1 = ', num2str(r1)));
    SDE_continuous_Dt
    save(['data/', 'SDE_continuous_Dt_pairwise_output_', num2str(r1), '_r1_.mat'], 'op', 'Drift', 'exp_drift', 'Diffusion_mod', 'exp_diff', 'Dt', 'dist_drift', 'dist_diff', 'tSample', 'S', 'xi', 'f', 'N', 'r1', 'r2', 'r3', 'r4')
end
%% Ternary Model Parameters
clear;
% Population size
N_list = [50, 100, 200]; 
% spontaneous reaction rate
r1 = 0.01; 
% pairwise reaction rate
r2 = 1;  
% Ternary reaction rate  
r3 = 0.08; 
% pairwise negative reaction rate
r4 = 0; 
Dt = 1:1:150;
for N = N_list
    disp(strcat('Running Gillispie Stocastic Process Ternary Model for N = ', num2str(N)));
    Gillespie_stochastic_process
    save(['data/', 'Gillespie_stochastic_process_ternary_output_N_', num2str(N), '_.mat'], 'tSample', 'S', 'r1', 'r2', 'r3', 'r4', 'N');
    
    disp(strcat('Running SDE for continuous Dt Pairwise Model for N = ', num2str(N)));
    SDE_continuous_Dt
    save(['data/', 'SDE_continuous_Dt_trenary_output_', num2str(N) ,'_N_.mat'], 'op', 'Drift', 'exp_drift', 'Diffusion_mod', 'exp_diff', 'Dt', 'dist_drift', 'dist_diff', 'tSample', 'S', 'xi', 'f', 'N', 'r1', 'r2', 'r3', 'r4')
end

%% Optimun time scale changing r1
clear;
N = 50; 
s = flip(1./(2*(10:10:200))); 
r2 = 1; 
r3 = 0; 
r4 = 0; 
Dt = 1:1:100;
Tint = 50;
disp('Running optDt for changing r1');
optDt_changing_r1
save(['data/', 'opt_Dt_changing_r1.mat'],'opt_Dt', 'est_tau');
%% Optimium time scale for changing system size (N)
% Parameters 
clear;
size = 50:1:200; 
r1 = 0.01;
r2 = 1; 
r3 = 0.08; 
r4 = 0; 
Tint = 50;
Dt = 1:1:200;
disp('Running optDt for chnaging N');
optDt_changing_N
save(['data/', 'opt_Dt_changing_N_mod_GS_Runner.mat'], 'opt_Dt');
disp('Etimating est_tau');
tic
SDE_varying_system_size
toc
save(['data/', 'SDE_varying_system_size_est_tau_mean.mat'],'tau_mean');