%% Plotting begins
lgd_parm = strings(1,length(Dt));
for p = 1:length(Dt)
    lgd_parm(p) = ['Dt = ' num2str(Dt(p))];
end
%%
tr = 0.5;
sz = 80;
mark_style = {'p','+','*','d','s','o','.','t', 'x', 'square', 'diamond', 'v', '^', '>', '<', 'pentagram'};
%%
% Plotting drift for different time scales (Figure 2E & 2F)
figure,
scatter(op,Drift{1,1},sz,mark_style{1})
for i = 2:length(Dt)
    hold on
    scatter(op,Drift{i,1},sz,mark_style{i})
end
hold on
plot(op,exp_drift,'Black','lineWidth',2)
xlim([-1 1])
% ylim([-0.13 0.13])
hline = refline([0 0]);
hline.Color = [0.1,0.1,0.1];
% xlabel('Polarization (X)','fontSize',16,'fontWeight','bold')
% ylabel('Drift (f(X))','fontSize',16,'fontWeight','bold')
% ylim([-0.02 0.02])
legend([lgd_parm 'Expected'],'Location','NorthEast')
if r3 == 0
    title('Figure 2E');
else
    title('Figure 2F'); 
end

%%
% Plotting diffusion (modified formula used in the paper) for different time scales (Figure 2G & 2H)
figure,
scatter(op,Diffusion_mod{1,1},sz,mark_style{1})
for i = 2:length(Dt)
    hold on
    scatter(op,Diffusion_mod{i,1},sz,mark_style{i})
end
hold on
plot(op,exp_diff,'Black','lineWidth',2)
% xlabel('Polarization (X)','fontSize',16,'fontWeight','bold')
% ylabel('Diffusion (g^2(X))','fontSize',16,'fontWeight','bold')
xlim([-1 1])
% ylim([0.0 0.045])
legend([lgd_parm 'Expected'],'Location','NorthEast')
if r3 == 0
    title('Figure 2G');
else
    title('Figure 2H'); 
end
%%
%Plot time series of data (Figure 2A and 2B)
figure,
plot(tSample,S)
xlim([20 200])
ylim([-1 1])
if r3 == 0
    title('Figure 2A');
else
    title('Figure 2B'); 
end

%%
% Plot pdf of data and the analytically expected pdf (Figure 2C and 2D). Uncomment 170-176 for the red curve.
figure,
[f,xi] = ksdensity(S(1000:end));
plot(xi,f,'LineWidth',2)
xlim([-1 1])
% ylim([0 1.2])
legend('GS','Location','north');
if r3 == 0
    title('Figure 2C');
else
    title('Figure 2D'); 
end