#Predator-prey dynamic Modeling 
The file in this repo require [my matlab utility](https://github.com/wildwolflin/utilityMatlab.git) files.

## Codes
* **run\_iva\_6.m** : 
  working file. set parameters, run simulation, save result and write a document. Dependent: iva_disper_6.m, iva_discrt_5.m, script_simulationData.m,D_mat2.mat 

* **iva\_disper\_6.m** : 
  function: run dispersal 

* **iva\_dscrt\_6.m** : 
  The main function for local demographic dynamics

* **script\_simulationData.m** : 
  The script that print parameters in workspace into a text file

* **work\_iva\_TDBU\_5.m** :
  Do the null model permutation and visualize the results

* **work\_explore\_TDBU.m** :
  Visualize simulation results

* **make\_D\_mat2.m** : 
  The script to make D_mat2.mat , and make plot for the landscape.

* **work\_plot\_demos.m** : 
  Code that produces plots to illustrate components of models e.g. dispersal function and functional response. 
 
 	
* **D\_mat2.mat**:
  The (x,y) cordinate for 81 simulated patches. 

* **/data** :
  The folder for simulated data and their log (note and parameters printed in text file)



