function xt2=iva_dscrt_6(xt,BDofP)
% Updata 2015/09/28: change name to iva_dscrt_6 for consistency
% Update 2015/09/23: add an Input [BDofP], specify whether to add predator demography
% version 5.0,  2015/09/07
% making it a local dynamics function; model is reduced 
% include predator demographic
% xt(p,s): species s at patch p
% species 1:V (plant); 2: H (herbivore); 3:P (Predator)
global np gH eP mH mP stoc_mH stoc_mP KH H_0 aP
% [np]      :the number of patches
% [mH]      :the average  motality of herbivore
% [gH]      :the constant percapita growth rate of herbivore
% [eP]      :consumption rate of predator on herbivore 
% [stoc_mH] :degree of stochasticity
% Hn =xt(n,1);  Pn=xt(n,2); 
xt2=xt;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:np
mHi = mH * stoc_mH *(rand<(1/stoc_mH)) ; % mortality for this step this patch
mPi = mP * stoc_mP *(rand<(1/stoc_mP)) ; 
 xt2(i,1) = xt(i,1) + gH*xt(i,1)*(KH - xt(i,1))/KH - eP*xt(i,1)*xt(i,2)/(xt(i,1) + H_0) - mHi*xt(i,1); 
    % local dynamics of Predator
    if BDofP==1
       xt2(i,2) = xt(i,2) + aP * eP*xt(i,1)*xt(i,2)/(xt(i,1) + H_0) - mPi*xt(i,2);
    end
end
xt2(xt2<0)=0;

