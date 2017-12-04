
clear;clc
load TDBU_expData
%% how to get the correlation of each scale

nd =  length(dayID)
data_L = ladybug;
data_A = aphid;
Day = dayID;
itt = 100;
%%
TDsh = zeros(itt, 4);
BUsh = zeros(itt, 4);
replacement = logical(1);
parfor t=1:itt
    % create permutated data: permutation was done for each time step
    sh_data_A = datasample(data_A, 81, 1, 'replace', replacement); % shuffle the patch(plant) ID of the data 
    sh_data_L = datasample(data_L, 81, 1,'replace', replacement);
    output = TDBU_scale_logreg(sh_data_A,sh_data_L,Day); % calculate TD, BU indices
    TDsh(t,:) = output(1,:);  % save output
    BUsh(t,:) = output(2,:);
end

%% Calculate CI and median
ciTD = quantile(TDsh, [0.025 0.975], 1); % get 95%, 2-tail confidence interval for each column in TDsh
ciBU = quantile(BUsh, [0.025 0.975], 1);
medTD = median(TDsh);
medBU = median(BUsh);
%% Calculate R_TD, R_BU for original data
real = TDBU_scale_logreg(data_A, data_L, Day);
%%

histogram(TDsh(:,1), 20); hold on
vline(medTD(1), 7, ':');
vline(real(1,1), 2);
%vline(ciTD(1,1), 7,':');vline(ciTD(2,1), 7,':');