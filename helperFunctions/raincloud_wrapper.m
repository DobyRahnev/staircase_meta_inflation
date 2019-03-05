function raincloud_wrapper(data, subplot_num, ylabel)

%--------------------------------------------------------------------------
% This is a wrapper function written by Doby Rahnev using the raincloud
% codes developed by Micah Allen, Davide Poggiali, Kirstie Whitaker, Tom 
% Rhys Marshall, and Rogier Kievit (if using, please cite their paper!).
%
% Inputs:
% data: an n (num_subjects) X k (num_conditions) matrix
% subplot_num: the subplot number
% ylabel: text for plot title and y label
%--------------------------------------------------------------------------

% Parameters for plotting
num_sub = size(data,1);
num_cond = size(data,2);
scale = .09;
max_y = 2*scale;
loc = [-1:-2:-2*num_cond]*scale;
dispers = .8*scale;

% Decide which subplot to plot
if subplot_num > 0
    subplot(2,3,subplot_num)
end

% Create the raincloud plots
h1= raincloud_plot_doby('X', data(:,1), 'color', [0,0,1], 'alpha', 0.5, ...
    'box_on', 1, 'box_col_match', 1, 'box_dodge', 1, 'box_dodge_amount', -loc(1));
h2= raincloud_plot_doby('X', data(:,2), 'color', [1,0,0], 'alpha', 0.5, ...
    'box_on', 1, 'box_col_match', 1, 'box_dodge', 1, 'box_dodge_amount', -loc(2));
h3= raincloud_plot_doby('X', data(:,3), 'color', [0,.5,0], 'alpha', 0.5, ...
    'box_on', 1, 'box_col_match', 1, 'box_dodge', 1, 'box_dodge_amount', -loc(3));

% Change the dispersion of the rain drops
h1{2}.YData = unifrnd(loc(1)-dispers, loc(1)+dispers, num_sub, 1);
h2{2}.YData = unifrnd(loc(2)-dispers, loc(2)+dispers, num_sub, 1);
h3{2}.YData = unifrnd(loc(3)-dispers, loc(3)+dispers, num_sub, 1);

% Standardize the height of the rainclouds
current_max_y = max([h1{1}.YData, h2{1}.YData, h3{1}.YData]);
h1{1}.YData = h1{1}.YData * max_y/current_max_y;
h2{1}.YData = h2{1}.YData * max_y/current_max_y;
h3{1}.YData = h3{1}.YData * max_y/current_max_y;

% Add legend, labels, limits, ticks
legend([h1{1} h2{1} h3{1}], {'1-contrast', '3-contrast', 'all-contrast'})
title(ylabel)
xlabel(ylabel)
set(gca,'YLim', [-2*num_cond*scale, max_y]);
set(gca,'YTick',[]);