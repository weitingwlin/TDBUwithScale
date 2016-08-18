% Tp set up path: open work_setup.m and run
clear;clc
%% load data
load ./data2014/FieldData
script_compile2014_ladybug
%  work_turnovers2014
%%  1) ladybugs can strongly suppress aphids in a single patch, 
% make the figure 
figure;
%subplot(6,2, [2 4 6 ])
        dfA = diff(Amat14, 1, 2); % change in Aphid 
        %      dfA(mv_avrg(Amat13) == 0) = NaN; % remove points where 
        % mvL = mv_avrg(Lmat13); % moving average of Ladybug
        mvLL = mv_avrg(LLmat14); % three taxa adult only
         
        % [h, R, P] = myplot_ls(mvL(:) , dfA(:),8,3); hold on
        h2 = myplot_ls(mvLL(:) , dfA(:), [] , 1, 1);
           %     title('Effect of ladybugs on aphids (at patch scale)')
                xlabel('Ladybug population (3 taxa)')
                ylabel('Aphid population change') 
                title('Top-down effect')
            %    text(-1, 700, 'e', 'FontSize',16)
        [Bs, R, P] = nanls(mvLL(:) , dfA(:))

 %% 2) 
 figure
 %subplot(6,2, [8,10,12])
        dfLL = diff(LLmat14, 1, 2); % change in all ladybug
        %      dfA(mv_avrg(Amat13) == 0) = NaN; % remove points where 
        mvA = mv_avrg(Amat14); % moving average of Ladybug         
        % [h, R, P] = myplot_ls(mvL(:) , dfA(:),8,3); hold on
        h2 = myplot_ls(mvA(:) , dfLL(:), [] , 1, 1);
             %   title('Effect of ladybugs on aphids (at patch scale)')
                xlabel('Aphid population ')
                ylabel('Ladybug population change')
                   title('Bottom-up effect')
               %    text(-150, 7, 'a', 'FontSize',16)
        [Bs, R, P] = nanls(mvA(:) , dfLL(:))