% Work file for proccessing simulated data, calculating TD, BU indices for
% each spatial scales.

clear; clc
work_setup % reload the path
%% Permutation setting
sh=10000; % time of permutation
%%
tic
TDBUsim = TDBU_bootstrap_logreg(sim_A, sim_L, sim_D, sh, 1); % sample  with replacement
toc
%% Making figure (using myplot_CI)
figure
subplot(2,1,1)
        mytexts=[];
        mytexts.title ='Top-Down effects';
        mytexts.ylabel = 'R';
%%%%%%%%%%%%%%
myplot_CI(TDBUsim.real(1,:), TDBUsim.ciTD, TDBUsim.medTD,4,mytexts)
%%
        %text(1, 0.18, 'RES : ','HorizontalAlignment','right','FontSize',12 )
        text(1.1, -0.4, 'RES : ','HorizontalAlignment','right','FontSize',12 )
        for i = 1:4
                res = num2str(TDBUsim.resTD(i),3);
                if (TDBUsim.resTD(i) > 1), res = ['\bf ', res]; end
            %    text(i+0.05, 0.18, res,'FontSize',12 )  
            text(i+0.05, -0.4, res,'FontSize',12 )  
        end
%%
subplot(2,1,2)
        mytexts=[];
        mytexts.title ='Bottom-Up effects';
        mytexts.ylabel = 'R';
        mytexts.xlabel = 'Spatial Scale (# of plant)';
        mytexts.xmark = {'1','3','9','27'};
%%%%%%%%%%%%%%
myplot_CI(TDBUsim.real(2,:),TDBUsim.ciBU,TDBUsim.medBU,4,mytexts)
%%%%%%%%%%%%%%
%%
text(1.1, 0.025, 'RES : ','HorizontalAlignment','right','FontSize',12 )
        for i = 1:4
                res = num2str(TDBUsim.resBU(i),3);
                if (TDBUsim.resBU(i) > 1), res = ['\bf ', res]; end
                text(i+0.05, 0.025, res,'FontSize',12 )  
        end
