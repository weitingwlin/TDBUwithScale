% Script that do the robust analysis of TDBU empirical data

% Split the data into two subsets, on each do the analysis as in work_Ci_TDBU.m
clear;clc
% depend on Statistics and Machine Learning Toolbox
%% Split data into 2 subsets
ladybug1 = ladybug(:,1:17); ladybug2 = ladybug(:,18:end);
aphid1 = aphid(:,1:17);        aphid2 = aphid(:, 18:end);
dayID1=dayID(1:17);        dayID2=dayID(18:end);

ladybug3 = ladybug(:, 11:28); %ladybug2 = ladybug(:,18:end);
aphid3 = aphid(:,11:28);        %aphid2 = aphid(:, 18:end);
dayID3=dayID(11:28);        %dayID2=dayID(18:end);
%% Simulation
sh = 1000;
tic 
TDBU1 =   TDBU_bootstrap_logreg(aphid1, ladybug1, dayID1,sh,1);
TDBU2 = TDBU_bootstrap_logreg(aphid2, ladybug2, dayID2,sh,1);
TDBU3 = TDBU_bootstrap_logreg(aphid3, ladybug3, dayID3,sh,1);
toc
%% plot
figure
mysubplot(6,1, 0, '(t = 1~17)')
TDBU_plot(TDBU1)
%%
figure
mysubplot(6,1, 0, '(t = 11~28)')
TDBU_plot(TDBU2)
%%
figure
mysubplot(6,1, 0, '(t = 18~34)')
TDBU_plot(TDBU3)