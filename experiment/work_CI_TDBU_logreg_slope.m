% Calculating species interaction indices from time series data
% Do permutations for experimental time series, calculated R_TD, R_BU, and compute CI 
load TDBU_expData 
%% iteration of permutation
sh=10000; %  'sh' for shuffleing

%% Permutation
tic
TDBUfull = TDBU_bootstrap_logreg_slope(aphid, ladybug, dayID, sh, 1); % sample  with replacement
toc

%%
 save TDBUfullperm_logreg_slope TDBUfull sh