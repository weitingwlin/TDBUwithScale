function bootstrapTDBU = TDBU_bootstrap_logreg_diff(dataA, dataL, Day, itt, replacement)
if (nargin <5),  replacement = false;  end
% convert replacement to logical if it is numeric
if isa(replacement,'double') == 1
    replacement=logical(replacement);
end

%%% Prepare sheet
TDsh = zeros(itt, 4);
BUsh = zeros(itt, 4);
% initialized 
ciTDdiff = zeros(2, 6);
medTDdiff = zeros(1, 6);
realTDdiff = zeros(1, 6);
 pvalTDdiff = zeros(1, 6);
ciBUdiff = zeros(2, 6);
medBUdiff = zeros(1, 6);
realBUdiff = zeros(1, 6);
 pvalBUdiff = zeros(1, 6);

%%% Do simulation

parfor t=1:itt
    % create permutated data: permutation was done for each time step
    sh_data_A = datasample(dataA, 81, 1, 'replace', replacement); % shuffle the patch(plant) ID of the data 
    sh_data_L = datasample(dataL, 81, 1,'replace', replacement);
    output = TDBU_scale_logreg(sh_data_A,sh_data_L,Day); % calculate TD, BU indices
    TDsh(t,:) = output(1,:);  % save output
    BUsh(t,:) = output(2,:);
end

% Calculate CI and median
ciTD = quantile(TDsh, [0.025 0.975], 1); % get 95%, 2-tail confidence interval for each column in TDsh
ciBU = quantile(BUsh, [0.025 0.975], 1);
medTD = median(TDsh);
medBU = median(BUsh);
%%% Calculate R_TD, R_BU for original data
real = TDBU_scale_logreg(dataA, dataL, Day);
%%%
si_seq = [1,2; 1,3; 1,4; 2,3; 2,4; 3,4];
for si = 1:6
    % TD
        diffTDsh = TDsh(:, si_seq(si, 2)) - TDsh(:, si_seq(si, 1))  ;
        ciTDdiff(:, si) = quantile(diffTDsh, [0.025 0.975], 1);
        medTDdiff(si) = median(diffTDsh);
        realTDdiff(si) = real(1, si_seq(si, 2)) - real(1, si_seq(si, 1)) ;
         [p, ~, ~] = pval(realTDdiff(si), diffTDsh, 2, 0 ) ;
       pvalTDdiff(si) = p;
      % BU
        diffBUsh = BUsh(:, si_seq(si, 1)) - BUsh(:, si_seq(si, 2)) ;
        ciBUdiff(:, si) = quantile(diffBUsh, [0.025 0.975], 1);
        medBUdiff(si) = median(diffBUsh);
        realBUdiff(si) = real(2, si_seq(si, 1)) - real(2, si_seq(si, 2)) ;
        [p, ~, ~] = pval(realBUdiff(si), diffBUsh, 2, 0 ) ;
       pvalBUdiff(si) = p;
end
Diff = [];
Diff.ciTDdiff = ciTDdiff; 
Diff.medTDdiff = medTDdiff;
Diff.realTDdiff = realTDdiff;
Diff.pvalTDdiff = pvalTDdiff;
Diff.ciBUdiff = ciBUdiff; 
Diff.medBUdiff = medBUdiff;
Diff.realBUdiff = realBUdiff;
Diff.pvalBUdiff = pvalBUdiff;
% Calculate Relative Effect of Scale (Data-medNull)/(CI-medNull) 
    %cibarTD = medTD - ciTD(1,:); % lower limit                              
difTD = (medTD - real(1,:));% ./ cibarTD;
% cibarBU = ciBU(2,:)-medBU; % upper limit                              
difBU = ( real(2,:) - medBU ); % ./ cibarBU;
% P value: inverse percentile

for s =1:4
        [p, ~, ~] = pval(real(1, s ), TDsh(:, s), 1, 0 ) ;
        Pval(1,s) = p;
        [p, ~, ~] = pval(real(2, s ), BUsh(:, s), 1, 0 ) ;
        Pval(2,s) = p;
end
% prepare output
bootstrapTDBU = struct('ciTD',ciTD,'ciBU',ciBU,'medTD',medTD, 'medBU',medBU,...
                                          'real',real, 'difTD',difTD,'difBU',difBU, 'Pval', Pval,...
                                          'Diff', Diff);
