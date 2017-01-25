
clear; clc
work_setup % reload the path
%  load sim_scen1_Gillespie
load sim_scen1_Gillespie
%% Permutation setting
sh=10000; % time of permutation
%%
tic
TDBUsim = TDBU_bootstrap_logreg(simA, simL, simD, sh, 1); % sample  with replacement
toc
save sim_scen1_Gillespie_perm
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
myplot_CI((-1) * TDBUsim.real(1,:), (-1) * TDBUsim.ciTD, (-1) * TDBUsim.medTD, 4, mytexts, mystyle)

%% 
 subplot(2,1,2)
        mytexts=[];
        mytexts.title ='Effects of aphids on ladybeetles';
        mytexts.ylabel = 'R_B_U';
        mytexts.xlabel = 'Spatial Scale (number of plants)';
        mytexts.xmark = {'1','3','9','27'};
%%%%%%%%%%%%%%
myplot_CI(TDBUsim.real(2,:),TDBUsim.ciBU,TDBUsim.medBU,4,mytexts, mystyle)
%%%%%%%%%%%%%%