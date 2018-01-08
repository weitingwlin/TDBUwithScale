function xt2=iva_dscrt_6(xt,BDofP)
% xt(p,s): species s at patch p
% species 1: H (herbivore); 
%            2: P (Predator)
global np gH eP mH mP stoc_mH stoc_mP KH H_0 aP
% [np]            :the number of patches
% [mH]          :the average  motality of herbivore
% [gH]           :the constant percapita growth rate of herbivore
% [eP]            :consumption rate of predator on herbivore 
% [stoc_mH] :degree of stochasticity
% Hn =xt(n,1);  Pn=xt(n,2); 
xt2 = xt;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:np
    % Stochastic mortality functions
        mHi = mH * stoc_mH *(binornd(1, 1/stoc_mH)) ; % mortality for this step this patch
        mPi = mP * stoc_mP *(binornd(1, 1/stoc_mP)) ; 
    % local dynamics of Herbivore
        xt2(i,1) = xt(i,1) + gH*xt(i,1)*(KH - xt(i,1))/KH - eP*xt(i,1)*xt(i,2)/(xt(i,1) + H_0) - mHi*xt(i,1); 
    % local dynamics of Predator
        if BDofP == 1 % scenario 2
        xt2(i,2) = xt(i,2) + aP * eP*xt(i,1)*xt(i,2)/(xt(i,1) + H_0) - mPi*xt(i,2);
        end
end
xt2(xt2<0) = 0; 

