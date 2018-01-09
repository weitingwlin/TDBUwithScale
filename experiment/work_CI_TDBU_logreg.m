% Calculating species interaction indices from time series data
% Do permutations for experimental time series, calculated R_TD, R_BU, and compute CI 
load TDBU_expData 
%% iteration of permutation
%sh=10000; %  'sh' for shuffleing; real: 10,000
sh = 1000; % test
%% Permutation
tic
TDBUfull = TDBU_bootstrap_logreg(aphid, ladybug, dayID, sh, 1); % sample  with replacement
toc

%%
% save TDBUfullperm_logreg TDBUfull sh