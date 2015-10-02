% top-down & bottom-up indices from time series,
% top-down & bottom-up indices from time series
% This work_ file, do permutations from real TS, calculated TD,BU, and compute CI 
clear;clc
% pc, home
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
    sh_data_A_log = log(line_shuffler(aphid,1)+1); % only aphid numbers are log transformed
    sh_data_L = line_shuffler(ladybug,1);
    outputlog = TDBU_scale(sh_data_A_log,sh_data_L,dayID); % use the transformed data as input
    TDshlog(t,:) = outputlog(1,:); 
    BUshlog(t,:) = outputlog(2,:);
end
toc   % 857s for sh=10,000
save templog TDshlog BUshlog
%%  get CI from permutation results
load templog 
ci_TD = quantile(TDshlog,[0.025 0.975],1); % get 95%, 2-tail confidence interval for each column in TDsh
ci_BU = quantile(BUshlog,[0.025 0.975],1);
TD_ = median(TDshlog);
BU_ = median(BUshlog);
   real = TDBU_scale(log(aphid+1),ladybug,dayID);
TD = real(1,:);
BU = real(2,:);   
clear array D Data S
%% Making figure (using myplot_CI)
figure
subplot(2,1,1)
        mytexts=[];
        mytexts.title ='Top-down effects (aphid data log transformed)';
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
