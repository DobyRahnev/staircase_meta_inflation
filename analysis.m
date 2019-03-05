%analysis

clc
clear
close all

% Add helper functions
addpath(genpath(fullfile(pwd, 'helperFunctions')));

% Load data
load data/metaResults
load data/subsetsResults
load data/example_subject_contrasts
load data/contrasts_mean_SD

%% Figure 1: Example staircase (S2 in block 2)
figure; subplot(2,1,1); plot(contrasts, 1:100, '*--');
contrValNum = 0;
for contrValue=23:3:38
    contrValNum = contrValNum + 1;
    numTrialsContr(contrValNum) = sum(contrasts == contrValue);
end
subplot(2,1,2); bar(23:3:38, numTrialsContr);


%% Figure 2: Compare stimulus sensitivity (d') across the 3 conditions
disp('----------- d'' results -----------')
meta_means = [mean(dprime)]
[p_dprime(1), p_dprime(2:4)] = do_stats(dprime); %p values for ANOVA + 3 t-tests
p_dprime

% Plot Figure 2
plot_3bars(dprime, 0, 'd''', [1.2, 1.6], 0, p_dprime(2));

% Supplementary Figure 1: raincloud version of Figure 2
figure; raincloud_wrapper(dprime, 0, 'd''');


%% Figure 3: Compare metacognition estimates for 3 conditions
disp('----------- metacognition results -----------')
meta_means = [mean(type2AUC); mean(phi); mean(metad); mean(Mratio); mean(Mdiff)];
meta_means_and_diff = [meta_means, meta_means(:,3)-meta_means(:,1)]
[p(1,1), p(1,2:4), effect_size(1,:)] = do_stats(type2AUC); %p values for ANOVA + 3 t-tests
[p(2,1), p(2,2:4), effect_size(2,:)] = do_stats(phi); %p values for ANOVA + 3 t-tests
[p(3,1), p(3,2:4), effect_size(3,:)] = do_stats(metad); %p values for ANOVA + 3 t-tests
[p(4,1), p(4,2:4), effect_size(4,:)] = do_stats(Mratio); %p values for ANOVA + 3 t-tests
[p(5,1), p(5,2:4), effect_size(5,:)] = do_stats(Mdiff); %p values for ANOVA + 3 t-tests
p
effect_size

% Plot Figure 3
figure;
plotIndividualData = 0;
plot_3bars(type2AUC, 1, 'type 2 AUC', [.65, .75], plotIndividualData, p(1,2));
plot_3bars(phi, 2, 'phi', [.25, .4], plotIndividualData, p(2,2));
plot_3bars(metad, 4, 'meta-d''', [1, 1.6], plotIndividualData, p(3,2));
plot_3bars(Mratio, 5, 'meta-d''/d''', [.8, 1.2], plotIndividualData, p(4,2));
plot_3bars(Mdiff, 6, 'meta-d'' - d''', [-.4, .3], plotIndividualData, p(5,2));

% Supplementary Figure 2: raincloud version of Figure 3
figure
raincloud_wrapper(type2AUC, 1, 'type 2 AUC');
raincloud_wrapper(phi, 2, 'phi');
raincloud_wrapper(metad, 4, 'meta-d''');
raincloud_wrapper(Mratio, 5, 'meta-d''/d''');
raincloud_wrapper(Mdiff, 6, 'meta-d'' - d''');


%% Control analysis: Consider subsets of equal size as the 1-contrast conditions
disp('----------- control (subsets) results -----------')
type2AUC_subsets = [type2AUC(:,1), mean(type2AUC_subsets,3)];
phi_subsets = [phi(:,1), mean(phi_subsets,3)];
metad_subsets = [metad(:,1), mean(metad_subsets,3)];
Mratio_subsets = [Mratio(:,1), mean(Mratio_subsets,3)];
Mdiff_subsets = [Mdiff(:,1), mean(Mdiff_subsets,3)];
meta_means_subsets = [mean(type2AUC_subsets); mean(phi_subsets); mean(metad_subsets); mean(Mratio_subsets); mean(Mdiff_subsets)];
meta_means_subsets_and_diff = [meta_means_subsets, meta_means_subsets(:,3)-meta_means_subsets(:,1)]
[p(1,1), p(1,2:4)] = do_stats(type2AUC_subsets); %p values for ANOVA + 3 t-tests
[p(2,1), p(2,2:4)] = do_stats(phi_subsets); %p values for ANOVA + 3 t-tests
[p(3,1), p(3,2:4)] = do_stats(metad_subsets); %p values for ANOVA + 3 t-tests
[p(4,1), p(4,2:4)] = do_stats(Mratio_subsets); %p values for ANOVA + 3 t-tests
[p(5,1), p(5,2:4)] = do_stats(Mdiff_subsets); %p values for ANOVA + 3 t-tests
p

% Plot the Supplementary Figure 3 (equivalent to Figure 3 but for the
% subsets control analysis)
figure;
plotIndividualData = 0;
plot_3bars(type2AUC_subsets, 1, 'type 2 AUC', [.65, .75], plotIndividualData, p(1,2));
plot_3bars(phi_subsets, 2, 'phi', [.25, .4], plotIndividualData, p(2,2));
plot_3bars(metad_subsets, 4, 'meta-d''', [1, 1.6], plotIndividualData, p(3,2));
plot_3bars(Mratio_subsets, 5, 'meta-d''/d''', [.8, 1.2], plotIndividualData, p(4,2));
plot_3bars(Mdiff_subsets, 6, 'meta-d'' - d''', [-.4, .3], plotIndividualData, p(5,2));


%% Figure 4: Correlations between metacognitive inlfation and stimulus variability
disp('----------- correlation b/n meta inflation and stimulus variability -----------')
[r_incrM_normVar(1),p_incrM_normVar(1)]=corr(contrast_SD'./contrast_mean', type2AUC(:,3)-type2AUC(:,1));
[r_incrM_normVar(2),p_incrM_normVar(2)]=corr(contrast_SD'./contrast_mean', phi(:,3)-phi(:,1));
[r_incrM_normVar(3),p_incrM_normVar(3)]=corr(contrast_SD'./contrast_mean', metad(:,3)-metad(:,1));
[r_incrM_normVar(4),p_incrM_normVar(4)]=corr(contrast_SD'./contrast_mean', Mratio(:,3)-Mratio(:,1));
[r_incrM_normVar(5),p_incrM_normVar(5)]=corr(contrast_SD'./contrast_mean', Mdiff(:,3)-Mdiff(:,1));

% % Control analysis: remove possible outlier with high stimulus variability
% subj=[1:9,11:31];
% [r_M_normVar(1),p_M_normVar(1)]=corr(contrast_SD(subj)'./contrast_mean(subj)', type2AUC(subj,3)-type2AUC(subj,1));
% [r_M_normVar(2),p_M_normVar(2)]=corr(contrast_SD(subj)'./contrast_mean(subj)', phi(subj,3)-phi(subj,1));
% [r_M_normVar(3),p_M_normVar(3)]=corr(contrast_SD(subj)'./contrast_mean(subj)', metad(subj,3)-metad(subj,1));
% [r_M_normVar(4),p_M_normVar(4)]=corr(contrast_SD(subj)'./contrast_mean(subj)', Mratio(subj,3)-Mratio(subj,1));
% [r_M_normVar(5),p_M_normVar(5)]=corr(contrast_SD(subj)'./contrast_mean(subj)', Mdiff(subj,3)-Mdiff(subj,1));

r_incrM_normVar
p_incrM_normVar

% Plot figure
figure;
plot_scatterplot(contrast_SD'./contrast_mean', type2AUC(:,3)-type2AUC(:,1), 1, [.1,.25], 'stimulus variability', 'type 2 AUC')
plot_scatterplot(contrast_SD'./contrast_mean', phi(:,3)-phi(:,1), 2, [.1,.25], 'stimulus variability', 'phi')
plot_scatterplot(contrast_SD'./contrast_mean', metad(:,3)-metad(:,1), 4, [.1,.25], 'stimulus variability', 'meta-d''')
plot_scatterplot(contrast_SD'./contrast_mean', Mratio(:,3)-Mratio(:,1), 5, [.1,.25], 'stimulus variability', 'meta-d''/d''')
plot_scatterplot(contrast_SD'./contrast_mean', Mdiff(:,3)-Mdiff(:,1), 6, [.1,.25], 'stimulus variability', 'meta-d'' - d''')


%% Figure 5: Correlations between metacognition in 1C and stimulus variability
disp('----------- correlation b/n metacognition in 1C and stimulus variability -----------')
cond = 1;
[r_M_normVar(1),p_M_normVar(1)]=corr(contrast_SD'./contrast_mean', type2AUC(:,cond));
[r_M_normVar(2),p_M_normVar(2)]=corr(contrast_SD'./contrast_mean', phi(:,cond));
[r_M_normVar(3),p_M_normVar(3)]=corr(contrast_SD'./contrast_mean', metad(:,cond));
[r_M_normVar(4),p_M_normVar(4)]=corr(contrast_SD'./contrast_mean', Mratio(:,cond));
[r_M_normVar(5),p_M_normVar(5)]=corr(contrast_SD'./contrast_mean', Mdiff(:,cond));

% % Control analysis: remove possible outlier with high stimulus variability
% subj=[1:9,11:31];
% [r_M_normVar(1),p_M_normVar(1)]=corr(contrast_SD(subj)'./contrast_mean(subj)', type2AUC(subj,cond));
% [r_M_normVar(2),p_M_normVar(2)]=corr(contrast_SD(subj)'./contrast_mean(subj)', phi(subj,cond));
% [r_M_normVar(3),p_M_normVar(3)]=corr(contrast_SD(subj)'./contrast_mean(subj)', metad(subj,cond));
% [r_M_normVar(4),p_M_normVar(4)]=corr(contrast_SD(subj)'./contrast_mean(subj)', Mratio(subj,cond));
% [r_M_normVar(5),p_M_normVar(5)]=corr(contrast_SD(subj)'./contrast_mean(subj)', Mdiff(subj,cond));

r_M_normVar
p_M_normVar

% Plot figure
figure;
plot_scatterplot(contrast_SD'./contrast_mean', type2AUC(:,cond), 1, [.1,.25], 'stimulus variability', 'type 2 AUC')
plot_scatterplot(contrast_SD'./contrast_mean', phi(:,cond), 2, [.1,.25], 'stimulus variability', 'phi')
plot_scatterplot(contrast_SD'./contrast_mean', metad(:,cond), 4, [.1,.25], 'stimulus variability', 'meta-d''')
plot_scatterplot(contrast_SD'./contrast_mean', Mratio(:,cond), 5, [.1,.25], 'stimulus variability', 'meta-d''/d''')
plot_scatterplot(contrast_SD'./contrast_mean', Mdiff(:,cond), 6, [.1,.25], 'stimulus variability', 'meta-d'' - d''')


%% Discussion: Correlations between metacognition in 1C and AC conditions
disp('----------- correlation b/n metacognitive ability for the 1C and AC conditions -----------')
[r_M_normVar(1),p_M_normVar(1)]=corr(type2AUC(:,1), type2AUC(:,3));
[r_M_normVar(2),p_M_normVar(2)]=corr(phi(:,1), phi(:,3));
[r_M_normVar(3),p_M_normVar(3)]=corr(metad(:,1), metad(:,3));
[r_M_normVar(4),p_M_normVar(4)]=corr(Mratio(:,1), Mratio(:,3));
[r_M_normVar(5),p_M_normVar(5)]=corr(Mdiff(:,1), Mdiff(:,3));
r_M_normVar
p_M_normVar