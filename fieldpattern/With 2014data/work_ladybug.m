%% Analysis related to ladybug and aphids
% This is a working file : do analysis on ladybug and aphid; produce
% results uned in the ladybug paper
%
% 1) ladybugs can strongly suppress aphids in a single patch, 
% 2) isolated patches had few predators, indicating role of dispersal, and 
% 3) aphids persist, likely due to the fact that most patches don’t have ladybugs at any given time.
% Organising the Iva insect/crab data from sapelo 2014/May~August
%
% _Wei-Ting Lin 2016/2/23_
%
%% Preparing settings and load compiled data
% Tp set up path: open work_setup.m and run
clear;clc
%% load data
load ./data/FieldData
%% numeric interaction 2013
%
% prepare a patch x time matrix for ladybug and aphid from 2013 data
            Amat13 = zeros( P13, 6);
            Lmat13 = zeros( P13, 6);
            Lallmat13 = zeros( P13, 6);
    sample = 1; % first sample
    for p = 1 : P13
            patch = ind_patch13(p,:); % [ site, patch] 
            temp1 = find(((InsectData13(:,1) == patch(1)) + (InsectData13(:,2) == patch(2)))==2); % index for this patch
    Amat13(p, :) = InsectData13(temp1, 8)' ;         
    Lmat13(p, :) = InsectData13(temp1, 15)' ;         
    Lallmat13(p,:) =sum( InsectData13(temp1, [14 15 16 ])') ;         
     LLmat13(p,:) =sum( InsectData13(temp1, [14 15 16 19])') ;    
    end
% numInteraction(Amat13, Lmat13, [0, 1], 1);  % a quick check

%%   numeric interaction 2014
           Amat = NaN( P, 20);
            Lmat = NaN( P, 20);
            Lallmat = NaN( P, 20);
    sample = 1; % first sample
    for p = 1 : P
            patch = ind_patch(p,:); % [ site, patch] 
            temp1 = find(((InsectData(:,1) == patch(1)) + (InsectData(:,2) == patch(2)))==2); % index for this patch
    Amat(p, 1:length(temp1)) = InsectData(temp1, 8)' ;         
    Lmat(p, 1:length(temp1)) = InsectData(temp1, 15)' ;         
    Lallmat(p,1:length(temp1)) =sum( InsectData(temp1, [14 15 16 ])') ;         
     LLmat(p,1:length(temp1)) =sum( InsectData(temp1, [14 15 16 19])') ;    
    end