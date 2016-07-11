# Iva visual sample 2013
I marked 44 patches of _Iva fructescen_ on Sapelo island in summer 2013, took basic patch measurements and preliminary survey. 


## workspace data

* **fieldData.mat** : 
  Compiled data, compiled from **data files** (text file) using **script_compile2013.m**. Used in later analyses. 

  Detailed variable information see **data files**. 

> ##### workspace variables
   + **Date** : 
     Date of each observation, in numeric, to display use **datestr** function. 
   + **InsectData** : 
     Column 1~2 is site and patch of observation; 3 is part of the patch sampled, 4~16 is insect count for each observation. The date od obseervation is stored in **Date**. 
   + **InsectDataNames** : 
     Variable Names for columns in **InsectData**.
   + **InsectFreq** : 
     Average insect counts across days for each patch each species. 
   + **PatchData** : 
     Patch quality metrics for the 38 patches used in 2014.
   + **PatchDataNames** : 
     Variable Names for columns in **PatchData**.
   + **P** : 38, number of patches.

---


## data files

* **InsectData** :
  The insect counts from the visual survey (every 3 dayes from about 1/Jun~29/Jul summer 2014). Dates of each observation saved in **InsectSampleDate**.

* **InsectDataNames** :  
  Variable Names for columns in **InsectData**.

> ##### variables
   + **site_code** : Code for the 3 sites sampled. 
   	+ 1 : Dike
   	+ 2 : Airport
   	+ 3 : Lighthouse 
   + **patch_code** : Code for patches (within each site) sampled.      
   + **part_sampled** : proportion of the patch that are searched for  insects. In the 2014 survey all patches were sampled fully so the value is 1. 
>
> (column 4~19 are insect counts)
> 
   + **spider** : Number of spiders found. Species not identified.
   + **ant** : Number of ants found. Species not identified.
   + **ophraella** : number of Orphulella pelidna
   + **paria** : number of Paria aterrima
   + **aphids** : Number of aphid _Uroleucon ambrosiae_ found.
   + **hesperotettix** : Number of grasshopper _Hesperotettix floridensis_ found.
   + **other_grasshopper** : Number of grasshoppers other than (Hesperotettix) found. Species not identified.
   + **plant_hoppers** : Number of planthoppers found. Species not identified. 
   + **micrutalis** : tree hopper (_Micrutalis calva_).
   + **cryptolaemus** : number of small beetle _Cryptolaemus sp._ found. Species not identified.
   + **ladybug_septempunctata** : number of 7-spot ladybug _Coccinella septempunctata_ found.
   + **ladybug_cycloneda** : number of spotless ladybug _Cycloneda sanguinea_ found. 
   + **ladybug_Naemia** :  number of ladybug _Naemia sp._ found. Species not identified.
   + **smallwhite_ladybug** : number of fungus-eating ladybugs _Psyllobora  sp._ species not identified.
   + **pupa** : Number of ladybug pupa found. Species not identified. But the most abundant ladybug in this area is Cycloneda.
   + **larva** : Number of ladybug larva found. Species not identified.
	

--  

* **PatchData** : 
  The measurements of patch quality for all 42 patches marked in 2013.
  Names of variable saved in **PatchDataNames**. Missing values: "999".

* **PatchDataNames** : 
  Variable Names for columns in **PatchData**.

> ##### variables
  + **site_code** : Code for the 3 sites sampled. 
   	+ 1 : Dike
   	+ 2 : Airport
   	+ 3 : Lighthouse 
  + **patch_code** : Code for patches (within each site) sampled.
  + **latitude** : GPS coordinate. Taken in 2015.   
  + **longitude** : GPS coordinate.   
  + **length** : length of patch. Taken in 2013.  
  + **width** : width of patch. (perpendicular to **length**)  Taken in 2013.   
  + **area** : estimated area of patch: length * width   
  + **hight** : hight of patch. measure the highest point.  Taken in 2013.    
  + **distance\_to_nearest** : Distance to the nearest _Iva fructescen_ patch. Taken in 2013.    
  + **shade_level** : 0~5 levels of shading. Taken in 2013.
    + 0: patch not shaded in all observations.
    + 1~5: patch shadowed at at least one observation, and classified into 5 levels base on the observation most close to noon (13:00)     
  + **noon_shade** : The percentage of patch shaded on the observation most close to noon (13:00). Taken in 2013.    
  + **surround_mud** :  Percentage of surrounding environment as mud. Taken in 2013. Note that the four "surround_" variables may not sum to 1 because there were other types (e.g. _Juncus sp._).
  + **surround_borrichia** : Percentage of surrounding environment as _Borrichia frutescens_ Taken in 2013.  
  + **surround_dry** : Percentage of surrounding environment as dry land. Taken in 2013. 
  + **surround_grass** : Percentage of surrounding environment as grass land. Taken in 2013. 
  + **salinity** : Soil salinisy measured from a core sample. Taken in 2015. 
   
---

* **InsectSampleDate** : 
  Date of each observation, in strings. Rows correspond to rows in **InsectData**.


## Raw data

