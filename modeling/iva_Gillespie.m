function [t, X] =iva_Gillespie(X0, tlim)
%% global parameters
% global  gH eP aP mH mP stoc_mH stoc_mP dH dP sH sP H_thH H_thP KH dHz dPz H_0 DispH DispP B withBDofP
script_Gillespie_parameters
%% process (per patch)
v = [];
v{1} =  [1  0];  % birth of Herbivore
v{2} = [-1 0];  % death of Herbivore
v{3} = [0  1];  % birth of Predator
v{4} = [0  -1]; % death of Predator
v{5} = [-1  0]; % Emigration of Herbivore
v{6} = [0  -1]; % Emigration of Predator
v{7} = [0  0]; % a pseudo-event: maintain extinct
nv = 6; % number of event
%%
 P = 81; S = 2; % number of patches, number of species
 t = zeros( 1e5, 1 );   % 
 X = zeros( P,S, 1e5 );
 X( :, :, 1 ) = X0; 
 point = 1;     
 L = reshape( 1 : nv*P, nv, P ); % event locator, used later   
%%
while t(point) < tlim    
    % 1. calculate rate of each event (for each patch)
          rates = [];
    for p = 1:P    % calculate event rate for each patch
          nA = X(p, 1, point); % Herbivore
          nB = X(p, 2, point); % Predator
          temp = [gH * nA, ...
                     gH/KH*nA^2 + (eP/(nA + H_0))*nA*nB*sP + mH* stoc_mH *(binornd(1, 1/stoc_mH))*nA, ...  
                     aP*(eP/(nA + H_0))*nA*nB *withBDofP, ...
                     mP * stoc_mP *(binornd(1, 1/stoc_mP)) * nB *withBDofP, ...  
                     dHz *nA + (dH/ (1+ exp((-1)*B* (nA - H_thH)) ) ) * nA,...
                     (dPz + dP) *nB - (dP/ (1+ exp((-1)*B* (nA - H_thP)) ) ) * nB ]; 
          rates = [rates, temp]; 
    end
    %   reshape( rates, nv, P );
        a0 = sum(rates, 2); % the rate that "any" event happens
    
    % 2. inter event time
        t(point+1) = t(point) + log(1/rand)/a0; % Calculating the interevent time.
    % 3. witch event
     %   eventID = datasample(1:2, 1, 'weight', rates); 
        if a0 > 0
            eventID = min(find(rand < cumsum(rates/a0))); 
             [event, patch] = find( L == eventID ); % which of the 6 "events" in which "patch"
        else
            t(point + 1) = tlim; % end the simulation
            event = 7; patch = 1; % nothing happen
        end
     % 4. update state                                       
         X(:,:, point+1) = X(:, :, point);
         X(patch, : , point + 1) = X(patch, :, point) + v{event}; % Updating the state.
         % if the event is dispersal, we also update the state of the
         % setination site
         if event == 5 % Herbivore disperse
             dest_patch = datasample( 1:P, 1, 'weight', DispH(patch, :) ); % chose a destination patch
             X(dest_patch, : , point + 1) = X(dest_patch, :, point + 1) - v{event};  % add immigrant
         end
          if event == 6 % Predator disperse
              if rand > exitP
             dest_patch = datasample( 1:P, 1, 'weight', DispP(patch, :) ); % chose a destination patch
             X(dest_patch, : , point + 1) = X(dest_patch, :, point + 1) - v{event};  % add immigrant
              end
         end
    % 5. update the point counter.
        point = point + 1;  
end
%%
% The last thing we do is get rid of the memory that was not use during the
% simulation and we are done.
t = t(1:point);
X = X(:,:, 1:point);