% d=dir('*.csv');   % dir struct of all pertinent .csv files
% n=length(d);        % how many there were
% data=cell(1,n);     % preallocate a cell array to hold results
% for i=1:n
%   data{i}=csvread(d(i).name);  % read each file
% end
% data = csvread('s_0.0025_0.05_est_tau_s.csv');
% data(data<0) = nan;
% data = load('N_50_200_est_tau_N.mat');
data = est_tau;
data(data<0) = nan;
corr = (data);
tran_corr = corr';
flip_corr = fliplr(tran_corr);
% sort_corr = sortrows(flip_corr);
final_corr = flip_corr(:,2:end);
% final_corr = final_corr';
tau_mean = zeros(length(final_corr(:,1)),1); tau_sd = tau_mean;
% s = flip_corr(:,1);
N = flip_corr(:,1);
for i = 1:length(flip_corr(:,1))
    tau_mean(i,1) = nanmean(final_corr(i,:));
    tau_sd(i,1) = nanstd(final_corr(i,:));
end
%%
% p = cell(length(s),1); exp_tau = cell(length(s),1); exp_tau_new = zeros(length(s),1);
% for i = 1:length(s)
% p{i} = [-r2/2 0 (r2/2-2*s(i)) 0];
%     m = roots(p{i});
% %     if length(m) > 1
%         exp_tau{i} = -2*s(i) + (r2/2) - 3/2*(r2*m.^2);
%         exp_tau_new(i) = 1./abs(exp_tau{i}(2));
% %     elseif length(m) == 1
% %         exp_tau_new(i) = 1/(2*s(i));
% %     end
% end
%%
figure,
scatter(N,tau_mean,50,'Filled')
% scatter(s,tau_varying_s,50,'Filled')
% hold on
% plot(s,exp_tau_new,'LineWidth',2)
ylim([0 200])
% hline = refline([0 50]);
% hline.Color = 'r';
% hline.LineWidth = 2;
% legend('Estimated','Expected (AN)','Location','north')
% xlim([0.0025 0.05])
%%
% tau = tau_mean(N);
figure,
scatter(s,tau_mean,80,'filled')
% ylim([1 16])
% xlim([0 100])
%%
figure,scatter(N,opt_Dt,60,'filled')
ylim([0 50])