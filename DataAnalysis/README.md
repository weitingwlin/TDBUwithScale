# Analyse model and empirical data

Both model and empirical data are analized for their TD and BU indices for each spatial scales. And the null model is created by permutation/resampling. 


## Files
* TDBU_scale.m: 
  a function, takes 3 parameters (predator, prey, dayID), and return the mean TDBU indices at each scale.

* TDBU_bootstrap.m : 
  a function, takes 4 or 5 parameters (predator, prey, dayID, itt, replacement), simulate the null model for given data. Iteration time specified by itt, with or without replacement (replacement = 0 as default). 
  Return a structure with related data.