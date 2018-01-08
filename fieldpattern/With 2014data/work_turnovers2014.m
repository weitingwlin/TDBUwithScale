%% Preparing settings and load compiled data
% Tp set up path: open work_setup.m and run
clear;clc
%% load data
load ./data2014/FieldData
script_compile2014_ladybug
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
 