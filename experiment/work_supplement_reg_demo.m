
clear;clc
load TDBU_expData
%% how to get the correlation of each scale

nd =  length(dayID)
data_L = ladybug;
data_A = aphid;
Day = dayID;
%%  calculate moving averageand (MA) and difference (DF)
[L_3, L_9, L_27, A_3, A_9, A_27] = TDBU_scale_TS(aphid, ladybug, dayID);
t = 1; %temporal data point

for d = 1:nd-1
    if Day(d+1)-Day(d)==1 % find 2 consecutive days
        %%% 1-plant
         for k=1:81
            MA_L_1(k,t) = mean(data_L(k,d:d+1));
            DF_L_1(k,t) = log( data_L(k,d+1) + 1 ) - log(data_L(k,d) + 1 );
            MA_A_1(k,t) = mean(data_A(k,d:d+1));
            DF_A_1(k,t) = log(data_A(k,d+1) + 1 ) - log(data_A(k,d) + 1);
        end
        %%%  3-plant
        for p=1:27
            MA_L_3(p,t) = mean(L_3(p,d:d+1));
            DF_L_3(p,t) = log(L_3(p,d+1) + 1) - log(L_3(p,d) + 1 );
            MA_A_3(p,t) = mean(A_3(p,d:d+1));
            DF_A_3(p,t) = log(A_3(p,d+1) + 1) - log(A_3(p,d) + 1 );
        end
        %%% 9-plant
         for q=1:9
            MA_L_9(q,t) = mean(L_9(q,d:d+1));
            DF_L_9(q,t) = log(L_9(q,d+1) + 1 ) - log(L_9(q,d) + 1 );
            MA_A_9(q,t) = mean(A_9(q,d:d+1));
            DF_A_9(q,t) = log(A_9(q,d+1) +1) - log(A_9(q,d) + 1 );
         end
        %%% 27-plant
         for r=1:3
            MA_L_27(r,t) = mean(L_27(r,d:d+1));
            DF_L_27(r,t) = log(L_27(r,d+1) + 1 ) - log(L_27(r,d) + 1 );
            MA_A_27(r,t) = mean(A_27(r,d:d+1));
            DF_A_27(r,t) = log(A_27(r,d+1) + 1 ) - log(A_27(r,d) + 1 );
         end      
        t = t+1;
    end
