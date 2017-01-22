% Syntax:
%           bootstrapTDBU = TDBU_bootstrap_logreg(dataA, dataL, Day, itt, replacement)
function bootstrapTDBU = TDBU_bootstrap_logreg(dataA, dataL, Day, itt, replacement)
% TDBU_bootstrap.m : function, simulate null model by shuffling the plant ID (location) of data, calculate the confidance interval and mediam.  
% default is without replacement 
if (nargin <5),  replacement = false;  end
% convert replacement to logical if it is numeric
if isa(replacement,'double') == 1
    replacement=logical(replacement);
end

%%% Prepare sheet
TDsh = zeros(itt, 4);
BUsh = zeros(itt, 4);

%%% Do simulation

for t=1:itt
    % create permutated data: permutation was done for each time step
    sh_data_A = datasample(dataA, 81, 1, 'replace', replacement); % shuffle the patch(plant) ID of the data 
    sh_data_L = datasample(dataL, 81, 1,'replace', replacement);
    output = TDBU_scale_logreg(sh_data_A,sh_data_L,Day); % calculate TD, BU indices
    TDsh(t,:) = output(1,:);  % save output
    BUsh(t,:) = output(2,:);
end

% Calculate CI and median
ciTD = quantile(TDsh,[0.025 0.975],1); % get 95%, 2-tail confidence interval for each column in TDsh
ciBU = quantile(BUsh,[0.025 0.975],1);
medTD = median(TDsh);
medBU = median(BUsh);
%%% Calculate TDBU for original data
real = TDBU_scale_logreg(dataA,dataL,Day);
% Calculate Relative Effect of Scale (Data-medNull)/(CI-medNull) 
cibarTD = medTD - ciTD(1,:); % lower limit                              
resTD = (medTD - real(1,:)) ./ cibarTD;
       
cibarBU = ciBU(2,:)-medBU; % upper limit                              
resBU = ( real(2,:) - medBU ) ./ cibarBU;

% prepare output
bootstrapTDBU = struct('ciTD',ciTD,'ciBU',ciBU,'medTD',medTD, 'medBU',medBU,'real',real, 'resTD',resTD,'resBU',resBU);
