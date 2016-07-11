%% Set up working folder and utility path

%% Get current machine name
[stt, strout] =system('hostname');

%%% set working directory and path
if strncmp(strout, 'ChrisdeMacBook-Air.local',12)
    cd ''
    addpath '/Users/weitinglin/Dropbox/DataCoding/utility_wtl/mfiles'
end
% PC; home
 
% laptop; lab
if strncmp(strout, 'wlin_pc',5)
        cd 'C:\Users\Wei-Ting\Dropbox\PhD_projects\TDBU\fieldpattern'
        addpath 'C:\Users\Wei-Ting\Dropbox\DataCoding\utility_wtl'
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear stt strout
pwd