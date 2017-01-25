
clear;clc
load TDBU_expData
%% overall (81 plant) temporal trend
subplot(6,1,2:5) 
[Hax,H1,H2] = plotyy(dayID, sum(aphid), dayID, sum(ladybug),'plot','plot' ); hold on
    set(H1,'linestyle','none','Marker','o','Color',mycolor(3),'Markerfacecolor',mycolor(3))
    set(H2,'linestyle','none','Marker','^','color',mycolor(2),'Markerfacecolor',mycolor(2))
    set(Hax(1),'ycolor',mycolor(3), 'linewidth',2)
    set(Hax(2),'ycolor',mycolor(2),'linewidth',2)
    set(Hax,'FontSize',14)
    ylabel(Hax(1),'Aphids','fontsize',16)
    ylabel(Hax(2),'Ladybeetles','fontsize',16)
    xlabel('Time (Day)','fontsize',16)
    title('Overall (81 plant) population dynamics','fontsize',16)

    gap = setdiff(1:max(dayID),dayID);
    realgap = gap([2, diff(gap)]~=1); % "2" is the spaceholder for the first element
    for j=1:length(realgap)
        myplot([realgap(j) realgap(j)],ylim,'L', 7)
        
    end 
    
   legend([H1, H2],'Aphids','Ladybugs')