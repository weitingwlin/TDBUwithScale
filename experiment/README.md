# DataAnalysis
This is the experimental/empirical part of my PhD project about predator-prey interaction.

## Data
Data are stored in a folder 'Data'

* **./Data/DataLA.txt** :
Data for the insects count on each plant for each day in the experiment. Name of variables are stored in ColumnNames.txt. The compiled data are stored in TDBU_expData.mat

* **./Data/ColumnNames.txt**:   
Name of variables (columns) for data stored in DataLA.txt

* **TDBU\_expData.mat** : 
In each data matrix, there are 13 columns, 2754 rows (observation data for 34 days x 81 plants)


## Matlab scripts
* **script\_compile.m** : 
the script that loads in data from ./Data/DataLA.txt and ./Data/ColumnNames.txt, and create data matrix for each taxa. Outputs are 81 x 34 matrices.                     

* **work\_CI\_TDBU.m** : 
the script that readcompiled data (81 plant x 34 day), simulate null  model,  calculate CI of the TD, BU indices from null model, and make the CI figure. 

* **work\_CI\_TDBU\_ln.m** : 
the script that readcompiled data (81 plant x 34 day), simulate null model,  calculate CI of the TD, BU indices (with log-transformed aphid population) from null model, and make the CI figure. 

* **work\_supplement.m** : 
The script to produce supplement figures. Including :  example TS, overall trend, example 'scaling up', effect of spider, effect of larva and other species, number of egg clutches and newly hatched larva.

* **work\_supplement\_trend.m** : 
The script to produce supplement figure with overall trend,

* **work\_robust.m** : 
The script that do the robust analysis of TDBU empirical data.
Split the data into two subsets, on each do the analysis as in **work\_Ci\_TDBU.m**

* **work\_setup.m** : set path and toolbox.

* **work\_otherthingsCV** : 
The script that calculate coefficient of variation (CV) for ladybug and aphids at each scale, and make the figure.                     

* **work\_plant.m** : load plant data and analysis

