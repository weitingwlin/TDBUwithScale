## The model

* withBDofP : whether with local dynamics (Birth and Death) of Predator 
 + = 0;  for scenario 1
 + = 1;  for scenario 2
* DisperEvent : number of dispersal event within a day (a sample event)
 + = 1;
* gH : The intrinsic growth rate of herbivore
 +  = 0.2
* eP      consumption rate of herbivore by predator
 + = 1.5  
 + 
* H_0 : half saturate  
 + = 30;
* aP: assimilation rate
 + = 0.25
 + robusteness test: 0.15, 0.35
* KH : carrying capacity of H
 + = 200
* mH 
 + = 0.1
* mP 
 + = 0.1
* stoc_mH 
 + = 2
* stoc_mP 
 + = 2
* dH 
 + = 0.05
* dHz 
 + = 0.05
* dP 
 + = 0.6
* dPz 
 + = 0.3
* sH: body size ~mg
 + = 1
* sP: body size 20*sH is realistic 
 +  = 20
* H_thH 
 + = 100
* H_thP 
 + = 15
* cP: dispersal parameter c for P , small number means long distance travel
  + = 0.2   
  +  robusteness test: 0.3, 0.1   
* cH       % dispersal parameter c for H Dispersal matrix
  +  = 0.1
* B : smoothness of the dispersal threshhold function
  + = 0.25 
