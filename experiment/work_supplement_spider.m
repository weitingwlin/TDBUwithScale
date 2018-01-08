
clear;clc
load TDBU_expData
%% occurence of spiders
sum(sum(spider, 2))
sum(sum(ladybug, 2))
%% 
sh=10000; % time of permutation; 'sh' for shuffleing
%%
tic
TDBUspider = TDBU_bootstrap_logreg( aphid, spider + ladybug, dayID, sh, 1); % sample  with replacement
toc
%%
figure
subplot(2,1,1)
        mytexts = [];
        mystyle = [];
        mystyle.limcolor =mycolor(4,'gray'); 
        mystyle.limwidth = 5;
        mystyle.midcolor = mycolor(1);% = mycolor(2,:);
        mystyle.midsize = 6 ;
        mytexts.title ='Effects of predators (ladybeetles and spiders) on aphids';
        mytexts.ylabel = 'R_T_D';
%%%%%%%%%%%%%%
myplot_CI((-1) * TDBUspider.real(1,:), (-1) * TDBUspider.ciTD, (-1) * TDBUspider.medTD, 4, mytexts, mystyle)

%% 
 subplot(2,1,2)
        mytexts=[];
        mytexts.title ='Effects of aphids on predators';
        mytexts.ylabel = 'R_B_U';
        mytexts.xlabel = 'Spatial Scale (number of plant)';
        mytexts.xmark = {'1','3','9','27'};
%%%%%%%%%%%%%%
myplot_CI(TDBUspider.real(2,:),TDBUspider.ciBU,TDBUspider.medBU,4,mytexts, mystyle)
%%%%%%%%%%%%%%
