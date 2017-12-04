% Work file for explore simulated data, making plots
% each spatial scales.
clear; clc

%% Load data 
% load ([datapath 'sim_TDBU_scen1.mat'])

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
if length(gap) <= 100
            figure
            for i=1:3
                    subplot(4,1,i)   
                % plot
                    p=Demo(i);% patch id
                    title(['Patch ' num2str(p)])
                    myplot(sim_D(1:Lplot),sim_A(p,1:Lplot),'S',2); hold on
                    myplot(sim_D(1:Lplot),sim_L(p,1:Lplot)*5,'S',3);
                    for j=1:length(gap)
                            myplot([gap(j) gap(j)],ylim,'L', 7);
                    end 
            end
            subplot(4,1,4)
                    title('patch 1~3')
                    myplot(sim_D(1:Lplot),sum(sim_A(Demo,1:Lplot)),'S',2); hold on
                    myplot(sim_D(1:Lplot),sum(sim_L(Demo,1:Lplot)*5),'S',3);
                    legend('Aphid','Ladybug')
            for j=1:length(gap)
                    myplot([gap(j) gap(j)],ylim,'L', 7);
            end
else 
            warning('simulation too big')
end
%% Some basic data to compare with model
% mean occupency rate
A = mean(sum(simA>0));
B = mean(sum(simL>0));
C = mean(mean(simA(sim_A>0)));
disp(['occupency of aphids ', num2str(A)])
disp(['occupency of ladybugs ', num2str(B)])
disp(['mean population of aphids ', num2str(C)])

%% very quick bootstrap
sh=100; % time of permutation; 'sh' for shuffleing
tic
TDBUsim = TDBU_bootstrap_logreg(simA, simL, simD, sh, 1); % sample  with replacement
toc
% expect end 3/1 1:am
%% Making figure (using myplot_CI)
figure
subplot(5,1,[1 2])
       mytexts = [];
        mystyle = [];
        mystyle.limcolor =mycolor(4,'gray'); 
        mystyle.midcolor = mycolor(1);% = mycolor(2,:);
        mystyle.midsize = 6 ;
         mytexts.title ='Effects of ladybeetles on aphids';
        mytexts.ylabel = 'R_T_D';
%%%%%%%%%%%%%%
myplot_CI((-1) * TDBUsim.real(1,:), (-1) * TDBUsim.ciTD, (-1) * TDBUsim.medTD, 4, mytexts, mystyle)

%%%%%%%%%%%%%%
subplot(5, 1, [3 4])
mytexts=[];
        mytexts.title ='Effects of aphids on ladybeetles';
        mytexts.ylabel = 'R_B_U';
        mytexts.xmark = {'1','3','9','27'};
%%%%%%%%%%%%%%
myplot_CI(TDBUsim.real(2,:),TDBUsim.ciBU,TDBUsim.medBU,4,mytexts, mystyle)
%%%%%%%%%%%%%%
subplot(5, 1, 5)
script_Gillespie_parameters
text(0.1,1, ['cP = ' num2str(cP)  ';        dPz = ' num2str(dPz) ';      dP + dPz = ' num2str( dP + dPz)  ' H_thP = ' num2str(H_thP )] );
text(0.1,0.7, ['aP = ' num2str(aP) ';     eP = ' num2str(eP) ';   exitp = ' num2str(exitP) '   B = ' num2str(B)])
text(0.1, 0.3, ['BDofP = ' num2str(withBDofP) ' ;   t = ' num2str(ts(1)) ' ~ ' num2str(ts(10))] )
text(0.1, 0, note)
%text(0.1, 0, ['initial = ' num2str(ittInit) ';    sh = ' num2str(sh)] )
axis off
box off

%print('C:\Users\Wei-Ting\Desktop\test2', '-dpng')
%%
figure
subplot(3,1,1)
title('patch 10~18')
myplot(sim_D(1:50),sum(sim_A(10:18,1:50)),'S',2); hold on
myplot(sim_D(1:50),sum(sim_L(10:18,1:50))*20,'S',3)
subplot(3,1,2)
title('patch 1~27')
myplot(sim_D(1:50),sum(sim_A(1:27,1:50)),'S',2); hold on
myplot(sim_D(1:50),sum(sim_L(1:27,1:50))*20,'S',3)
subplot(3,1,3)
title('All patches')
myplot(sim_D(1:50),sum(sim_A(1:81,1:50)),'S',2); hold on
myplot(sim_D(1:50),sum(sim_L(1:81,1:50))*20,'S',3)