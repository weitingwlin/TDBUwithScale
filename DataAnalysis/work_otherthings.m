% top-down & bottom-up indices from time series
% This work_ file, do permutations from real TS, calculated TD,BU, and compute CI 
clear;clc
%% pc, home
cd 'C:\Users\Wei-Ting\Dropbox\PhD_projects\TDBU\DataAnalysis'

load TDBU_expData
addpath('C:\Users\Wei-Ting\Dropbox\PhD_projects\TDBU\SharedAnalysis')
%% laptop, school
cd 'C:\Users\ASUS\Dropbox\PhD_projects\TDBU\DataAnalysis'

load TDBU_expData
addpath('C:\Users\ASUS\Dropbox\PhD_projects\TDBU\SharedAnalysis')
%%
te = 1; %temporal data point
ti = 1;
Ht =[];% number of aphid correspond to dHt
dHt = []; % change in number of aphids
for d = 1:D-1
    if day(d+1)-day(d)==1 % find 2 consecutive days
      
        for i=1:81 % for each patch
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              % patch leaving
            if ladybug(i,d) > 0 && ladybug(i,d+1)-ladybug(i,d) <= 0
                em(te,:) = [d,i, aphid(i,d) ladybug(i,d+1)-ladybug(i,d)];% [day patch -1]
                   te = te+1;                     % -1: LEAVE 0: not leave 
                   if (ladybug(i,d+1)-ladybug(i,d)) ==-2
                      em(te-1,:)=[d,i, aphid(i,d), -1];
                       em(te,:) =   em(te-1,:);
                        te = te+1;        
                   end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   % patch settling
              if ladybug(i,d+1) > 0 && ladybug(i,d+1)-ladybug(i,d) >= 0
                imm(ti,:) = [d,i,aphid(i,d), ladybug(i,d+1)-ladybug(i,d)];
                  ti = ti+1;
                    if (ladybug(i,d+1)-ladybug(i,d)) ==2
                        imm(ti-1,:)= [d,i,aphid(i,d), 1];
                       imm(ti,:) =   imm(ti-1,:);
                        ti = ti+1;        
                   end
              end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % aphid random mortality and colonization rate
            if ladybug(i,d+1)+ladybug(i,d) == 0 % only use data from where ladybug were absence
            Ht=[Ht aphid(i,d)];
            dHt=[dHt aphid(i,d+1)-aphid(i,d)];
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end % for i

    end    % if   
  
end % for d
%%
% em: each row for each event [day patch aphids ladybug_leaving]
%               ladybug_leaving is 0 or 1
 %%
emL=em(:,4);
emA=log(em(:,3)+1);
immL=imm(:,4);
immA=imm(:,3);
%% logistic regression
% fit the glm model
Bs=glmfit(emA,[-1*emL ones(length(emL),1)],'binomial', 'link','logit')

  % the line for logistic function
    X = [0: 0.05:7];
    Z = Logit(Bs(1)+Bs(2)*X);
  % estimated Aphid level for 50% emigration rate
    A_50 = (r_Logit(0.5)-Bs(1))/Bs(2);
    eA_50 = exp(A_50)-1; % reverse the log transformation

myplot(X,Z,'L',1); hold on
myplot(emA,-1*emL,'S')
    ylim([-0.05 1.05])
myplot([A_50 A_50], [-0.05,0.5],'L',17)
myplot([0 A_50], [0.5 0.5],'L',17)
        text(4.5,0.55,['H_5_0 = ' num2str(eA_50)])
        xlabel('log(H+1)', 'fontsize',16)
        ylabel('ladybugs emigration','fontsize',16)

%% example for some TS data
figure
    Xdata = aphid(19:21,:);

    subplot(5,1,1)
        plot(day,Xdata(1,:),'o','color',mycolor(3,:),'Markerfacecolor',mycolor(3,:))
         set(gca,'FontSize',14,'linewidth',2)
    subplot(5,1,2)
        plot(day,Xdata(2,:),'o','color',mycolor(3,:),'Markerfacecolor',mycolor(3,:))
               set(gca,'FontSize',14,'linewidth',2)             
    subplot(5,1,3)
        plot(day,Xdata(3,:),'o','color',mycolor(3,:),'Markerfacecolor',mycolor(3,:))
                 set(gca,'FontSize',14,'linewidth',2)
                   xlabel('Time (Day)','fontsize',14)

    subplot(5,1,4:5)
        plot(day,sum(Xdata),'o','color',mycolor(3,:),'Markerfacecolor',mycolor(3,:))
                 set(gca,'FontSize',14,'linewidth',2)
                   xlabel('Time (Day)','fontsize',14)
        
%% example of a TS 
  figure
  subplot(2,1,1)
  Xind=10:18;
  [Hax,H1,H2]=plotyy(day, sum(aphid(Xind,:)), day, sum(ladybug(Xind,:)) )
  set(H1,'Linestyle','o','color',mycolor(3,:),'Markerfacecolor',mycolor(3,:))
  set(H2,'Linestyle','o','color',mycolor(2,:),'Markerfacecolor',mycolor(2,:))
  set(Hax(1),'ycolor',mycolor(3,:), 'linewidth',2)
   set(Hax(2),'ycolor',mycolor(2,:),'linewidth',2)
   set(Hax,'FontSize',14)
    ylabel(Hax(1),'Aphids','fontsize',16)
    ylabel(Hax(2),'Ladybug','fontsize',16)
    xlabel('Time (Day)','fontsize',16)
    title('Population dynamics of plant 10~18','fontsize',16)
  
%%  Effect of spider
TDBUspiderA=TDBU_scale(aphid, spider,day)
% out:[TD_1 TD_3 TD_9 TD_27]
%     [BU_1 BU_3 BU_9 BU_27]
TDBUspiderL=TDBU_scale(ladybug, spider,day)
% out:[TD_1 TD_3 TD_9 TD_27]
%     [BU_1 BU_3 BU_9 BU_27]
TDBU=TDBU_scale(aphid, ladybug,day)

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
LB_LV = ladybug + (larva>0);
LB_OT = ladybug + otherlb;
LB_LVOT = ladybug + (larva>0) +otherlb;

TDBU_LV=TDBU_scale(aphid, LB_LV,day);
TDBU_OT=TDBU_scale(aphid, LB_OT,day);
TDBU_LVOT=TDBU_scale(aphid, LB_LVOT,day);
TDBU=TDBU_scale(aphid, ladybug,day);
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
%%

%%
Ht =[];% number of aphid correspond to dHt
dHt = []; % change in number of aphids
for d = 1:D-1
    if day(d+1)-day(d)==1 % find 2 consecutive days   
        for i=1:81 % for each patch
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % aphid random mortality and colonization rate
            if ladybug(i,d+1)+ladybug(i,d) == 0 % only use data from where ladybug were absence
            Ht=[Ht aphid(i,d)];
            dHt=[dHt aphid(i,d+1)-aphid(i,d)];
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end % for i
    end    % if    
end % for d
%%


