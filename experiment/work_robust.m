% Script that do the robust analysis of TDBU empirical data

% Split the data into two subsets, on each do the analysis as in work_Ci_TDBU.m
clear;clc
% depend on Statistics and Machine Learning Toolbox

%% Split data into 2 subsets
ladybug1 = ladybug(:,1:17); ladybug2 = ladybug(:,18:end);
aphid1 = aphid(:,1:17);        aphid2 = aphid(:, 18:end);
dayID1=dayID(1:17);        dayID2=dayID(18:end);
%% Simulation
sh = 1000;
tic 
TDBU1 =   TDBU_bootstrap(aphid1, ladybug1, dayID1,sh,1);
TDBU2 = TDBU_bootstrap(aphid2, ladybug2, dayID2,sh,1);
toc
%% plot
figure
subplot(2,1,1)
        mytexts=[];
        mytexts.title ='Top-down effects (set1)';
        mytexts.ylabel = 'R';
myplot_CI(TDBU1.real(1,:), TDBU1.ciTD,TDBU1.medTD, 4, mytexts)
        text(1, 0.3, 'RES : ','HorizontalAlignment','right','FontSize',12 )
        for i = 1:4
                res = num2str(TDBU1.resTD(i),3);
                if (TDBU1.resTD(i) > 1), res = ['\bf ', res]; end
                text(i+0.05, 0.3, res,'FontSize',12 )  
        end
subplot(2,1,2)
        mytexts=[];
        mytexts.title ='Bottom-Up effects (set1)';
        mytexts.ylabel = 'R';
        mytexts.xlabel = 'Spatial Scale (# of plant)';
        mytexts.xmark = {'1','3','9','27'};
myplot_CI(TDBU1.real(2,:),  TDBU1.ciBU, TDBU1.medBU, 4, mytexts)
        text(1, 0.15, 'RES : ','HorizontalAlignment','right','FontSize',12 )
        for i = 1:4
                res = num2str(TDBU1.resBU(i),3);
                if (TDBU1.resBU(i) > 1), res = ['\bf ', res]; end
                text(i+0.05, 0.15, res,'FontSize',12 )  
        end
%%
figure
subplot(2,1,1)
        mytexts = [];
        mytexts.title ='Top-down effects (set2)';
        mytexts.ylabel = 'R';
myplot_CI(TDBU2.real(1,:), TDBU2.ciTD,TDBU2.medTD,4,mytexts)
        text(1, 0.3, 'RES : ','HorizontalAlignment','right','FontSize',12 )
        for i = 1:4
                res = num2str(TDBU2.resTD(i),3);
                if (TDBU2.resTD(i) > 1), res = ['\bf ', res]; end
                text(i+0.05, 0.3, res,'FontSize',12 )  
        end
subplot(2,1,2)
        mytexts = [];
        mytexts.title = 'Bottom-Up effects (set2)';
        mytexts.ylabel = 'R';
        mytexts.xlabel = 'Spatial Scale (# of plant)';
        mytexts.xmark = {'1','3','9','27'};
myplot_CI(TDBU2.real(2,:), TDBU2.ciBU, TDBU2.medBU,4,mytexts)
        text(1, 0.18, 'RES : ','HorizontalAlignment','right','FontSize',12 )
        for i = 1:4
                res = num2str(TDBU2.resBU(i),3);
                if (TDBU2.resBU(i) > 1), res = ['\bf ', res]; end
                text(i+0.05, 0.18, res,'FontSize',12 )  
        end
