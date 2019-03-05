function plot_scatterplot(data1, data2, subplot_num, xLimits, xLableText, title_text)

subplot(2,3,subplot_num)
plot(data1, data2, 'o')
hold on
b = regress(data2, [ones(length(data1),1), data1]);
plot(xLimits, b(1) + xLimits.*b(2), 'k')
xlim(xLimits);
xlabel(xLableText)
ylabel(title_text)
title(title_text)
box off