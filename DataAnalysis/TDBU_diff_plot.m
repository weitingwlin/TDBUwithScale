function TDBU_diff_plot(data)

mysubplot(3,1,1)
        mytexts = [];
        mystyle = [];
        mystyle.limcolor =mycolor(4,'gray'); 
        mystyle.limwidth = 5;
        mystyle.midcolor = mycolor(1);% = mycolor(2,:);
        mystyle.midsize = 6 ;
         mytexts.title ='Effects of ladybeetles on aphids';
        mytexts.ylabel = {'Differences',' in R_T_D'};

%%%%%%%%%%%%%%
myplot_CI(data.Diff.realTDdiff, data.Diff.ciTDdiff, data.Diff.medTDdiff, 4, mytexts, mystyle); hold on
%%%%%%%%%%%%%%%
       
%
 mysubplot(3,1,2)
        mytexts=[];
        mytexts.title ='Effects of aphids on ladybeetles';
        mytexts.ylabel = {'Differences ','in R_B_U'};
        mytexts.xlabel = 'Spatial Scales';
        mytexts.xmark = {'1-3','1-9','1-27','3-9', '3-27', '9-27'};
%%%%%%%%%%%%%%
myplot_CI(data.Diff.realBUdiff, data.Diff.ciBUdiff, data.Diff.medBUdiff, 4, mytexts, mystyle); hold on
%%%%%%%%%%%%%%
 mysubplot(3,1,3)
text(0.1,2,['p (TD):  ', num2str(data.Diff.pvalTDdiff)]);
text(0.1,1, ['p (BU):  ', num2str(data.Diff.pvalBUdiff)]);
text(0.1,2.5, 'Y-axis: larger value means the effect is stronger at the smaller scale');
axis([0, 2, 0, 3])