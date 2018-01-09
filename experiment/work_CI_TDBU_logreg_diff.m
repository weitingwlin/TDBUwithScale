% Calculating species interaction indices from time series data
% Do permutations for experimental time series, calculated R_TD, R_BU, and compute CI 
load TDBU_expData 
%% iteration of permutation
%sh=10000; %  'sh' for shuffleing; real: 10,000
sh = 10000; % test
%% Permutation
tic
TDBUfull = TDBU_bootstrap_logreg_diff(aphid, ladybug, dayID, sh, 1); % sample  with replacement
toc

%%
% save TDBUfullperm_logreg TDBUfull sh
TDBU_plot(TDBUfull)
%%
figure
subplot(3,1,1)
        mytexts = [];
        mystyle = [];
        mystyle.limcolor =mycolor(4,'gray'); 
        mystyle.limwidth = 5;
        mystyle.midcolor = mycolor(1);% = mycolor(2,:);
        mystyle.midsize = 6 ;
         mytexts.title ='Effects of ladybeetles on aphids';
        mytexts.ylabel = {'Differences',' in R_T_D'};

%%%%%%%%%%%%%%
myplot_CI(TDBUfull.Diff.realTDdiff, TDBUfull.Diff.ciTDdiff, TDBUfull.Diff.medTDdiff, 4, mytexts, mystyle); hold on
%%%%%%%%%%%%%%%
       
%
 subplot(3,1,2)
        mytexts=[];
        mytexts.title ='Effects of aphids on ladybeetles';
        mytexts.ylabel = {'Differences ','in R_B_U'};
        mytexts.xlabel = 'Spatial Scales';
        mytexts.xmark = {'1-3','1-9','1-27','3-9', '3-27', '9-27'};
%%%%%%%%%%%%%%
myplot_CI(TDBUfull.Diff.realBUdiff, TDBUfull.Diff.ciBUdiff, TDBUfull.Diff.medBUdiff, 4, mytexts, mystyle); hold on
%%%%%%%%%%%%%%
 subplot(3,1,3)
text(0.1,2,['p (TD):  ', num2str(TDBUfull.Diff.pvalTDdiff)]);
text(0.1,1, ['p (BU):  ', num2str(TDBUfull.Diff.pvalBUdiff)]);
text(0.1,2.5, 'Y-axis: larger value means the effect is stronger at the smaller scale');
axis([0, 2, 0, 3])