end
%% remove double zeros
keep1 = any([MA_A_1(:), MA_L_1(:)], 2);
keep3 = any([MA_A_3(:), MA_L_3(:)], 2);
keep9= any([MA_A_9(:), MA_L_9(:)], 2);
keep27 = any([MA_A_27(:), MA_L_27(:)], 2);
%% Top-Down, 1-plant scale
    figure
   T =  array2table([MA_L_1(keep1) DF_A_1(keep1)], 'VariableNames', {'X','Y'});
   jittered_X = T.X + (rand(size(T.X)) * 0.1 - 0.1/2);
        scatter( jittered_X , T.Y, 60, 'filled', ...
                       'Markeredgecolor','none','Markerfacecolor','k', 'Markerfacealpha',0.5);
                   set(gca,'FontSize',14,'linewidth',2);
                   hold on
                   xlim([-0.05 2.05]); ylim([-6 4])
        mdl = fitlm(T, 'Y ~ X');
        yhat = predict(mdl, [0:max(T.X)]');
        myplot([0:max(T.X)], yhat, 'L', 1);
        mytext(1, 2.7, modelString(mdl), 14, 7);
        mytext(1, 2, ['R = -' num2str(sqrt(mdl.Rsquared.ordinary),2) ], 14, 7)
       xlabel( 'Ladybeetle population' )
       ylabel({ 'Aphid population change rate' , '(log ratio)' } , 'FontSize',14) 
      % title({'Effects of ladybeetles on aphids','1-Plant scale'})
       title('1-Plant scale')
%% Top-Down, 3-plant scale
    figure
   T =  array2table([MA_L_3(keep3) DF_A_3(keep3)], 'VariableNames', {'X','Y'});
   jittered_X = T.X + (rand(size(T.X)) * 0.1 - 0.1/2);
        scatter( jittered_X , T.Y, 60, 'filled', ...
                       'Markeredgecolor','none','Markerfacecolor','k', 'Markerfacealpha',0.5);
                   set(gca,'FontSize',14,'linewidth',2);
                   hold on
                   xlim([-0.05 2.55])
        mdl = fitlm(T, 'Y ~ X');
        yhat = predict(mdl, [0:0.1:max(T.X)]');
        myplot([0:0.1:max(T.X)], yhat, 'L', 1);
        mytext(1, 3, modelString(mdl), 14, 7);
        mytext(1, 2, ['R = -' num2str(sqrt(mdl.Rsquared.ordinary),2) ], 14, 7)
       xlabel( 'Ladybeetle population' )
       ylabel({ 'Aphid population change rate' , '(log ratio)' } , 'FontSize',14) 
       %title({'Effects of ladybeetles on aphids','3-Plant scale'})
         title('3-Plant scale')
%% Top-Down, 9-plant scale
figure
   T =  array2table([MA_L_9(keep9) DF_A_9(keep9)], 'VariableNames', {'X','Y'});
   jittered_X = T.X + (rand(size(T.X)) * 0.1 - 0.1/2);
        scatter( jittered_X , T.Y, 60, 'filled', ...
                       'Markeredgecolor','none','Markerfacecolor','k', 'Markerfacealpha',0.5);
                   set(gca,'FontSize',14,'linewidth',2);
                   hold on
                   xlim([-0.05 4.05])
        mdl = fitlm(T, 'Y ~ X');
        yhat = predict(mdl, [0:0.1:max(T.X)]');
        myplot([0:0.1:max(T.X)], yhat, 'L', 1);
        mytext(2, 2.7, modelString(mdl), 14, 7);
        mytext(2, 2, ['R = -' num2str(sqrt(mdl.Rsquared.ordinary),2) ], 14, 7)
       xlabel( 'Ladybeetle population' )
       ylabel({ 'Aphid population change rate' , '(log ratio)' } , 'FontSize',14) 
       %title({'Effects of ladybeetles on aphids','9-Plant scale'})
             title('9-Plant scale')
 %% Top-down, 27-plant scale
 figure
    T =  array2table([MA_L_27(keep27) DF_A_27(keep27)], 'VariableNames', {'X','Y'});
   jittered_X = T.X + (rand(size(T.X)) * 0.1 - 0.1/2);
        scatter( jittered_X , T.Y, 60, 'filled', ...
                       'Markeredgecolor','none','Markerfacecolor','k', 'Markerfacealpha',0.5);
                   set(gca,'FontSize',14,'linewidth',2);
                   hold on
                   xlim([-0.05 6.05])
        mdl = fitlm(T, 'Y ~ X');
        yhat = predict(mdl, [0:0.1:max(T.X)]');
        myplot([0:0.1:max(T.X)], yhat, 'L', 1);
        mytext(3, -1.5, modelString(mdl), 14, 7);
        mytext(3, -2, ['R = -' num2str(sqrt(mdl.Rsquared.ordinary),2) ], 14, 7)
       xlabel( 'Ladybeetle population' )
       ylabel({ 'Aphid population change rate' , '(log ratio)' } , 'FontSize',14) 
      % title({'Effects of ladybeetles on aphids','27-Plant scale'})
            title('27-Plant scale')
%%  Bottom up, 1-plant scale
figure
   T =  array2table([MA_A_1(keep1) DF_L_1(keep1)], 'VariableNames', {'X','Y'});
   jittered_Y = T.Y + (rand(size(T.Y)) * 0.1 - 0.1/2);
        scatter( T.X , jittered_Y, 60, 'filled', ...
                       'Markeredgecolor','none','Markerfacecolor','k', 'Markerfacealpha',0.5);
                   set(gca,'FontSize',14,'linewidth',2);
                   hold on
                   xlim([0 450])
        mdl = fitlm(T, 'Y ~ X');
        yhat = predict(mdl, [0:max(T.X)]');
        myplot([0:max(T.X)], yhat, 'L', 1);
        mytext(120, 1.3, modelString(mdl), 14, 7);
        mytext(120, 1, ['R = ' num2str(sqrt(mdl.Rsquared.ordinary),2) ], 14, 7)        
        xlabel( 'Aphid population' )
       ylabel({ 'Ladybeetle population change rate' , '(log ratio)' } , 'FontSize',14) 
    %   title({'Effects of aphids on ladybeetles','1-Plant scale'})
   title('1-Plant scale')
%%  Bottom up, 3-plant scale
figure
   T =  array2table([MA_A_3(keep3) DF_L_3(keep3)], 'VariableNames', {'X','Y'});
   jittered_Y = T.Y + (rand(size(T.Y)) * 0.1 - 0.1/2);
        scatter( T.X , jittered_Y, 60, 'filled', ...
                       'Markeredgecolor','none','Markerfacecolor','k', 'Markerfacealpha',0.5);
                   set(gca,'FontSize',14,'linewidth',2);
                   hold on
                   xlim([0 500])
        mdl = fitlm(T, 'Y ~ X');
        yhat = predict(mdl, [0:max(T.X)]');
        myplot([0:max(T.X)], yhat, 'L', 1);
        mytext(120, 1.4, modelString(mdl), 14, 7);
        mytext(120, 1, ['R = ' num2str(sqrt(mdl.Rsquared.ordinary),2) ], 14, 7)        
        xlabel( 'Aphid population' )
       ylabel({ 'Ladybeetle population change rate' , '(log ratio)' } , 'FontSize',14) 
      % title({'Effects of aphids on ladybeetles','3-Plant scale'})
        title('3-Plant scale')
  %%  Bottom up, 9-plant scale
  figure
   T =  array2table([MA_A_9(keep9) DF_L_9(keep9)], 'VariableNames', {'X','Y'});
   jittered_Y = T.Y + (rand(size(T.Y)) * 0.1 - 0.1/2);
        scatter( T.X , jittered_Y, 60, 'filled', ...
                       'Markeredgecolor','none','Markerfacecolor','k', 'Markerfacealpha',0.5);
                   set(gca,'FontSize',14,'linewidth',2);
                   hold on
                   xlim([0 900])
        mdl = fitlm(T, 'Y ~ X');
        yhat = predict(mdl, [0:max(T.X)]');
        myplot([0:max(T.X)], yhat, 'L', 1);
        mytext(200, 1.4, modelString(mdl), 14, 7);
        mytext(200, 1, ['R = ' num2str(sqrt(mdl.Rsquared.ordinary),2) ], 14, 7)        
        xlabel( 'Aphid population' )
       ylabel({ 'Ladybeetle population change rate' , '(log ratio)' } , 'FontSize',14) 
    %   title({'Effects of aphids on ladybeetles','9-Plant scale'})
      title('9-Plant scale')
%% Bottom up, 27-plant scale
figure
   T =  array2table([MA_A_27(keep27) DF_L_27(keep27)], 'VariableNames', {'X','Y'});
   jittered_Y = T.Y + (rand(size(T.Y)) * 0.1 - 0.1/2);
        scatter( T.X , jittered_Y, 60, 'filled', ...
                       'Markeredgecolor','none','Markerfacecolor','k', 'Markerfacealpha',0.5);
                   set(gca,'FontSize',14,'linewidth',2);
                   hold on
                   xlim([0 1500]); ylim([-1 1.25])
        mdl = fitlm(T, 'Y ~ X');
        yhat = predict(mdl, [0:max(T.X)]');
        myplot([0:max(T.X)], yhat, 'L', 1);
        mytext(500, 1.2, modelString(mdl), 14, 7);
        mytext(500, 1, ['R = ' num2str(sqrt(mdl.Rsquared.ordinary),2) ], 14, 7)        
        xlabel( 'Aphid population' )
       ylabel({ 'Ladybeetle population change rate' , '(log ratio)' } , 'FontSize',14) 
       title({'Effects of aphids on ladybeetles','27-Plant scale'})
         title('27-Plant scale')