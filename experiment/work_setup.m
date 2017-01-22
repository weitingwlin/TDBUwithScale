%% Set up working folder and utility path

%% Get current machine name
[stt, strout] =system('hostname');


%%% set working directory and path
if strncmp(strout, 'weitingdeAir',12)
    cd '/Users/weitinglin/Dropbox/PhD_projects/TDBU/experiment'
    addpath '/Users/weitinglin/Dropbox/DataCoding/utility_wtl/mfiles'
    addpath '/Users/weitinglin/Dropbox/PhD_projects/TDBU/DataAnalysis'
    datapath = './data/'; 
end

% PC; home
if strncmp(strout, 'wlin_pc',5)
        cd 'C:\Users\Wei-Ting\Dropbox\PhD_projects\TDBU\experiment'
        addpath 'C:\Users\Wei-Ting\Dropbox\DataCoding\utility_wtl\mfiles'
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear stt strout
pwd
