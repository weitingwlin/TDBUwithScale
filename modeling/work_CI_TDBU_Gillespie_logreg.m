
clear; clc
work_setup % reload the path
%  load sim_scen1_Gillespie
%load sim_scen1_newnew
%% Permutation setting
sh=10000; % time of permutation
%%
tic
TDBUsim = TDBU_bootstrap_logreg(simA, simL, simD, sh, 1); % sample  with replacement
toc
save sim_scen2_perm
%%
