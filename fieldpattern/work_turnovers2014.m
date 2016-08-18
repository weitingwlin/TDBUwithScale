%% calculate patch occupancy and colonization rate
% 
% to reproduce fig. 2:
% 1. set up path to include tools in folder [dataAnalysis]
% 2. run script_downloaddata.m
% 3. run this file 
% 4. run work_TDBU.m
%% Preparing settings and load compiled data
% To set up path: open work_setup.m and run
% 
clear;clc
%% load data
load data/ladybugaphid2014
 %% Patch occupency rate
 AllSample = sum(~isnan(Amat14));
occA = sum((Amat14>0),1)./AllSample;
  vmeanSE(occA)
occL = sum((LLmat14>0),1)./AllSample;
  vmeanSE(occL)
 %% turnover rate: "effect of dispersal"
 
  [Acolevent, Adetail] = colonization(Amat14);
   [Lcolevent, Ldetail] = colonization(LLmat14);
       
%% "The individual level colonization ability"      
%  Colonization rate per individual, adjusted by the fraction of number of empty patch
    [msg, stroutAind] = vmeanSE(Adetail. perCapitaAdjTS)
     [msg, stroutLind] = vmeanSE(Ldetail. perCapitaAdjTS)

  %%  The net colonization rate (colonization event per empty patch)
    [msg, stroutAnet] = vmeanSE(Adetail. perPatchTS)
     [msg, stroutLnet] = vmeanSE(Ldetail. perPatchTS)
 %% make plots
 script_plot_turnover
 