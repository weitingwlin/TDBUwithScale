clear;clc
load TDBU_expData
%% occurence of spiders
sum(sum(otherlb, 2))
sum(sum(ladybug, 2)) % 'ladybug' here is only  Cycloneda sanguinea
%% 
sh=10000; % time of permutation; 'sh' for shuffleing
%%
tic
TDBUlarva = TDBU_bootstrap_logreg( aphid, otherlb + ladybug, dayID, sh, 1); % sample  with replacement
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
        mytexts.title ='Effects of ladybeetles on aphids';
        mytexts.ylabel = 'R_T_D';
%%%%%%%%%%%%%%
myplot_CI((-1) * TDBUlarva.real(1,:), (-1) * TDBUlarva.ciTD, (-1) * TDBUlarva.medTD, 4, mytexts, mystyle)

%% 
 subplot(2,1,2)
        mytexts=[];
        mytexts.title ='Effects of aphids on ladybeetles';
        mytexts.ylabel = 'R_B_U';
        mytexts.xlabel = 'Spatial Scale (number of plant)';
        mytexts.xmark = {'1','3','9','27'};
%%%%%%%%%%%%%%
myplot_CI(TDBUlarva.real(2,:),TDBUlarva.ciBU,TDBUlarva.medBU,4,mytexts, mystyle)
%%%%%%%%%%%%%%
