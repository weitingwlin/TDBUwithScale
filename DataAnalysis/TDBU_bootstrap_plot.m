% TDBU_plot
function [h1,h2] = TDBU_bootstrap_plot(TDBUsim)

%% Making figure (using myplot_CI)
figure
subplot(2,1,1)
        mytexts=[];
        mytexts.title ='Top-Down effects';
        mytexts.ylabel = 'R';
%%%%%%%%%%%%%%
myplot_CI(TDBUsim.real(1,:), TDBUsim.ciTD, TDBUsim.medTD,4,mytexts)
%%
        temp = axis;
        RES_loci = temp(4)*0.8;
text(1, RES_loci, 'RES : ','HorizontalAlignment','right','FontSize',12 )        
        
        for i = 1:4
                res = num2str(TDBUsim.resTD(i),3);
                if (TDBUsim.resTD(i) > 1), res = ['\bf ', res]; end
                text(i, RES_loci, res,'FontSize',12 )  
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
        temp = axis;
        RES_loci = temp(4)*0.8;
text(1, RES_loci, 'RES : ','HorizontalAlignment','right','FontSize',12 )
        for i = 1:4
                res = num2str(TDBUsim.resBU(i),3);
                if (TDBUsim.resBU(i) > 1), res = ['\bf ', res]; end
                text(i, RES_loci, res,'FontSize',12 )  
        end
