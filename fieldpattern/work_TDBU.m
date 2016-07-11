% Tp set up path: open work_setup.m and run
clear;clc
%% load data
load ./data/FieldData
work_ladybug

%%  1) ladybugs can strongly suppress aphids in a single patch, 
% make the figure 
figure;
subplot(2,1,1)
        dfA = diff(Amat13, 1, 2); % change in Aphid 
        %      dfA(mv_avrg(Amat13) == 0) = NaN; % remove points where 
        mvL = mv_avrg(Lmat13); % moving average of Ladybug
        mvLL = mv_avrg(LLmat13);
         
        % [h, R, P] = myplot_ls(mvL(:) , dfA(:),8,3); hold on
        h2 = myplot_ls(mvLL(:) , dfA(:), [] , 1, 1);
           %     title('Effect of ladybugs on aphids (at patch scale)')
                xlabel('Ladybug population (3 taxa)')
                ylabel('Aphid population change')
 
        [Bs, R, P] = nanls(mvLL(:) , dfA(:))

 %% 2) 
 %figure
 subplot(2,1,2)
        dfLL = diff(LLmat13, 1, 2); % change in all ladybug
        %      dfA(mv_avrg(Amat13) == 0) = NaN; % remove points where 
        mvA = mv_avrg(Amat13); % moving average of Ladybug

         
        % [h, R, P] = myplot_ls(mvL(:) , dfA(:),8,3); hold on
        h2 = myplot_ls(mvA(:) , dfLL(:), [] , 1, 1);
             %   title('Effect of ladybugs on aphids (at patch scale)')
                xlabel('Aphid population ')
                ylabel('Ladybug population change')
 
        [Bs, R, P] = nanls(mvA(:) , dfLL(:))