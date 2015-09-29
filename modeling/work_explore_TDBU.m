% Work file for explore simulated data, making plots
% each spatial scales.

clear; clc
% pc
cd 'C:\Users\ASUS\Dropbox\PhD_projects\TDBU\modeling'
%% Load data 
% simulation result from run_iva_5.m 
load .\Data\sim_TDBU_disper_6
% simulation result from run_iva_5_withBDofP.m
%%
gap = setdiff(1:max(sim_D),sim_D);
%% visualize result
Demo=[1 2 3];
Demo=[10 11 12];
for i=1:3
 subplot(4,1,i)   
 % plot
 p=Demo(i);% patch id
 title(['Patch ' num2str(p)])
myplot(sim_D(1:50),sim_A(p,1:50),'S',2); hold on
myplot(sim_D(1:50),sim_L(p,1:50),'S',3)
    for j=1:length(gap)
        myplot([gap(j) gap(j)],ylim,'L', 7)
    end 
end


subplot(4,1,4)
title('patch 1~3')
myplot(sim_D(1:50),sum(sim_A(1:3,1:50)),'S',2); hold on
myplot(sim_D(1:50),sum(sim_L(1:3,1:50)),'S',3)
legend('Aphid','Ladybug')
for j=1:length(gap)
        myplot([gap(j) gap(j)],ylim,'L', 7)
end 
%%
figure
subplot(3,1,1)
title('patch 10~18')
myplot(sim_D(1:50),sum(sim_A(10:18,1:50)),'S',2); hold on
myplot(sim_D(1:50),sum(sim_L(10:18,1:50))*100,'S',3)
subplot(3,1,2)
title('patch 1~27')
myplot(sim_D(1:50),sum(sim_A(1:27,1:50)),'S',2); hold on
myplot(sim_D(1:50),sum(sim_L(1:27,1:50))*100,'S',3)
subplot(3,1,3)
title('All patches')
myplot(sim_D(1:50),sum(sim_A(1:81,1:50)),'S',2); hold on
myplot(sim_D(1:50),sum(sim_L(1:81,1:50))*100,'S',3)