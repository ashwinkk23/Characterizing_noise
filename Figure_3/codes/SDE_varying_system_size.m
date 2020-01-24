%Author: Jitesh Jhawar
%Date:25/09/2018
%This code simulates the numerical integration of a stochastic differential
%equation
%individual based model
%%
% clc;
% clear;
% close all;
%% Parameters
% r1 = 0.01; 
% r2 = 1; 
% r3 = 0; 
% r4 = 0;
% size = 50:1:200;
%%
repetitions = 5;   %Number of repetitions
est_tau = zeros(repetitions,length(size));
count = 1;
for N = size
    N
    for rep = 1:repetitions
        rep
        n = 3000000; %Number of simulation steps
        x = zeros(n,1);
        time = zeros(n,1);
        x(1,1) = 2*rand(1)-1;
        del_t = 0.01;
        i = 1;
        while i ~= n-1
            
            nx = x(i);
            
            diff = 4/N*(r1+((2*r2+r3)*(1-nx^2)/4));
            if (diff < 0)
                i = i - 1;
            end
            nx = x(i);
            diff = 4/N*(r1+((2*r2+r3)*(1-nx^2)/4));
            
            
            
            drift =  -2*r1*nx + (r3/2)*nx.*(1-nx^2);
            
            
            
            r = randn(1,1);
            
            %     if (drift > 1)
            %         drift=1;
            %     end
            
            x(i+1) = x(i) + (drift)*del_t + r*(diff)^0.5*(del_t^0.5);
            time(i) = (i*del_t);
            i = i + 1;
            
        end
        t_lag = max(100,N*10);
        %     x(isnan(x)) = 0;
        acf = autocorr(x,t_lag);
        t_lag = (1:t_lag+1)*del_t;
        t_lag = t_lag';
        idx = find(~isnan(acf));
        f = fit(t_lag(idx),acf(idx),'exp1');
        val = coeffvalues(f);
        b = val(1,2);
        a = val(1,1);
        ct = -1*(1/b);
        est_tau(rep,count) = ct;
        est_tau(rep+1,count) = N;
    end
    count = count + 1;
end
% est_tau(rep+1,:) = size;
% save(['N_' num2str(min(size)) '_' num2str(max(size)) '_est_tau_N.mat'],'est_tau');

p = [-r3/2 0 (r3/2-2*r1) 0];
m = roots(p);
if length(m) > 1
    exp_tau = -2*r1 + (r3/2) - 3/2*(r3*m.^2);
    exp_tau = 1/abs(exp_tau(2));
elseif length(m) == 1
    exp_tau = 1/(2*r1);
end