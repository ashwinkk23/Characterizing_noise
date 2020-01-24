%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by Jitesh Jhawar somewhere in 2017. This code simulates a            %
% stochastic process using the standard algorithm presented by Sir D Gillespie,% 
% 1976. The process simulates the evolution of temporal dynamics of consensus  %
% in a population that contains individuals in two states. These individuals   %
% switch between their states via. different kinds of reactions/interactions.  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% clc;
% clear;
% close all;
%%
tic
%% Parameters 
% % Population size
% N = 50; 
% % spontaneous reaction rate
% r1 = 0.01; 
% % pairwise reaction rate
% r2 = 1;  
% % Ternary reaction rate  
% r3 = 0.08; 
% % pairwise negative reaction rate
% r4 = 0; 
%realizations/repetitions of the simulations
rel = 1; 
% Sampling time (Time after which system's state would be stored)
Tint = 50;%ceil((r2+r3+r4)/((N^0.5)*r1)); 
% Simulation time. I have kept it as a function of sampling time.
Tend = ceil(Tint*1e5);
%%
% Number of reactions at individual level
mu  = 8; 
%Array to store reaction rates propensities
C = zeros(mu,1); 
%Array to store reaction propensities at the given time
A = C; 
C(1:2) = r1;
C(3:4) = r2;
C(5:6) = r3;
C(7:8) = r4;
%%
% Size of array to store system's state. Usually this will exceed the actual steps it Tint > 1  
steps = floor(Tend); 
   
%Arrays to store system's state and time for different realizations
S = zeros(steps,rel);
S1 = S; S2 = S1; sum_all = S1; tSample = S1;

% Loop for doing multiple realizations
for iter = 1:rel
    iter;
    %Initializing 
    X1 = ceil(rand(1,1)*N); X2 = N-X1; 
%     X1 = (randi(2)-1)*N; X2 = N-X1;

	% counter to store number of sampling (see line 95-99)
    n = 0;
    
    % Intitializing system's time 
    T = 0; 
%     loop = 0;

	%Initializing time at which sampling is done. This will get incremented by Tint after every sampling (see line 98)
    Tprint = 0.01; 
    while (T < Tend)
        %         loop = loop + 1
        %Calculating reaction propensities according to system's state
        A(1) = C(1)*X2/N;  %1
        A(2) = C(2)*X1/N;  %2
        A(3) = C(3)*X1*X2/(N^2);   %3
        A(4) = C(4)*X1*X2/(N^2);   %4
        A(5) = C(5)*(X1^2)*X2/(N^3);   %5
        A(6) = C(6)*X1*(X2^2)/(N^3);   %6
        A(7) = C(7)*(X1^2)/(N^2);    %7
        A(8) = C(8)*(X2^2)/(N^2);    %8
        
        A0 = sum(A);
        A0 = A0(1,1);
        
        %Generating random numbers
        R(1) = rand(1,1);
        
        %Calculating time to next reaction according to total reaction propensity
        T = T + (log(1/R(1)))/A0; 
          
        % Condition for sampling
        if T > Tprint
            n = n  + 1;
            S1(n,iter) = X1; S2(n,iter) = X2; sum_all(n,iter) = (X1+X2)/N;
            S(n,iter) = (X1 - X2)/N; %Storing system's state
            Tprint = Tprint + Tint;
            tSample(n,iter) = T;  %Storing system's time
            
        end
        
        % Determining the reaction that would occur at current time
        R(2) = rand(1,1);
        R2A0 = R(2)*A0;
        Sum = 0;
        nu = 1;
        while Sum <= R2A0 %&& nu <= 24
            mu = nu;
            Sum = Sum + A(nu);
            nu = nu + 1;
        end
        
        % Update the system according to the reaction that has occured
        if mu == 1 || mu == 4 || mu == 5 || mu == 8
            X2 = X2 - 1;
            X1 = X1 + 1;
        elseif mu == 2 || mu == 3 || mu == 6 || mu == 7
            X1 = X1 - 1;
            X2 = X2 + 1;
        end
    end
end

tSample = tSample/N;  %Scaling time to mesoscopic scale
S = S(find(tSample ~= 0));  %Removing all the extra unfilled part of the array
tSample = tSample(find(tSample ~= 0));  %Removing all the extra unfilled part of the array


S1(S1==0) = nan;
S2(S2==0) = nan;

% Calculating correlation time
t_lag = 500;  %Lag has to be modulated according to parameters
S(isnan(S)) = 0;
acf = autocorr(S(:,iter),t_lag);
t_lag = (1:t_lag+1);
t_lag = t_lag';
idx = find(~isnan(acf));
f = fit(t_lag(idx),acf(idx),'exp1');
val = coeffvalues(f);
b = val(1,2);
a = val(1,1);
ct = -1*ceil(1/b);
t_acf = tSample(1:length(t_lag));
est_tau = tSample(ct);

% Expected correlation time according to the deterministic term of the SDE
p = [-r3/2 0 (r3/2-2*r1-2*r4) 0];
m = roots(p);
if length(m) > 1
	exp_tau = -2*r1 -2*r4 + (r3/2) - 3/2*(r3*m.^2);
    exp_tau = 1/abs(exp_tau(2));
elseif length(m) == 1
    exp_tau = 1/(2*r1);
end
    
%% Plotting time series of polarization and histogram
% figure,
% subplot(2,1,1)
% plot(tSample(:,iter),S(:,iter))
% xlabel('Time','fontSize',16,'fontWeight','bold')
% ylabel('Polarization (X)','fontSize',16,'fontWeight','bold')
% % xlim([0,1000])
% 
% subplot(2,1,2)
% nbins=40;
% histogram(S(:),nbins)
% xlabel('Polarization (X)','fontSize',16,'fontWeight','bold')
% ylabel('Frequency','fontSize',16,'fontWeight','bold')
% xlim([-1 1])
%%

toc
% save('Gillespie_stochastic_process_output.mat', 'tSample', 'S', 'r1', 'r2', 'r3', 'r4', 'N'); 

