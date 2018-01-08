% remake the plot so R_TD is positive for Top-down effects
%% load 
  load TDBUfullperm_logreg_slope

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
        mytexts.ylabel = {'R_T_D',''};

%%%%%%%%%%%%%%
myplot_CI((-1) * TDBUfull.real(1,:), (-1) * TDBUfull.ciTD, (-1) * TDBUfull.medTD, 4, mytexts, mystyle); hold on
%%%%%%%%%%%%%%%
         for s =1:4
    %        mytext(s, 0.35, num2str(TDBUfull.Pval(1, s)), 12, 5);
        end
       
%% 
 subplot(2,1,2)
        mytexts=[];
        mytexts.title ='Effects of aphids on ladybeetles';
        mytexts.ylabel = {'R_B_U',''};
        mytexts.xlabel = 'Spatial Scale (number of plants)';
        mytexts.xmark = {'1','3','9','27'};
%%%%%%%%%%%%%%
myplot_CI(TDBUfull.real(2,:),TDBUfull.ciBU,TDBUfull.medBU,4,mytexts, mystyle)
%%%%%%%%%%%%%%
      for s =1:4
  %          mytext(s, 0.18 , num2str(TDBUfull.Pval(2, s)), 12, 5);
       end
       