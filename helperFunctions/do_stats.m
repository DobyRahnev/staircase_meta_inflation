function [p_anova, p_ttests, effect_sizes] = do_stats(data)

% One-way repeated measures ANOVA
y = reshape(data,[],1);
subjects = [1:length(y)/3, 1:length(y)/3, 1:length(y)/3]';
conditions(1:length(y)/3) = {'Single contrast'}; 
conditions(length(y)/3+1:2*length(y)/3) = {'Three contrasts'}; 
conditions(2*length(y)/3+1:length(y)) = {'All contrasts'};
p_anova = anovan(y, {conditions; subjects}, 'random',2, 'varnames',{'Condition';'Subjects'}, 'display','off');
p_anova = p_anova(1);

% Paired t-tests
[~, p_ttests(1), ~, stats(1)] = ttest(data(:,1), data(:,3));
[~, p_ttests(2), ~, stats(2)] = ttest(data(:,1), data(:,2));
[~, p_ttests(3), ~, stats(3)] = ttest(data(:,2), data(:,3));

% Compile p values and effect sizes (Cohen's d)
p_ttests=p_ttests';
effect_sizes(1) = mean(data(:,3)-data(:,1))/stats(1).sd;
effect_sizes(2) = mean(data(:,2)-data(:,1))/stats(2).sd;
effect_sizes(3) = mean(data(:,3)-data(:,2))/stats(3).sd;