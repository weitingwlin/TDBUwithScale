% Tp set up path: open work_setup.m and run
clear;clc
%% load data
load data/ladybugaphid2014
%% Calculate population growth rate and moving average
    dfA = nan(38, 19);
    dfLL = nan(38, 19);
    for d = 1:19
            for p = 1:38
                    dfA( p, d ) = log( Amat14( p, d + 1 ) + 1 ) - log( Amat14( p, d ) + 1 );
                    dfLL( p, d ) = log( LLmat14( p, d + 1 ) + 1 ) - log( LLmat14( p, d ) + 1 ); % 3 taxa; adults and larva
                    %  data was prepared in [script_compile2014_ladybug.m]
            end
    end
% moving average
    mvLL = mv_avrg(LLmat14); % three taxa adult only
    mvA = mv_avrg(Amat14); % moving average of Ladybug     
%% remove data points where both aphids and ladybugs were not present at all
       keep = any([mvLL(:) mvA(:)], 2) ;
       % make a table
       T =  array2table([mvLL(keep) mvA(keep) dfLL(keep) dfA(keep)], ...
                                    'VariableNames', {'mean_L', 'mean_A', 'log_delta_L', 'log_delta_A'});
%% The effect of Aphids on itself was not significant
        mdl = fitlm(T, 'log_delta_A ~ mean_L + mean_A');
        scatter(T.mean_A,  T.log_delta_A, 40, T.mean_L,'filled');
        colormap('gray')
        cb = colorbar;
        ylabel(cb, 'mean ladybeetle population', 'fontsize', 14)
        xlabel('mean aphid population', 'fontsize', 14)
        ylabel({ 'Aphid population change rate' , '(log ratio per 3-day interval' } , 'FontSize',14)
%%  1) ladybugs can strongly suppress aphids in a single patch, 
% make the figure 
%figure;
mysubplot(6,2, [2 4  6], '', 0.8,0.3)
       T =  array2table([mvLL(keep) dfA(keep)], 'VariableNames', {'X','Y'});
        jittered_X = T.X + (rand(size(T.X)) * 0.1 - 0.1/2);
        scatter( jittered_X , T.Y, 60, 'filled', ...
                       'Markeredgecolor','none','Markerfacecolor','k', 'Markerfacealpha',0.5);
                   set(gca,'FontSize',14,'linewidth',2);
                   hold on
                   xlim([-0.05 4.05])
        mdl = fitlm(T, 'Y ~ X');
        yhat = predict(mdl, [0:max(T.X)]');
        myplot([0:max(T.X)], yhat, 'L', 1);
        mytext(1, 5, modelString(mdl), 14, 7);
        mytext(1, 4, pstring(coefTest(mdl)), 14, 7)
        %[h2, R, P] = myplot_ls(mvLL(keep) , dfA(keep), [] , 1, 1);
           %     title('Effect of ladybugs on aphids (at patch scale)')
                xlabel( 'Ladybeetle population' )
                ylabel({ 'Aphid population change rate' , '(log ratio per 3-day interval)' } , 'FontSize',14) 
               % title( 'Top-down effect' )
                text(-0.5, 6.2, 'c', 'FontSize',18, 'FontWeight', 'bold')
                % [regTD, m, b] = regression(mvLL(:)' , dfA(:)');                   
                %  [Bs, R, P] = nanls(mvLL(:) , dfA(:))

 %% 2) 
% figure
 mysubplot(6,2, [8,10,12], '', 0.8,0.3)
        T =  array2table([mvA(keep) dfLL(keep)], 'VariableNames', {'X','Y'});
        jittered_Y = T.Y + (rand(size(T.Y)) * 0.05 - 0.05/2);
        scatter( T.X , jittered_Y, 60, 'filled', ...
                       'Markeredgecolor','none','Markerfacecolor','k', 'Markerfacealpha',0.5);
                   set(gca,'FontSize',14,'linewidth',2);
                   hold on
                   xlim([0 800])
        mdl = fitlm(T, 'Y ~ X');
        yhat = predict(mdl, [0:max(T.X)]');
        myplot([0:max(T.X)], yhat, 'L', 1);
        mytext(200, 2, modelString(mdl), 14, 7);
        mytext(200, 1.6, pstring(coefTest(mdl)), 14, 7)
     %   h2 = myplot_ls(mvA(:) , dfLL(:), [] , 1, 1);
             %   title('Effect of ladybugs on aphids (at patch scale)')
                xlabel('Aphid population ')
                ylabel({'Ladybeetle population change rate', ' (log ratio per 3-day interval)'}, 'FontSize',14)
                   % title('Bottom-up effect')
                   text(-100, 2.5, 'd', 'FontSize',18, 'FontWeight', 'bold')
