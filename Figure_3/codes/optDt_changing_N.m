%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by Jitesh Jhawar somewhere in 2017. This code simulates a            %
% stochastic process using the standard algorithm presented by Sir D Gillespie,% 
% 1976. The process simulates the evolution of temporal dynamics of consensus  %
% in a population that contains individuals in two states. These individuals   %
% switch between their states via. different kinds of reactions/interactions.  %
% Following this, we also derive the underying SDE from data and compare the   %
% reconstructed functions with the expected ones.                              % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% clc;
% clear;
% close all;
%%
%%
%$ Parameters 
% size = 50:1:200; 
% r1 = 0.01;
% r2 = 1; 
% r3 = 0.08; 
% r4 = 0; 
% Tint = 50;
% Dt = 1:1:200;
%%
opt_Dt = zeros(length(size),1);
est_tau = zeros(length(size),1);
%%
% addpath('../Figure_2/');

% Dt = [1,Dt];
Drift = cell(length(Dt),1);
Diffusion = Drift; Diffusion_mod = Drift;
dist_drift = zeros(length(Dt),1); dist_diff = dist_drift;
n_iter = length(size);
for j = 1:length(size)
    tic
    j
    N = size(j);
    [tSample,S] = GS_runner1D(N,r1,r2,r3,r4,Tint);
    
    % calculated drift diffusion for different Dt for same time series and store them in cell array 
    for i = 1:length(Dt)
        i
        T_int = 1;
        [Diffusion_temp,Diffusion_mod_temp,Drift_temp,op] = driftAndDiffusion_const_time(S,T_int,Dt(i));
        Drift{i,1} = Drift_temp;
        Diffusion{i,1} = Diffusion_temp;
        Diffusion_mod{i,1} = Diffusion_mod_temp;
    end
    
    Diffusion_mod{1,1}(Diffusion_mod{1,1}>10) = nan;
    Drift{1,1}(Drift{1,1}>10) = nan;
    exp_drift = -2*r1*op - 2*r4*op + (r3/2)*op.*(1-op.^2); %expected
    exp_diff = (2/sqrt(N))*sqrt(r1+r4+((2*r2+r3-2*r4)*(1-op.^2)/4));
    exp_diff = exp_diff.^2;
    op = op';
    
    %calculate distance between the expected and the extracted
    for i = 1:length(Dt)
        Drift_temp = Drift{i,1};
        dist_drift(i,1) = sqrt(nanmean((Drift_temp - exp_drift').^2))/nanmean(abs(exp_drift));
        Diffusion_temp = Diffusion_mod{i,1};
        idx = find(~isnan(Diffusion_temp));
        dist_diff(i,1) = sqrt(nanmean((Diffusion_temp - exp_diff').^2))/nanmean(exp_diff);
    end
    
    %Find optimal Dt and store
    [M,I] = min(dist_drift);
    opt_Dt(j) = I;
    t = toc;
    n_iter = n_iter - 1;
    disp(strcat('Estimated remaining time: ', num2str(n_iter*t/60), ' minutes'));
end
%%
% save('opt_Dt_changing_N.mat','opt_Dt');
% save('est_tau_interp_r1.mat','est_tau');
%%