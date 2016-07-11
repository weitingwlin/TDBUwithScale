%% Analysis of plant quality
clear; clc
work_setup
%% Load data
    fileID = fopen([datapath 'PlantNames.txt']);
    CStr = textscan(fileID,'%s');
PlantNames= CStr{1}'; % variable names for each column stored in  [Data]
    fclose(fileID); 
PlantData=load('./Data/DataPlant.txt'); % each row represent observation on one plant, one day
clear CStr fileID
%%
% height of plant at May
        usedID = logical(PlantData(:,2)); % logical indicator for whether a plant was used in experiment
        HMay = PlantData(usedID, 3); % plant height
disp(['mean of height at May 15 --  ' num2str( mean(HMay) ) ' (SE : '  num2str( std(HMay)/sqrt(length(HMay)) ) ')']);
        NMay = PlantData(usedID, 4); % number of leaves
disp(['mean Number of leaves at May 15 --  ' num2str( mean(NMay) )...
        ' (SE : '  num2str( std(NMay)/sqrt(length(NMay)) ) ')']);