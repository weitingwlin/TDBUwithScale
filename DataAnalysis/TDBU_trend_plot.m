function [Hax,H1,H2] =TDBU_trend_plot(simA, simL, simDay)

subplot(8,1, 3:6) 
[Hax,H1,H2] = plotyy(simDay, sum(simA), simDay, sum(simL),'plot','plot' ); hold on
    set(H1,'linestyle','none','Marker','o','Color',mycolor(3),'Markerfacecolor',mycolor(3))
    set(H2,'linestyle','none','Marker','^','color',mycolor(2),'Markerfacecolor',mycolor(2))
    set(Hax(1),'ycolor',mycolor(3), 'linewidth',2)
    set(Hax(2),'ycolor',mycolor(2),'linewidth',2)
    set(Hax,'FontSize',14)
    ylabel(Hax(1),'Number of Aphids','fontsize',16)
    ylabel(Hax(2),'Number of Ladybeetles','fontsize',16)
    xlabel('Time (Day)','fontsize',16)
    title('Overall (81 plant) population dynamics','fontsize',16)

    gap = setdiff(1:max(simDay), simDay);
    realgap = gap([2, diff(gap)]~=1); % "2" is the spaceholder for the first element
    for j=1:length(realgap)
        myplot([realgap(j) realgap(j)],ylim,'L', 7)
        
    end 
    
   legend([H1, H2],'Aphids','Ladybeetles')