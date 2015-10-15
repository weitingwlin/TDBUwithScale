% Work file for proccessing simulated data, calculating TD, BU indices for
% each spatial scales.
% and maybe tempora; scales
% Update 2015/09/23: move working directory to dropbox
clear; clc
% laptop
cd 'C:\Users\ASUS\Dropbox\PhD_projects\TDBU\modeling'

 load .\Data\sim_TDBU_test
% load simulated data simulated by [run_iva_5.m]
% sim_A :the simulated data for aphids
% sim_L : 
%% Permutation setting
sh=1000; % time of permutation
         
TDsh=zeros(sh,4); % data sheet to store 
BUsh=zeros(sh,4);
[N,D]=size(sim_A);
rng(123); % set seed of simulation
%%
tic
parfor t=1:sh
    % create permutated data
    sh_data_A = line_shuffler(sim_A,1);
    sh_data_L = line_shuffler(sim_L,1);
    output = TDBU_scale(sh_data_A,sh_data_L,1:D);
    TDsh(t,:) = output(1,:); 
    BUsh(t,:) = output(2,:);
end
toc   % 857s for sh=10,000
      % 484s using parfor
      save sim_data_5_withBDofP
%%  get CI from permutation results
load sim_data_5
ci_TD = bootstrap_ci(TDsh,0.05,2);
ci_BU = bootstrap_ci(BUsh,0.05,2);
TD_ = median(TDsh);
BU_ = median(BUsh);
   real = TDBU_scale(sim_A,sim_L,1:D);
TD = real(1,:);
BU = real(2,:);   
%%  
Nt = 4; % number of wanted ticks 
figure
subplot(2,1,1)
    tx_title = ('Top-Down Effect');
    tx_y = ('R');

%%%%%%%%%%%%%%
myplot_CI(TD,ci_TD)
%%%%%%%%%%%%%%
subplot(2,1,2)
    tx_title = ('Bottom-Up Effect');
    tx_y = ('R'); 
%%%%%%%%%%%%%%
myplot_CI(BU,ci_BU)
%%%%%%%%%%%%%%
 text(2.5,-0.25,'Spatial Scale (# of plant)','HorizontalAlignment','center','FontSize',13)
 text([1 2 3 4],repmat(-0.06,1,4),{1,3,9,27},'FontSize',13)
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
