## new3
withBDofP =1;
exitP = 0; % the rate of dispersing out of the system
gH = 0.2;  %0.2 The intrinsic growth rate of herbivore
eP = 3;% 3;      consumption rate of herbivore by predator
H_0 = 30;  % H_0 = 30;   half saturate  
aP = 0.2;  % aP=0.2  assimilation rate
KH = 200; %200; carrying capacity of H
mH = 0.1;% 0.1
mP = 0.05;% 0.05
stoc_mH = 5;% 5
stoc_mP = 2;% 2
dH = 0.01;% 0.01
dHz = 0.01;% 0.01 
dP = 0.5;% 0.5 % 0.6 for new
dPz = 0.2;%0.2 % 0.3 for newnew
sH = 1; % body size ~mg
sP = 20;% body size 20*sH is realistic 
H_thH = 100;%100
H_thP = 10;% 10
cP = 0.5;        % 0.2 dispersal parameter c for P , small number means long distance travel
                     % 0.5 for new
cH = 0.1;       % dispersal parameter c for H
% Dispersal matrix
Dist = squareform(pdist(XY)); % XY cordinates --> distance matrix   
DispH = disp_incidence (Dist,cH,  ones(size(Dist)));  % Distance matrix --> dispersal matrix
DispP = disp_incidence (Dist,cP, ones(size(Dist)));
B = 0.25; 

## new4
%% papameter setting
withBDofP =1;
exitP = 0; % the rate of dispersing out of the system
gH = 0.2;  %0.2 The intrinsic growth rate of herbivore
eP = 2;% 3;      consumption rate of herbivore by predator
H_0 = 30;  % H_0 = 30;   half saturate  
aP = 0.2;  % aP=0.2  assimilation rate
KH = 200; %200; carrying capacity of H
mH = 0.1;% 0.1
mP = 0.05;% 0.05
stoc_mH = 5;% 5
stoc_mP = 2;% 2
dH = 0.01;% 0.01
dHz = 0.01;% 0.01 
dP = 0.5;% 0.5 % 0.6 for new
dPz = 0.2;%0.2 % 0.3 for newnew
sH = 1; % body size ~mg
sP = 20;% body size 20*sH is realistic 
H_thH = 100;%100
H_thP = 10;% 10
cP = 0.5;        % 0.2 dispersal parameter c for P , small number means long distance travel
                     % 0.5 for new
cH = 0.1;       % dispersal parameter c for H
% Dispersal matrix
Dist = squareform(pdist(XY)); % XY cordinates --> distance matrix   
DispH = disp_incidence (Dist,cH,  ones(size(Dist)));  % Distance matrix --> dispersal matrix
DispP = disp_incidence (Dist,cP, ones(size(Dist)));
B = 0.25; 