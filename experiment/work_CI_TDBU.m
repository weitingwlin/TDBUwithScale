% top-down & bottom-up indices from time series
% This work_ file, do permutations from real TS, calculated TD,BU, and compute CI 


%%
sh=10000; % time of permutation; 'sh' for shuffleing

%%
tic
TDBUfull = TDBU_bootstrap(aphid, ladybug, dayID, sh, 1); % sample  with replacement
toc
%% Making figure (using myplot_CI)
figure
subplot(2,1,1)
        mytexts=[];
        mytexts.title ='Top-Down effects';
        mytexts.ylabel = 'R';
%%%%%%%%%%%%%%
myplot_CI(TDBUfull.real(1,:), TDBUfull.ciTD, TDBUfull.medTD,4,mytexts)
%%
        text(1, 0.18, 'RES : ','HorizontalAlignment','right','FontSize',12 )
        for i = 1:4
                res = num2str(TDBUfull.resTD(i),3);
                if (TDBUfull.resTD(i) > 1), res = ['\bf ', res]; end
                text(i+0.05, 0.18, res,'FontSize',12 )  
        end
%%
subplot(2,1,2)
        mytexts=[];
        mytexts.title ='Bottom-Up effects';
        mytexts.ylabel = 'R';
        mytexts.xlabel = 'Spatial Scale (# of plant)';
        mytexts.xmark = {'1','3','9','27'};
%%%%%%%%%%%%%%
myplot_CI(TDBUfull.real(2,:),TDBUfull.ciBU,TDBUfull.medBU,4,mytexts)
%%%%%%%%%%%%%%
%%
text(1, 0.15, 'RES : ','HorizontalAlignment','right','FontSize',12 )
        for i = 1:4
                res = num2str(TDBUfull.resBU(i),3);
                if (TDBUfull.resBU(i) > 1), res = ['\bf ', res]; end
                text(i+0.05, 0.15, res,'FontSize',12 )  
        end

%%
save TDBUfullperm TDBUfull sh