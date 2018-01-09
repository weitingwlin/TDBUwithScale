
    clear; clc

%% calculate stochastic parameters   
    tlim = 100; % total time of simulation    
    trec = 10;  % time steps recorded 
    it = 300;    % iteration 
   initL = 0.1; % initial fraction of Ladybug
   initA = 0.7; % initial fraction of Aphids
%% Set model scenario & load parameters
    scen = 1;
    script_Gillespie3_parameters
    % overwrite default parameters
    exitP = 0.1;
    parameters.exitP = exitP;
    tlim = 20; % allows the ladybeetle populations to decrease with time
    ts = tlim-trec +1: 1: tlim; % time points recorded
    it = 10;
    initL = 0.3;
    description = ['Scien 1', para2str(exitP,tlim,initL)]
%%
    simA = []; simL = []; simD =[];
    rng(1); % for reproducibility
    tic
    parfor i = 1:it
        tic
        % initial values
        X0 = zeros(81,2);  
        for p = 1:81
                X0(p,:)  = [round(rand*100*(rand < initA)) , rand < initL];  
        end
        % simulation
        %%%%%%%%%%%%%%%%%%%%%%%%%
        [t, x] = iva_Gillespie3( X0, tlim,  scen-1, parameters);
        %%%%%%%%%%%%%%%%%%%%%%%%%
        % record at time specified in `ts`
                x1 = permute(x, [1 3 2]); % so the dimensions in x1 are [patch, time, species]
                tempA = fixsample(t, x1(:,:,1), ts);
                tempL = fixsample(t, x1(:,:,2), ts);
        simA = [simA tempA];
        simL = [simL tempL];
        simD = [simD ts];
        second = toc; disp(['iteration: ', num2str(i), ' time (s) ' , num2str(second) ]);
    end
    second2 = toc; disp(['Total  time (s) ' , num2str(second2) ]);
%%
figure
mysubplot(3,1,0, description)
simD_corrected = simD + repelem([0:11:(it-1)*11], trec);
% plot(1:length(simD), simD_corrected, 'o')
[Hax,H1,H2] =TDBU_trend_plot(simA, simL, simD_corrected);
%% Calculate R_TD, R_BU and simulate null model
sh = 1000;%10000;
tic
out = TDBU_bootstrap_logreg_diff(simA, simL, simD, sh,1);
toc
%% Check the results
figure
mysubplot(3,1,0, description)
TDBU_plot(out)
%%
% R_TD (for 1-, 3-, 9-, 27 plant scale)
    out.real(1,:)
    % median and CI are in null model
    out.medTD
    out.ciTD
    % p-value
    out.Pval(1,:)
% R_BU (for 1-, 3-, 9-, 27 plant scale)
    out.real(2,:)
    % median and CI are in null  model
    out.medBU
    out.ciBU
    % p-value
    out.Pval(2,:)
%% overall pattern
plot(simD, sum(simA), 'r');
plot(simD, sum(simL), 'b');
TDBUsim = out;