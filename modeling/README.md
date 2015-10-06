The file in this repo require my matlab utility files.

https://github.com/wildwolflin/utilityMatlab.git

------------------
* run_iva_6.m : 
  working file. set parameters, run simulation, save result and write a document. Dependent: iva_disper_6.m, iva_discrt_5.m, script_simulationData.m,D_mat2.mat 

* iva_disper_6.m : 
  function: run dispersal 

* iva_dscrt_6.m : 
	the main function for local demographic dynamics

* script_simulationData.m : 
	the script that print parameters in workspace into a text file

* work_iva_TDBU_5.m :
	Do the null model permutation and visualize the results

* work_explore_TDBU.m :
	Visualize simulation results

* make_D_mat2.m : 
	the script to make D_mat2.mat , and make plot for the landscape.
 	
* D_mat2.mat:
	The (x,y) cordinate for 81 simulated patches. 

* /data :
	the folder for simulated data and their log (parameters printed in text file)
