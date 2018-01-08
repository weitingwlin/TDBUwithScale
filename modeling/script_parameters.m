%%
load D_mat2
% XY is the coordinate of the location of 81 plants
global np gH eP aP mH mP stoc_mH stoc_mP dH dP sH sP H_thH H_thP KH dHz dPz H_0 DispH DispP B

%% papameter setting
withBDofP = 0; % whether with local dynamics (Birth and Death) of Predator 
DisperEvent = 1; % number of dispersal event within a day
gH = 0.2;  % The intrinsic growth rate of herbivore
eP = 1.5;% 1.5;      consumption rate of herbivore by predator
H_0 = 30;  % H_0 = 30;   half saturate  
aP = 0.25;  % aP=0.25  assimilation rate
KH = 200; %200; carrying capacity of H
mH = 0.1;% 0.1
mP = 0.1;% 0.1
stoc_mH = 2;% 2
stoc_mP = 2;% 2
dH = 0.05;% 0.05
dHz = 0.05;% 0.05 
dP = 0.6;% 0.6
dPz = 0.3;%0.3
sH = 1; % body size ~mg
sP = 20;% body size 20*sH is realistic 
H_thH = 100;%100
H_thP = 15;% 15
cP = 0.2;        % 0.2 dispersal parameter c for P , small number means long distance travel
cH = 0.1;       % dispersal parameter c for H
% Dispersal matrix
Dist = squareform(pdist(XY)); % XY cordinates --> distance matrix   
DispH = disp_incidence (Dist,cH,  ones(size(Dist)));  % Distance matrix --> dispersal matrix
DispP = disp_incidence (Dist,cP, ones(size(Dist)));
B = 0.25; 