%% Note
% 2015-09-28 : Add interactive section to specify data file name, add note, save parameter into a text
% file of the same name. Include multiple dispersal event in one time step (i.e. day)
% 
% 2015-10-13 : change  dispersal function, allow dispersal to current patch; fixed "daily dispersal rate"   
% 2015-10-14 : fix functional response
%%
% running with [iva_dscrt_6] and [iva_disper_6]
% Data can be analysed with [work_iva_TDBU.m]
clear;clc
work_setup
%%
script_parameters

%% test robustness
 %  cP = 0.1
 %  cP = 0.3 
 %  eP = 1
 %  eP = 2
 %  dPz = 0.2; dP = 0.7
 %  dPz = 0.4; dP = 0.5
 %  dPz = 0.2   ; dPz + dP
 %  dPz = 0.4
 %  aP = 0.15
 %  aP = 0.35
%% Simulation settings
ittInit =100; %  itteration of randomly initiated simulations
ittSim= 100; % iteration (==time or day)\\
np = 81; % number of patch

% prepare datasheet for simulation
data = zeros(np, 2, ittSim + 1); % X0~XT; each layer np x 2 matrix 
sim_L = zeros(81,1);% dummy
sim_A = zeros(81,1);
sim_D = 1;
seed=123;
%% Simulation\
tic
rng(seed); % set seed of simulation
for r = 1 : ittInit % randomly initialed simulations
% Initial value
    for p = 1 : np
        data(p,:,1) = [rand*100*(rand >= 0.5) , 20*(rand>=0.9) ];  
        %              aphid                                ladybug
    end
        data(:,:,1) = round_rand( data(:,:,1)); % the initial values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% Simulation
    for t = 1 : ittSim
    % run the local dynamics model first
        Xh = iva_dscrt_6(data( :, :, t), withBDofP );    
                                                  % 1: with, 0:without  predator local dynamics
    % Dispersal
        % Switch to individual-based mode
            Xhn = round_rand(Xh./repmat([sH sP],np,1)); 
        % Dispersal
            X1n = iva_disper_6(Xhn,DisperEvent);
        % Switch back to biomass mode
            data(:,:,t+1) = X1n.*repmat([sH sP],np,1);  
    end
% save simulated data from
sim_L_temp = round_rand(data(:,2,end-9:end));% only the last 10 steps were saved
sim_A_temp = round_rand(data(:,1,end-9:end));
D_temp=[sim_D(end) + 2 : sim_D(end)+11]; % pseudo dates 
sim_L = [sim_L sim_L_temp];
sim_A = [sim_A sim_A_temp];
sim_D = [sim_D,D_temp];
end
toc
%%  to visualize result 
%   edit work_explore_TDBU
%% Name and note of simulation
 prompt = 'Name this simulation in one (long) word, between quotation marks:  ';
 savename = [datapath, 'sim_TDBU_',input(prompt)];
 prompt = 'Note for this simulation:  ';
note = input(prompt)
%% save data

 save(savename,  'sim_L',  'sim_A',  'sim_D')
%% to print simulation metadata
%  script_simulationData
% 
filename = [savename,'.txt']
fileID = fopen(filename,'w+t'); % a for append; w for write and replace exist content
% fclose(fileID); 
%note='example';
 script_simulationData
 
