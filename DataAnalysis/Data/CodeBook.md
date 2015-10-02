#Overview
 This data set is the experiment data for scale-dependent predator-prey interaction in an aphid-ladybug system. The experiment was done May/17~June/26, 2014 on Sepelo Island.
 In the experiment, 81 potted plants were arranged in a fractal-designed triangular array, and ~9 ladybugs were each randomly stocked on one plant. The ladybugs, aphids (naturally colonized) and a few other species were counted daily for each plant.
 
### Data files
 * DataLA.txt:  
  Data for the insects count on each plant for each day in the experiment.  Name of variables are stored in ColumnNames.txt
   There are 13 columns, 2754 rows (observation data for 34 days x 81 plants)

 * ColumnNames.txt:   
 Name of variables (columns) for data stored in DataLA.txt

### Variables

* code1~code4 : the 4-digit code for the location of plant. value:1~3.
  + *code1*  indicate which of the 3 27-plant set the plant is in; 
  + *code2*  indicate which of the 3 9-plant set the plant is in (within the 27-plant set specified by code1); 
  + *code3* indicate which of the 3 3-plant set the plant is in (within the 9-plant set specified by code1 and code 2); and 
  + *code4* indicate which of the 3 location the plant is.
 
* PlantID: The plant (clone of _Iva fructescens_, potted)  used in the experiment. Because a few plant was been changed throughout the experiment, so for a certain location, plant ID could be changed. 

* day: day since the first day of observation. Value: 1 (for 2014/05/17) ~ 41 (for 2014/06/26)
 
* aphid: number of aphid found on the plant.

* ladybug: number of adult spotless ladybug _Cycloneda sanguinea_ found on the plant.

* molt: number of ladybug pupa found on the plant

* larva: number of ladybug larva found on the plant
 
* spider: number of spider (species not identified) found on the plant
 
* ant: number of ant (species not identified) found on the plant

* otherLadybug: number of other species of ladybug (species not identified) found on the plant
