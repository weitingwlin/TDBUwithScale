%% Load habitat structure
parameters = [];
    XY = load('data/XY.txt'); % the X-Y locations of each plant
    % to visualize the array:
    %               plot(XY(:,1), XY(:,2), 'g.'); 
%% Papameters setting
parameters.exitP = 0; % The rate of dispersing out of the system
parameters.gH = 0.2;  % The intrinsic growth rate of herbivore
parameters.eP = 3; % Consumption rate of herbivore by predator
parameters.H_0 = 30;  % Half saturate herbivore density
parameters.aP = 0.2;  %  Assimilation rate
parameters.KH = 200; % Carrying capacity
parameters.mH = 0.1;% Mortality
parameters.mP = 0.05;% 
parameters.dH = 0.01;% Increased dispersal 
parameters.dHz = 0.01;% Background dispersal
parameters.dP = 0.4;% Increased dispersal
parameters.dPz = 0.2;% Background dispersal
parameters.sH = 1; % body size
parameters.sP = 20;% body size 20*sH is realistic 
parameters.H_thH = 100;% dispersal threshhold for H
parameters.H_thP = 15;% dispersal threshhold for P
parameters.cP = 0.5;        % dispersal parameter c for P , small number means long distance travel
parameters.cH = 0.1;       % dispersal parameter c for H
%% Dispersal matrix
parameters.Dist = squareform(pdist(XY)); % XY cordinates --> distance matrix   

parameters.B = 0.3; 