%% load
        clear;clc
    load data/Scen2_default_sim
 %% Making figure (using myplot_CI)
figure
subplot(2,1,1)
        mytexts = [];
        mystyle = [];
        mystyle.limcolor =mycolor(4,'gray'); 
        mystyle.limwidth = 5;
        mystyle.midcolor = mycolor(1);% = mycolor(2,:);
        mystyle.midsize = 6 ;
        mytexts.title ='Top-Down effects';
        mytexts.ylabel = 'R_T_D';
%%%%%%%%%%%%%%
% myplot_CI(TDBUsim.real(1,:), TDBUsim.ciTD, TDBUsim.medTD,4,mytexts, mystyle)
myplot_CI((-1) * TDBUsim.real(1,:), (-1) *TDBUsim.ciTD, (-1) *TDBUsim.medTD, 4, mytexts, mystyle)
%% 
 subplot(2,1,2)
        mytexts=[];
        mytexts.title ='Bottom-Up effects';
        mytexts.ylabel = 'R_B_U';
        mytexts.xlabel = 'Spatial Scale (number of plants)';
        mytexts.xmark = {'1','3','9','27'};
%%%%%%%%%%%%%%
myplot_CI(TDBUsim.real(2,:),TDBUsim.ciBU,TDBUsim.medBU,4,mytexts, mystyle)
%%%%%%%%%%%%%%