% Include multiple dispersal event in one time step (i.e. day)
%
% update 2015/10/13: dispersal rate devide by number of events
% update 2015/10/14: correct error on predator dispersal rate function
% update 2015/10/15: make it a smooth dfunction

function xt3 = iva_disper_6(xt2, event)
% [event]       : the number of dispersal event per simulation time step
global H_thH H_thP dH dP dPz dHz np DispH DispP B
% [H_thH]     : the threshhold for aphid dispersal
% [H_thP]     : the threshold of aphid for predator dispersal
% [dHz],[dH]  : base line, and additional dispersal (emigration) rate of H
% [dPz],[dP]  :                                                          P
% [np]        : number of patch
% [DispH]     : dispersal matrix for herbivore
% [DispP]     : dispersal matrix for predator
% need [round_rand], [mylottery]
 Xhtn = xt2; % the non-disperser in number
 
 for itt = 1:event
        Xhh = zeros(np,2,np); % disperser hoovering on the cloud in number    
%%%%%%%%%%%%%%%%%%%%%%%%%%  Herbivore   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=1; % herbivore 
        for p = 1:np % each patch
                D_Real = (  dH / ( 1 + exp(-1 * B * ( Xhtn(p,s) - H_thH) ) + dHz ) ) /event;
           % D_Real = ((dH * (Xhtn(p,s) >= H_thH) ) + dHz)/event; % realized dispersal rate for herbivore
        % Disperssal dicision: made for each individual
            Xdn = binornd(Xhtn(p,s),D_Real); % disperser in number
             if Xdn>0
                Xhtn(p,s) = Xhtn(p,s)-Xdn; % leaving patch
                    for i=1:Xdn  % each disperser hoover to one patch
                    W = mylottery(1:np,DispH(:,p));% each emmigrant pick one site to settle
                    Xhh(W,s,p) = Xhh(W,s,p) + 1; % add one individual to the hovering group
                    end % end for i
              end % end if
        end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Predator   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=2; % Predator 
        for p = 1:np % each patch
                 D_Real = (  (dPz + dP) - dPz / ( 1 + exp(-1 * B * ( Xhtn(p,s) - H_thP) )  ) ) /event;
           % D_Real = ((dP * (Xhtn(p,s) <= H_thP) ) + dPz)/event; % realized dispersal rate for herbivore
        % Disperssal dicision: made for each individual
            Xdn = binornd(Xhtn(p,s),D_Real); % disperser in number
             if Xdn>0
                Xhtn(p,s) = Xhtn(p,s)-Xdn; % leaving patch
                    for i=1:Xdn  % each disperser hoover to one patch
                    W = mylottery(1:np,DispP(:,p));% each emmigrant pick one site to settle
                    Xhh(W,s,p) = Xhh(W,s,p) + 1; % add one individual to the hovering group
                    end % end for i
              end % end if
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xhtn = (Xhtn + sum(Xhh,3)); % the hovering group settle down
                                          % Xhtn become the new starting point
 end
 
 xt3 = Xhtn;% output after all iteration. 
