%% Preparing settings and load compiled data
% Tp set up path: open work_setup.m and run
clear;clc
%% load data
load ./data/FieldData
%%
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

%% 3) aphids persist, likely due to the fact that most patches don’t have ladybugs at any given time.
 % site scale:
 Asite13 = zeros(3, 6);
 Lsite13 = zeros(3, 6);
 Aocc13 = zeros(3, 6);
 Locc13 = zeros(3, 6);
 SampleDate =  zeros(3, 6);
 for s = 1:3
        temp =  find( ( InsectData13(:,1) == s ) ); %
        sample = unique(Date13(temp));
        SampleDate(s,:) = sample;
        for t = 1:6
                temp1 = find(  (InsectData13(:,1) == s) + (Date13 == sample(t)) == 2);    
                        NS = length(temp1);
                Asite13(s,t) = sum( InsectData13(temp1, 8) )/NS;
                Lsite13(s,t) = sum( sum(InsectData13(temp1, [14 15 16 19]))  )/NS;
                Aocc13(s,t) = sum( InsectData13(temp1, 8) > 0)/NS;
                Locc13(s,t) = sum( sum(InsectData13(temp1, [14 15 16 19] )) > 0)/NS;             
        end
 end
 SampleDate = SampleDate - (min(Date13)) + 1;
 %% patch occupency rate
figure
        myplot(SampleDate(1,:), Aocc13(1,:), 'S', 3 , 'o'); hold on
        myplot(SampleDate(2,:), Aocc13(2,:), 'S', 3 , 'd'); 
        myplot(SampleDate(3,:), Aocc13(3,:), 'S', 3, '^'); 
        myplot(SampleDate(1,:), Locc13(1,:), 'S', 1 , 'o'); hold on
        myplot(SampleDate(2,:), Locc13(2,:), 'S', 1 , 'd'); 
        myplot(SampleDate(3,:), Locc13(3,:), 'S', 1, '^'); 
                legend('Aphid dike', 'Aphid airport', 'Aphid lighthouse', 'Ladybug dike', 'Ladybug airport', 'Ladybug lighthouse'  )
                title('Patch occupancy rate at three sampling sites')
                xlabel(['date (since '  datestr(min(Date13)) ')'])
                ylabel('Patch occupancy rate')
 % numInteraction(Asite13, Lsite13, [0, 1], 1)
 %%
occA = sum(sum(Amat13 > 0,1))/44/6
occL = sum(sum(LLmat13 > 0,1))/44/6
 %% turnover rate: "effect of dispersal"
 
  [Acolevent, Adetail] = colonization(Amat13);
   [Lcolevent, Ldetail] = colonization(LLmat13);
 %% Per capita colonization rate (adjusted by number of empty patch)
   figure
    subplot(2,1,1)
            myplot(1:5, Adetail. perCapitaAdjTS,'S');
                     title('Per capita colonization rate')
                     ylabel('Aphid')
    subplot(2,1,2)
            myplot(1:5, Ldetail. perCapitaAdjTS,'S', 2); 
            ylabel('Ladybug')
            xlabel('time (sample)')
       
            
    vmeanSE(Adetail. perCapitaAdjTS)
    vmeanSE(Ldetail. perCapitaAdjTS)
%% Colonization rate per empty patch (effectitve colonization  in the field)
 figure
    subplot(2,1,1)
            myplot(1:5, Adetail. perPatchTS,'S');
            title('Colonization rate per empty patch ')
            ylabel('aphid')
    subplot(2,1,2)
            myplot(1:5, Ldetail. perPatchTS,'S', 2);  
           ylabel('Ladybug')
            xlabel('time (sample)')
    vmeanSE(Adetail. perPatchTS)
    vmeanSE(Ldetail. perPatchTS)