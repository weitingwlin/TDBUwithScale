% top-down & bottom-up indices from time series
% Wei-Ting Lin
% This work_ file, do permutations from real TS, calculated TD,BU, and compute CI 
clear;clc
 % cd 'C:\Users\ASUS\Desktop\Weiting Brain_brain\Files\CFC26219-6EB2-83FC-A81F-64377771BF19'
      % Laptop 
cd 'C:\Users\Wei-Ting\Desktop\Weiting Brain_brain\Files\CFC26219-6EB2-83FC-A81F-64377771BF19'
      % Desktop PC
work_compile
%%
sh=10000; % time of permutation
         
TDsh=zeros(sh,4);
BUsh=zeros(sh,4);
%%
tic
for t=1:sh
    % create permutated data
    sh_data_A = line_shuffler(aphid,1);
    sh_data_L = line_shuffler(ladybug,1);
    output = TDBU_scale(sh_data_A,sh_data_L,day);
    TDsh(t,:) = output(1,:); 
    BUsh(t,:) = output(2,:);
end
toc   % 857s for sh=10,000
save temp TDsh BUsh
%%  get CI from permutation results
load temp 
ci_TD = bootstrap_ci(TDsh,0.05,2);
ci_BU = bootstrap_ci(BUsh,0.05,2);
TD_ = median(TDsh);
BU_ = median(BUsh);
   real = TDBU_scale(aphid,ladybug,day);
TD = real(1,:);
BU = real(2,:);   
clear array D Data S
%%  
Nt=4
figure
subplot(2,1,1)
    box_lim = ci_TD;
    box_mid = TD_;
    points = TD;

    tx_title = ('Top-Down Effect');
    tx_y = ('R');

%%%%%%%%%%%%%%
script_plot_ci_style2
%%%%%%%%%%%%%%
 
subplot(2,1,2)
   box_lim = ci_BU;
    box_mid = BU_;
    points = BU;
    tx_title = ('Bottom-Up Effect');
    tx_y = ('R'); 
%%%%%%%%%%%%%%
script_plot_ci_style2
%%%%%%%%%%%%%%
 text(2.5,-0.09,'Spatial Scale (# of plant)','HorizontalAlignment','center','FontSize',13)
 text([1 2 3 4],repmat(-0.06,1,4),{1,3,9,27},'FontSize',13)