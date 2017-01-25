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
%%  1) ladybugs can strongly suppress aphids in a single patch, 
% make the figure 
%figure;
mysubplot(6,2, [2 4  6], '', 0.8,0.3)
        [h2, R, P] = myplot_ls(mvLL(:) , dfA(:), [] , 1, 1);
           %     title('Effect of ladybugs on aphids (at patch scale)')
                xlabel( 'Ladybeetle population' )
                ylabel({ 'Aphid population change rate' , '(log ratio per 3-day interval' } , 'FontSize',14) 
               % title( 'Top-down effect' )
                text(-0.5, 5.6, 'd', 'FontSize',18, 'FontWeight', 'bold')
                % [regTD, m, b] = regression(mvLL(:)' , dfA(:)');                   
                %  [Bs, R, P] = nanls(mvLL(:) , dfA(:))

 %% 2) 
% figure
 mysubplot(6,2, [8,10,12], '', 0.8,0.3)
        h2 = myplot_ls(mvA(:) , dfLL(:), [] , 1, 1);
             %   title('Effect of ladybugs on aphids (at patch scale)')
                xlabel('Aphid population ')
                ylabel({'Ladybeetle population change rate (log ratio)', 'per 3-day interval'}, 'FontSize',14)
                   % title('Bottom-up effect')
                   text(-130, 2.2, 'e', 'FontSize',18, 'FontWeight', 'bold')
