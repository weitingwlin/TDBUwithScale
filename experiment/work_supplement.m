% Scripts to produce supplement figures: 
% example TS, example 'scaling up', effect of spider, effect of larva and other species

clear;clc
load TDBU_expData
    
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
        TDBUspiderA =TDBU_scale(aphid, spider,dayID)
% 2. spider predator, ladybug as prey   
        TDBUspiderL =TDBU_scale(ladybug, spider,dayID)
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
%% Spider + ladybugs
TDBUSLA=TDBU_scale(aphid, spider+ladybug,dayID)
% Ladybug-aphid as reference
TDBU=TDBU_scale(aphid, ladybug,dayID)
% Making plots
subplot(2,1,1)
        myplot([1 2 3 4],TDBU(1,:),'S',1); hold on
        myplot([1 2 3 4],TDBUSLA(1,:),'S',2); 
title ('Top-down','fontsize',14)
        ylabel('R')
        legend('Ladybug <-> Aphid','(Spider+Ladybug) <-> Aphid')
        axis([0 5 -0.4 0.4])
        set(gca,'Xticklabel',{[],'1' ,'3' ,'9' ,'27',[]})

subplot(2,1,2)
        myplot([1 2 3 4],TDBU(2,:),'S',1); hold on
        myplot([1 2 3 4],TDBUSLA(2,:),'S',2); 
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
%% Eggs and Hatching
[r,c] = find(egg == 1);
% r is the patches, c is the dayID that eggs were found
PwithEgg = unique(r);
clutch = 0; % initialize
for i = 1:length(PwithEgg)
      daysEgg = c(r == PwithEgg(i));   
       clutch = clutch + 1 + sum(diff(daysEgg)>2);     
       % if eggs were found in less than 3 days at the same plant, consider they as the same clutch
end
disp(clutch) % number of clutch of egg found during the experiment
%% Hatches
% If more than one larva found within 3 day after a clutch of egg was found
[r2,c2] = find(larva >1);
% r is the patches, c is the dayID that >1 larva were found
PwithLarva = unique(r2);
hatch = 0;% to initialize
for i = 1:length(PwithLarva)
      daysLarva = sort(c2(r2 == PwithLarva(i)));   
      newLarva = daysLarva(diff( [-2 daysLarva'])>2); % -2 is an temporary initial point, so the first day would be included as a new day 
      for j=1:length(newLarva)
              if sum(egg(PwithLarva(i),  newLarva(j)-3 : newLarva(j)-1) ) > 0
                 hatch = hatch + 1 ;     
                % if clutch found within 3 days before the new larva found, sure it is new hatch
              end
      end
end
disp(hatch) % number of clutch of egg found during the experiment

%% Some basic data to compare with model
% mean occupency rate
A = mean(sum(aphid>0));
B = mean(sum(ladybug>0));
C = mean(mean(aphid(aphid>0)));

disp(['occupency of aphids ', num2str(A)])
disp(['occupency of ladybugs ', num2str(B)])
disp(['mean population of aphids ', num2str(C)])
