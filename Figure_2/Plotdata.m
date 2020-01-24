%%
clc;
clear;
close all;
%%
addpath('codes');
%%
clear;
disp('Plotting for Pairwise Data');
load('data/SDE_different_Dt_pairwise_output.mat');
plot_figures
%%
clear;
disp('Plotting for Ternary Data');
load('data/SDE_different_Dt_ternary_output.mat');
plot_figures

%% Save all Figures
openFigures = findobj('Type', 'figure');
for i = 1 : length(openFigures)
    try
        fig_name = openFigures(i).Children(2).Title.String;
    catch
        fig_name = openFigures(i).Children(1).Title.String;
    end
    saveas(openFigures(i), ['saved_plots/', fig_name, '.png']);
end