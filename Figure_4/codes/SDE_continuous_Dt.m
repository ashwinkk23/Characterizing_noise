%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Jitesh Jhawar, 2019                                             %
% This code uses a time series data and calcuates the underlying          %
% deterministic and the stochastic coefficients for diffrent time scales. %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%clc;
%clear;
%close all;
%%
%[file,folder] = uigetfile({'*.mat'});
%load([folder '/' file]);
%%
%different time scales (steps) for which the coefficients would be derived
%Dt = [1,5,10,50];
Dt = 1:1:200;

%cell array to store calculated drift coefficient for different time scales
Drift = cell(length(Dt),1);  

%cell array to store calculated diffusion coefficient for different time scales   
Diffusion = Drift;

%cell array to store calculated diffusion coefficient using modified formula (used in the paper) for different time scales 
Diffusion_mod = Drift; 

%cell array to store fitted drift coefficient for different time scales
Drift_fit = Drift; 

%cell array to store fitted diffusion coefficient for different time scales
Diffusion_fit = Drift;  

%Array to store distance between calculated and fitted drift for different Dt
dist_drift = zeros(length(Dt),1); 

%Array to store distance between calculated and fitted diffusion for different Dt
dist_diff = dist_drift;     

%If using simulated data then provide parameters used to calculate analytically expected functional forms. The distance will be calculated between the derived and the expected functions (and uncomment line 32)

% N = 200; r1 = 0.01; r2 = 1; r3 = 0; r4 = 0;

T_int = tSample(end)/((length(tSample)));   %Time interval between consecutive steps of the time series 
%(in seconds if real data)

% Calculate drift and diffusion for different time scale (step)
for i = 1:length(Dt)
    
    %Use the function to calculate for the given time scale (step)
    [Diffusion_temp,Diffusion_mod_temp,Drift_temp,op] = driftAndDiffusion_const_time(S(1000:end),T_int,Dt(i));
    
    %Storing in the cell array
    Drift{i,1} = Drift_temp;
    Diffusion{i,1} = Diffusion_temp;
    Diffusion_mod{i,1} = Diffusion_mod_temp;

end

%Removing spurious (outliers) points but this may be subjected to the data that you have (Comment 51 and 52 if there are no spurious points)
Diffusion_mod{1,1}(Diffusion_mod{1,1}>10) = nan;
Drift{1,1}(Drift{1,1}>10) = nan;

%Calculating expected functions based on the parametrs of the model. This expression works upto ternary model and pairwise negative interactions as well.
exp_drift = -2*r1*op - 2*r4*op + (r3/2)*op.*(1-op.^2); %expected
exp_diff = (2/sqrt(N))*sqrt(r1+r4+((2*r2+r3-2*r4)*(1-op.^2)/4));
exp_diff = exp_diff.^2;
op = op';

