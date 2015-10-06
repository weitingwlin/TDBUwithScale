% top-down & bottom-up indices from time series
% This work_ file, do permutations from real TS, calculated TD,BU, and compute CI 
clear;clc
%% pc, home
cd 'C:\Users\Wei-Ting\Dropbox\PhD_projects\TDBU\DataAnalysis'

load TDBU_expData
addpath('C:\Users\Wei-Ting\Dropbox\PhD_projects\TDBU\SharedAnalysis')
%% laptop, school
cd 'C:\Users\ASUS\Dropbox\PhD_projects\TDBU\DataAnalysis'

load TDBU_expData
addpath('C:\Users\ASUS\Dropbox\PhD_projects\TDBU\SharedAnalysis')
%%
sh=100; % time of permutation; 'sh' for shuffleing
         
TDsh=zeros(sh,4);
BUsh=zeros(sh,4);
%%
tic
for t=1:sh
    % create permutated data
    sh_data_A = line_shuffler(aphid,1);
    sh_data_L = line_shuffler(ladybug,1);
    output = TDBU_scale(sh_data_A,sh_data_L,dayID);
    TDsh(t,:) = output(1,:); 
    BUsh(t,:) = output(2,:);
end
toc   % 857s for sh=10,000
save temp TDsh BUsh
%% For the log-based result, use [work_CI_TDBU_ln.m]

%%  get CI from permutation results
load temp 
ci_TD = quantile(TDsh,[0.025 0.975],1); % get 95%, 2-tail confidence interval for each column in TDsh
ci_BU = quantile(BUsh,[0.025 0.975],1);
TD_ = median(TDsh);
BU_ = median(BUsh);
   real = TDBU_scale(aphid,ladybug,dayID);
TD = real(1,:);
BU = real(2,:);   
clear array D Data S
%% Making figure (using myplot_CI)
figure
subplot(2,1,1)
        mytexts=[];
        mytexts.title ='Top-down effects';
        mytexts.ylabel = 'R';
%%%%%%%%%%%%%%
myplot_CI(TD,ci_TD,TD_,4,mytexts)
%%%%%%%%%%%%%%
subplot(2,1,2)
        mytexts=[];
        mytexts.title ='Bottom-Up effects';
        mytexts.ylabel = 'R';
        mytexts.xlabel = 'Spatial Scale (# of plant)';
        mytexts.xmark = {'1','3','9','27'};
%%%%%%%%%%%%%%
myplot_CI(BU,ci_BU,BU_,4,mytexts)
%%%%%%%%%%%%%%
