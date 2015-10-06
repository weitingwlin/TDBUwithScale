% Scripts to produce supplement figures: 
% example TS, example 'scaling up', effect of spider, effect of larva and other species

clear;clc
%% pc, home
cd 'C:\Users\Wei-Ting\Dropbox\PhD_projects\TDBU\DataAnalysis'
load TDBU_expData
addpath('C:\Users\Wei-Ting\Dropbox\PhD_projects\TDBU\SharedAnalysis')
%% laptop, school
cd 'C:\Users\ASUS\Dropbox\PhD_projects\TDBU\DataAnalysis'
load TDBU_expData
addpath('C:\Users\ASUS\Dropbox\PhD_projects\TDBU\SharedAnalysis')

%% example for some TS data
figure
    Xdata = aphid(19:21,:);
    subplot(5,1,1)
        myplot(dayID,Xdata(1,:),'S',3)
    subplot(5,1,2)
        myplot(dayID,Xdata(2,:),'S',3)
    subplot(5,1,3)
        myplot(dayID,Xdata(3,:),'S',3)
                   xlabel('Time (Day)','fontsize',14)
    subplot(5,1,4:5)
        myplot(dayID,sum(Xdata),'S',3)
                   xlabel('Time (Day)','fontsize',14)
        
%% example of a TS 
  figure
  subplot(2,1,1)
  Xind=10:18;% patched picked for this example
  [Hax,H1,H2]=plotyy(dayID, sum(aphid(Xind,:)), dayID, sum(ladybug(Xind,:)) )
    set(H1,'Linestyle','o','color',mycolor(3),'Markerfacecolor',mycolor(3))
    set(H2,'Linestyle','o','color',mycolor(2),'Markerfacecolor',mycolor(2))
    set(Hax(1),'ycolor',mycolor(3), 'linewidth',2)
    set(Hax(2),'ycolor',mycolor(2),'linewidth',2)
    set(Hax,'FontSize',14)
    ylabel(Hax(1),'Aphids','fontsize',16)
    ylabel(Hax(2),'Ladybug','fontsize',16)
    xlabel('Time (Day)','fontsize',16)
    title('Population dynamics of plant 10~18','fontsize',16)
  
%%  Effect of spider
% There are two ways to incorporate spider into TDBU framework
% 1. spider predator, aphid as prey
        TDBUspiderA=TDBU_scale(aphid, spider,dayID)
% 2. spider predator, ladybug as prey   
        TDBUspiderL=TDBU_scale(ladybug, spider,dayID)
% Ladybug-aphid as reference
TDBU=TDBU_scale(aphid, ladybug,dayID)

% Making plots
subplot(2,1,1)
        myplot([1 2 3 4],TDBU(1,:),'S',1); hold on
        myplot([1 2 3 4],TDBUspiderL(1,:),'S',2); 
        myplot([1 2 3 4],TDBUspiderA(1,:),'S',3); 
title ('Top-down','fontsize',14)
        ylabel('R')
        legend('Ladybug-Aphid','Spider-Ladybug','Spider-Aphid')
        axis([0 5 -0.4 0.4])
        set(gca,'Xticklabel',{[],'1' ,'3' ,'9' ,'27',[]})

subplot(2,1,2)
        myplot([1 2 3 4],TDBU(2,:),'S',1); hold on
        myplot([1 2 3 4],TDBUspiderL(2,:),'S',2); 
        myplot([1 2 3 4],TDBUspiderA(2,:),'S',3); 
title ('Bottom-up','fontsize',14)
        ylabel('R')
        axis([0 5 -0.1 0.1])
        set(gca,'Xticklabel',{[],'1' ,'3' ,'9' ,'27',[]})
        xlabel('Spatial scale','fontsize',14)
%%  Effect of larva and other species
LB_LV = ladybug + (larva>0); % because of the size difference and self thinning (canibolism); a clutch of larva assumed to equal one adult
LB_OT = ladybug + otherlb; 
LB_LVOT = ladybug + (larva>0) +otherlb;

TDBU_LV=TDBU_scale(aphid, LB_LV,dayID);
TDBU_OT=TDBU_scale(aphid, LB_OT,dayID);
TDBU_LVOT=TDBU_scale(aphid, LB_LVOT,dayID);
TDBU=TDBU_scale(aphid, ladybug,dayID);
% out:[TD_1 TD_3 TD_9 TD_27]
%     [BU_1 BU_3 BU_9 BU_27]
subplot(2,1,1)
        myplot([1 2 3 4],TDBU(1,:),'S',1); hold on
        myplot([1 2 3 4],TDBU_LV(1,:),'S',2); 
        myplot([1 2 3 4],TDBU_OT(1,:),'S',3); 
        myplot([1 2 3 4],TDBU_LVOT(1,:),'S',4); 
    title ('Top-down','fontsize',14)
        ylabel('R')
    legend('LB','LB+LV','LB+other','All')
        axis([0 5 -0.5 0.3])
        set(gca,'Xticklabel',{[],'1' ,'3' ,'9' ,'27',[]})
subplot(2,1,2)
        myplot([1 2 3 4],TDBU(2,:),'S',1); hold on
        myplot([1 2 3 4],TDBU_LV(2,:),'S',2); 
        myplot([1 2 3 4],TDBU_OT(2,:),'S',3); 
        myplot([1 2 3 4],TDBU_LVOT(2,:),'S',4); 
    title ('Bottom-up','fontsize',14)
        ylabel('R')
        axis([0 5 -0.1 0.2])
        set(gca,'Xticklabel',{[],'1' ,'3' ,'9' ,'27',[]})
        xlabel('Spatial scale','fontsize',14)