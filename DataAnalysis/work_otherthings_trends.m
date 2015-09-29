% Calculate CV for the ladybug aphid data across scales
% Wei-Ting Lin 2015/4/14
% This work_ file, plot the overall trend
clear;clc
  cd 'C:\Users\ASUS\Desktop\Weiting Brain_brain\Files\CFC26219-6EB2-83FC-A81F-64377771BF19'
      % Laptop 
%cd 'C:\Users\Wei-Ting\Desktop\Weiting Brain_brain\Files\CFC26219-6EB2-83FC-A81F-64377771BF19'
      % Desktop PC

      work_compile
script_mycolorplate
%%
figure
  subplot(2,1,1)
[Hax,H1,H2]=plotyy(day, sum(aphid), day, sum(ladybug) )
  set(H1,'Linestyle','o','color',mycolor(3,:),'Markerfacecolor',mycolor(3,:))
  set(H2,'Linestyle','o','color',mycolor(2,:),'Markerfacecolor',mycolor(2,:))
  set(Hax(1),'ycolor',mycolor(3,:), 'linewidth',2)
   set(Hax(2),'ycolor',mycolor(2,:),'linewidth',2)
   set(Hax,'FontSize',14)
    ylabel(Hax(1),'Aphids','fontsize',16)
    ylabel(Hax(2),'Ladybug','fontsize',16)
    xlabel('Time (Day)','fontsize',16)
    title('Overal Population dynamics (all 81 plants)','fontsize',16)