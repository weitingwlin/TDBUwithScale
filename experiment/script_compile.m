% Script_compile: The script work to compile data 
clear;clc
%% Load data column names
    fileID = fopen('./Data/ColumnNames.txt');
    CStr = textscan(fileID,'%s');
    Names= CStr{1}'; % variable names for each column stored in  [Data]
    fclose(fileID); 
%% Load data 
    Data=load('./Data/DataLA.txt'); % each row represent observation on one plant, one day
%% Prepare dayID variable for 
    [nrow, ncol] = size(Data);
    D = nrow/81; % the number of days observations were made.
    dayID= unique(Data(:, strcmp(Names,'day'))); % The days observations were made. length(dayID==D) 
                                                                    % D~= max(dayID) because there are "gaps" during the experiment.
%% Prepare data sheets 
    ladybug = zeros(81,D);  % time series of ladybug
    aphid = zeros(81,D);     % time series of ladybug
    spider = zeros(81,D);    % spiders
    larva = zeros(81,D);     % ladybug larva
    otherlb = zeros(81,D);  % other species of ladybugs
    egg = zeros(81,D);        % eggs (clutch)
%% Writting plant X day data matrix for each species/taxon
for L1 = 1:3   % location in witch 27 plants set
    for L2 = 1:3  % witch 9-plant set
        for L3 = 1:3
            for L4 = 1:3
                temp = find(Data(:,1)==L1 & Data(:,2)==L2 & Data(:,3)==L3 & Data(:,4)==L4);
                temp2 = ((L1-1)*27 + (L2-1)*9 +(L3-1)*3 +L4);% site in number 1~81
                aphid(temp2,:) = Data(temp,7)';
                ladybug(temp2,:) = Data(temp,8)';
                spider(temp2,:) = Data(temp,11)';
                larva(temp2,:) = Data(temp,10)';
                otherlb(temp2,:) = Data(temp,13)';
                egg(temp2,:) = Data(temp,14);
            end
        end
    end
end
%% Save Data as TDBU_expData
save TDBU_expData dayID aphid ladybug larva spider otherlb egg D