%Calculating the distance between the expected and derived (for each time scale)
for i = 1:length(Dt)
    Drift_temp = Drift{i,1};
    idx = find(~isnan(Drift_temp));
    p = polyfit(op(idx),Drift_temp(idx),3);
    Drift_fit = polyval(p,op);
    dist_drift(i,1) = sqrt(nanmean((Drift_temp - exp_drift').^2))/nanmean(abs(exp_drift));
    
    Diffusion_temp = Diffusion_mod{i,1};
    idx = find(~isnan(Diffusion_temp));
    q = polyfit(op(idx),Diffusion_temp(idx),2);
    Diffusion_fit = polyval(q,op);
    dist_diff(i,1) = sqrt(nanmean((Diffusion_temp - exp_diff').^2))/nanmean(exp_diff);
end

%% Plotting begins
% lgd_parm = strings(1,length(Dt));
% for p = 1:length(Dt)
%     lgd_parm(p) = ['Dt = ' num2str(Dt(p))];
% end
%%
% tr = 0.5;
% sz = 80;
% %mark_style = {'p','+','*','d','s','o','.','t'};
% mark_style = {'p','+','*','d','s','o','.','t', 'x', 'square', 'diamond', 'v', '^', '>', '<', 'pentagram'};
%%
% % Plotting drift for different time scales (Figure 2E & 2F)
% figure,
% scatter(op,Drift{1,1},sz,mark_style{1})
% for i = 2:length(Dt)
%     hold on
%     scatter(op,Drift{i,1},sz,mark_style{i})
% end
% hold on
% plot(op,exp_drift,'Black','lineWidth',2)
% xlim([-1 1])
% % ylim([-0.13 0.13])
% hline = refline([0 0]);
% hline.Color = [0.1,0.1,0.1];
% % xlabel('Polarization (X)','fontSize',16,'fontWeight','bold')
% % ylabel('Drift (f(X))','fontSize',16,'fontWeight','bold')
% % ylim([-0.02 0.02])
% legend([lgd_parm 'Expected'],'Location','NorthEast')
% if r3 == 0
%     title('Figure 2E');
% else
%     title('Figure 2F'); 
% end

%%
% % Plotting diffusion (modified formula used in the paper) for different time scales (Figure 2G & 2H)
% figure,
% scatter(op,Diffusion_mod{1,1},sz,mark_style{1})
% for i = 2:length(Dt)
%     hold on
%     scatter(op,Diffusion_mod{i,1},sz,mark_style{i})
% end
% hold on
% plot(op,exp_diff,'Black','lineWidth',2)
% % xlabel('Polarization (X)','fontSize',16,'fontWeight','bold')
% % ylabel('Diffusion (g^2(X))','fontSize',16,'fontWeight','bold')
% xlim([-1 1])
% % ylim([0.0 0.045])
% legend([lgd_parm 'Expected'],'Location','NorthEast')
% if r3 == 0
%     title('Figure 2G');
% else
%     title('Figure 2H'); 
% end

%%
% Diffusion from simple formula
% figure,
% % subplot(1,2,2)
% % scatter(op,Diffusion{i,1},40,'filled')
% % hold on
% scatter(op,Diffusion{1,1},sz,mark_style{1})
% for i = 2:length(Dt)
%     hold on
%     scatter(op,Diffusion{i,1},sz,mark_style{i})
% end
% hold on
% plot(op,exp_diff,'Black','lineWidth',2)
% % xlabel('Polarization (X)','fontSize',16,'fontWeight','bold')
% % ylabel('Diffusion (g^2(X))','fontSize',16,'fontWeight','bold')
% xlim([-1 1])
% % ylim([0.0 0.4])
% legend('Dt = 1','Dt = 5','Dt = 10','Dt = 50','Expected',16,'Location','northeast')
% % legend('Derived (method 1)','Derived (method 2)','Expected','fontSize',16,'fontWeight','bold')

%%
% %Plotting distance between derived and expected and R^2 of the fits
% figure,
% subplot(1,2,1)
% % yyaxis left
% scatter(Dt,dist_drift,80)
% % ylabel({'Distance, Drift';'(Expected - Fitted)'},'fontWeight','bold','fontSize',16)
% % yyaxis right
% % scatter(Dt,R2_drift,40,'filled')
% % ylabel('R^2','fontWeight','bold','fontSize',16)
% % xlabel('Dt','fontWeight','bold','fontSize',16)
% % ylim([0 0.0005])
% % xlim([0 90])
% 
% subplot(1,2,2)
% % yyaxis left
% scatter(Dt,dist_diff,80)
% % ylabel({'Distance, Diffusion';'(Expected - Fitted)'},'fontWeight','bold','fontSize',16)
% % yyaxis right
% % scatter(Dt,R2_diff,40,'filled')
% % xlabel('Dt','fontWeight','bold','fontSize',16)
% % ylabel('R^2','fontWeight','bold','fontSize',16)
% % xlim([0 90])

%%
% %Plot time series of data (Figure 2A and 2B)
% figure,
% plot(tSample,S)
% xlim([20 200])
% ylim([-1 1])
% if r3 == 0
%     title('Figure 2A');
% else
%     title('Figure 2B'); 
% end
%%
% %%
% % Plot pdf of data and the analytically expected pdf (Figure 2C and 2D). Uncomment 170-176 for the red curve.
% figure,
% [f,xi] = ksdensity(S(1000:end));
% plot(xi,f,'LineWidth',2)
% % hold on
% % ar = area(xi,f);
% % ec = ar.EdgeColor;
% % ar.EdgeAlpha = 0;
% % ar.FaceColor = 'blue';
% % ar.FaceAlpha = 0.2;
% % plot(m_pairwise,I_pairwise,'--','LineWidth',2)
% xlim([-1 1])
% % ylim([0 1.2])
% legend('GS','Location','north');
% if r3 == 0
%     title('Figure 2C');
% else
%     title('Figure 2D'); 
% end
%%
%save('SDE_different_Dt_output.mat', 'op', 'Drift', 'exp_drift', 'Diffusion_mod', 'exp_diff', 'Dt', 'dist_drift', 'dist_diff', 'tSample', 'S', 'xi', 'f', 'N', 'r1', 'r2', 'r3', 'r4')