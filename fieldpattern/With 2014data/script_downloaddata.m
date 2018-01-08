%% make data folder, download data from LTER data portal
    % make folder
    if exist('data','dir')~=7 % the folder doesn't exist
            mkdir('data');
    end
    % download data
    if exist('./data/bugdata2014.csv','file')~= 2 % if the file doesn't exist
            urlwrite('https://portal.lternet.edu/nis/dataviewer?packageid=knb-lter-gce.583.22&entityid=8ae016d3046ae5e672512cc133818d49','./data/bugdata2014.csv');
    end
%% load data into matlab
    P14 = 38; % 38 patches sampled in summer 2014
    InsectData14 = csvread('./data/bugdata2014.csv', 5,8); % the insect data matrix of each sample
    Samples14 = csvread('./data/bugdata2014.csv', 5,2,[5,2,745,3]);% the site code of each sample
    ind_patch14 =  unique(Samples14, 'rows'); % index of the 38 patches

  %% Compiling ladybug and aphid data
           Amat14 = nan( P14, 20); % aphid population
         %   Lmat14 = nan( P14, 20); % ladybug population, only spotless
          %  Lallmat14 = nan( P14, 20); % ladybug, 3 taxa, only adult
            LLmat14 = nan( P14, 20); % ;ladybug, 3 taxa, adult and larva
   % sample = 1; % first sample
    for p = 1 : P14
            patch = ind_patch14(p,:); % [ site, patch] 
                temp1 = find(((Samples14(:,1) == patch(1)) + (Samples14(:,2) == patch(2)))==2); % index for this patch
                tl = length(temp1); % time series length: how many samples were taken for this patch
            Amat14(p, 1:tl) = InsectData14(temp1, 5)' ;         
         %   Lmat14(p, 1:tl) = InsectData14(temp1, 12)';         
         %   Lallmat14(p, 1:tl) =sum( InsectData14(temp1, [11 12 13 ])') ;  % 3 taxa; adults      
            LLmat14(p,  1:tl) =sum( InsectData14(temp1, [11 12 13 16])') ;   % 3 taxa; adults and larva
    end
%% 
clear tl temp patch p
save data/ladybugaphid2014