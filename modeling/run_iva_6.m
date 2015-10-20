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
% laptop
%cd 'C:\Users\ASUS\Desktop\Weiting Brain_brain\Files\C360FDCB-6209-2553-BFA1-FE0A915B2A7F'
%% PC
cd 'C:\Users\Wei-Ting\Dropbox\PhD_projects\TDBU\modeling'
addpath 'C:\Users\Wei-Ting\Dropbox\DataCoding\MATLAB\utility_wtl\Utility_ecology'
 addpath 'C:\Users\Wei-Ting\Dropbox\DataCoding\MATLAB\utility_wtl\Utility_basic'
%% laptop
 cd 'C:\Users\ASUS\Dropbox\PhD_projects\TDBU\modeling'
 % addpath 'C:\Users\ASUS\Dropbox\DataCoding\MATLAB\utility_wtl\Utility_basic'
 addpath 'C:\Users\ASUS\Dropbox\DataCoding\MATLAB\utility_wtl\Utility_ecology'
%%
load D_mat2
% XY is the coordinate of the location of 81 plants
global np gH eP aP mH mP stoc_mH stoc_mP dH dP sH sP H_thH H_thP KH dHz dPz H_0 DispH DispP B
%% Name and note of simulation
 prompt = 'Name this simulation in one (long) word, between quotation marks:  ';
 savename = ['.\Data\sim_TDBU_',input(prompt)];
 prompt = 'Note for this simulation:  ';
note = input(prompt)
%% papameter setting
withBDofP = 1; % whether with local dynamics (Birth and Death) of Predator 
DisperEvent = 3; % number of dispersal event within a day
gH = 0.2;  % The intrinsic growth rate of herbivore
eP = 1.5;     % eP = 30; consumption rate of herbivore by predator
H_0 = 30;  % H_0 = 10;   half saturate  
aP = 0.1;  % aP=0.01  assimilation rate
KH = 200; %200; carrying capacity of H
mH = 0.1;% 0.1
mP = 0.05;% 0.1
stoc_mH = 2;% 2
stoc_mP = 2;% 2
dH = 0.05;% 0.05
dHz = 0.05;% 0 
dP = 0.6;% 0.3
dPz = 0.3;%0.3
sH = 1; % body size ~mg
sP = 20;% body size 20*sH is realistic 
H_thH = 100;%100
H_thP = 15;% 15
cP = 0.2;        % dispersal parameter c for H , small number means long distance travel
cH = 0.1;       % dispersal parameter c for P
% Dispersal matrix
Dist = squareform(pdist(XY)); % XY cordinates --> distance matrix   
DispH = disp_incidence (Dist,cH,  ones(size(Dist)));  % Distance matrix --> dispersal matrix
DispP = disp_incidence (Dist,cP, ones(size(Dist)));
B = 0.25; 

%% Simulation settings
ittInit =1000; %  itteration of randomly initiated simulations
ittSim= 100; % iteration (==time or day)
np = 81; % number of patch

% prepare datasheet for simulation
data = zeros(np,2,ittSim+1); % X0~XT; each layer np x 2 matrix 
sim_L = zeros(81,1);% dummy
sim_A = zeros(81,1);
sim_D = 1;
seed=123;
%% Simulation
rng(seed); % set seed of simulation
for r=1:ittInit % randomly initialed simulations
% Initial value
    for p=1:np
        data(p,:,1) = [rand*100*(rand >= 0.5) , 20*(rand>=0.9) ];  
        %              aphid                                ladybug
    end
        data(:,:,1) = round_rand( data(:,:,1)); % the initial values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% Simulation
    for t = 1:ittSim
    % run the local dynamics model first
        Xh = iva_dscrt_6(data(:,:,t),withBDofP);    
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
%%  to visualize result 
%   edit work_explore_TDBU
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
 
