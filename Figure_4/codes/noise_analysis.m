noise = underlyingNoise((S(:)),40,0,0.01,Tint);
pd1 = fitdist(noise,'Normal');
x_values = -0.1:0.0055:0.1;
y1 = pdf(pd1,x_values);
%figure,
%histogram(noise,x_values,'Normalization','pdf')
%hold on
%plot(x_values,y1,'LineWidth',2)
%xlabel('Fluctuations','fontWeight','bold','fontSize',16)
%ylabel('Probability density','fontWeight','bold','fontSize',16)
%xlim([min(noise) max(noise)])
%%
t_lag = 10;  %Lag has to be modulated according to parameters
acf = autocorr(noise,t_lag);
t_lag = (0:t_lag);
%figure,plot(t_lag,acf)