function plot_3bars(measure, subplot_num, title_text, yBounds, plotIndividualData, p)

% Determine the number of subjects
n_subjects = size(measure,1);

% Choose the panel in the figure where to plot
if subplot_num == 0
    figure;
else
    subplot(2,3,subplot_num)
end

% Display the 3 main bars
bar(1, mean(measure(:,1)), 'b');
hold on
bar(2, mean(measure(:,2)), 'r');
bar(3, mean(measure(:,3)), 'g');

% Display the eror bars
for i=1:3
    plot([i,i], [mean(measure(:,i))-std(measure(:,i))/sqrt(n_subjects), ...
        mean(measure(:,i))+std(measure(:,i))/sqrt(n_subjects)], 'k', 'LineWidth', 1);
end

% Add info
title(title_text)
ylabel(title_text)
box off

% Plot individual data OR significance
if plotIndividualData
    for sub=1:n_subjects
        plot(1:3, measure(sub,:), 'k-')
    end
else
    % Line
    heightLine = (3*(mean(measure(:,3))+std(measure(:,3))/sqrt(n_subjects)) + yBounds(2))/4;
    plot([1,3], [heightLine, heightLine], 'k', 'LineWidth', .5);
    
    %Textbox
    if subplot_num == 0
        dim = [.45, .7, .3, .2];
    else
        dim = [.1+(rem(subplot_num-1,3))/3, .3+(subplot_num<4)/2, .1, .1];
    end
    str = ['p = ' num2str(p)];
    annotation('textbox',dim,'String',str,'FitBoxToText','on', 'LineStyle','none');
    ylim(yBounds);
end