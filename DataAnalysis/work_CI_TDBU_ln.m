% top-down & bottom-up indices from time series
% where
% Wei-Ting Lin 2014/09/06
% This work_ file, do permutations from real TS, calculated TD,BU, and compute CI 
clear;clc
 % cd 'C:\Users\ASUS\Desktop\Weiting Brain_brain\Files\CFC26219-6EB2-83FC-A81F-64377771BF19'
      % Laptop 
cd 'C:\Users\Wei-Ting\Desktop\Weiting Brain_brain\Files\CFC26219-6EB2-83FC-A81F-64377771BF19'
      % Desktop PC
work_compile
%% log transformed new data 
A_log=log(aphid+1);
L_log=log(ladybug+1);
   % use Y = log(y+1) so Y = 0 when y = 0 
%%
sh=10000; % time of permutation
         
TDsh_log=zeros(sh,4);
BUsh_log=zeros(sh,4);
%%
tic
parfor t=1:sh
    % create permutated data
    sh_data_A_log = line_shuffler(A_log,1);
    sh_data_L_log = line_shuffler(L_log,1);
    output = TDBU_scale(sh_data_A_log,sh_data_L_log,day);
    TDsh_log(t,:) = output(1,:); 
    BUsh_log(t,:) = output(2,:);
end
toc   % 857s for sh=10,000
save temp_log TDsh_log BUsh_log
%%  get CI from permutation results
load temp_log 
ci_TD_log = bootstrap_ci(TDsh_log,0.05,2);
ci_BU_log = bootstrap_ci(BUsh_log,0.05,2);
TD_m_log = median(TDsh_log);
BU_m_log = median(BUsh_log);
   real_log = TDBU_scale(A_log,L_log,day);
TD_log = real_log(1,:);
BU_log = real_log(2,:);   
clear array D Data S
%%
figure
subplot(2,1,1)
    box_lim = ci_TD_log;
    box_mid = TD_m_log;
    points = TD_log;
    tx_title = ('Top-Down Effect (Log)');
    tx_y = ('R');
%%%%%%%%%%%%%%
script_plot_ci_style2
%%%%%%%%%%%%%%
 
subplot(2,1,2)
   box_lim = ci_BU_log;
    box_mid = BU_m_log;
    points = BU_log;

    tx_title = ('Bottom-Up Effect (Log)');
    tx_y = ('R');
%%%%%%%%%%%%%%
script_plot_ci_style2
%%%%%%%%%%%%%%
%%
 text(2.5,-0.09,'Spatial Scale (# of plant)','HorizontalAlignment','center','FontSize',13)
 text([1 2 3 4],repmat(-0.06,1,4),{1,3,9,27},'FontSize',13)