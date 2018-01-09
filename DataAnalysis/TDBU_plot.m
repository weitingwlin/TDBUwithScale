function TDBU_plot(data)

%figure
mysubplot(2,1,1)
        mytexts = [];
        mystyle = [];
        mystyle.limcolor =mycolor(4,'gray'); 
        mystyle.limwidth = 5;
        mystyle.midcolor = mycolor(1);% = mycolor(2,:);
        mystyle.midsize = 6 ;
         mytexts.title ='Effects of ladybeetles on aphids';
        mytexts.ylabel = {'R_T_D',''};

%%%%%%%%%%%%%%
myplot_CI((-1) * data.real(1,:), (-1) * data.ciTD, (-1) * data.medTD, 4, mytexts, mystyle); hold on
%%%%%%%%%%%%%%%
       
%% 
 mysubplot(2,1,2)
        mytexts=[];
        mytexts.title ='Effects of aphids on ladybeetles';
        mytexts.ylabel = {'R_B_U',''};
        mytexts.xlabel = 'Spatial Scale (number of plants)';
        mytexts.xmark = {'1','3','9','27'};
%%%%%%%%%%%%%%
myplot_CI(data.real(2,:), data.ciBU, data.medBU,4,mytexts, mystyle)
%%%%%%%%%%%%%%
    