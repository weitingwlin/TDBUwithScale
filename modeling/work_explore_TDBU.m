% Work file for explore simulated data, making plots
% each spatial scales.
clear; clc
% laptop, school
cd 'C:\Users\ASUS\Dropbox\PhD_projects\TDBU\modeling'
%% Load data 
%load .\Data\sim_TDBU_dispersal
 load .\Data\sim_TDBU_test
% simulation result from run_iva_5_withBDofP.m
%%
gap = setdiff(1:max(sim_D),sim_D);
Lplot = length(sim_D);
if length(sim_D) > 100
Lplot = 100;
end
%% visualize result
Demo=[1 2 3];
Demo = [4 5 6]
Demo=[10 11 12];
%%
figure
for i=1:3
 subplot(4,1,i)   
 % plot
 p=Demo(i);% patch id
 title(['Patch ' num2str(p)])
myplot(sim_D(1:Lplot),sim_A(p,1:Lplot),'S',2); hold on
myplot(sim_D(1:Lplot),sim_L(p,1:Lplot)*5,'S',3)
    for j=1:length(gap)
        myplot([gap(j) gap(j)],ylim,'L', 7)
    end 
end

subplot(4,1,4)
title('patch 1~3')
myplot(sim_D(1:Lplot),sum(sim_A(Demo,1:Lplot)),'S',2); hold on
myplot(sim_D(1:Lplot),sum(sim_L(Demo,1:Lplot)*5),'S',3)
legend('Aphid','Ladybug')
for j=1:length(gap)
        myplot([gap(j) gap(j)],ylim,'L', 7)
end 
%% Some basic data to compare with model
% mean occupency rate
A = mean(sum(sim_A>0));
B = mean(sum(sim_L>0));
C = mean(mean(sim_A(sim_A>0)));

disp(['occupency of aphids ', num2str(A)])
disp(['occupency of ladybugs ', num2str(B)])
disp(['mean population of aphids ', num2str(C)])

%%
figure
subplot(3,1,1)
title('patch 10~18')
myplot(sim_D(1:50),sum(sim_A(10:18,1:50)),'S',2); hold on
myplot(sim_D(1:50),sum(sim_L(10:18,1:50)),'S',3)
subplot(3,1,2)
title('patch 1~27')
myplot(sim_D(1:50),sum(sim_A(1:27,1:50)),'S',2); hold on
myplot(sim_D(1:50),sum(sim_L(1:27,1:50)),'S',3)
subplot(3,1,3)
title('All patches')
myplot(sim_D(1:50),sum(sim_A(1:81,1:50)),'S',2); hold on
myplot(sim_D(1:50),sum(sim_L(1:81,1:50)),'S',3)