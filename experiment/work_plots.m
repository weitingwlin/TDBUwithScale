% re-make the figures

%% load 
 load TDBUfullperm
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
myplot_CI(TDBUfull.real(1,:), TDBUfull.ciTD, TDBUfull.medTD,4,mytexts, mystyle)
%% 
 subplot(2,1,2)
        mytexts=[];
        mytexts.title ='Bottom-Up effects';
        mytexts.ylabel = 'R_B_U';
        mytexts.xlabel = 'Spatial Scale (number of plant)';
        mytexts.xmark = {'1','3','9','27'};
%%%%%%%%%%%%%%
myplot_CI(TDBUfull.real(2,:),TDBUfull.ciBU,TDBUfull.medBU,4,mytexts, mystyle)
%%%%%%%%%%%%%%