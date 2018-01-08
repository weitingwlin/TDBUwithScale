
clear; clc
%% calculate stochastic parameters   
    tlim = 100;        
    trec = 10;   
    ts = tlim-trec +1: 01: tlim; % time sampled
    it = 3;    
%%
for scen = 1:2
    simA = []; simL = []; simD =[];
    rng(1)
    tic
    parfor i = 1:it
        tic
        X0 = zeros(81,2);
        
        for p = 1:81
                X0(p,:)  = [round(rand*100*(rand >= 0.3)) , rand>=0.9];  
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%
        [t, x] = iva_Gillespie2( X0, tlim,  scen-1 , dP);
        %%%%%%%%%%%%%%%%%%%%%%%%%
                x1 = permute(x, [1 3 2]); % so the dimensions in x1 are [patch, time, species]
                tempA = fixsample(t, x1(:,:,1), ts);
                tempL = fixsample(t, x1(:,:,2), ts);
        simA = [simA tempA];
        simL = [simL tempL];
        simD = [simD ts];
        second = toc; disp(['iteration: ', num2str(i), ' time (s) ' , num2str(second) ]);
    end
    second2 = toc; disp(['Total  time (s) ' , num2str(second2) ]);
%
    script_explore_TDBU 
end
end
%save sim_scen1_new5 simA simL simD
%% 

%% plot examples
figure
    im = imagesc(simA); hold on
        colormap(mycolormap(3));
        set(gca,'xtick', [], 'ytick', []);
figure
    im = imagesc(simL); hold on
        colormap(mycolormap(2));
        set(gca,'xtick', [], 'ytick', []);
figure
    myplotyy(1:length(ts)*it, sum(simA), 1:length(ts)*it, sum(simL), 'S', 'S', 3, 2);
