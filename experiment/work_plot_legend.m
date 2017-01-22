
h2 = myplot([2 2], [1 2], 'L', mycolor(4, 'gray')); hold on
     set(h2,'linewidth',5);  
h3 = myplot(2,1.5, 'S',1.5)
     set(h3,'markersize',6,'linewidth',2);  
 h1 = myplot(2,1.3, 'S',1); hold on
 
 axis([1 5 0 3])
 %%
 legend('CI','median of null model','experimental or model data')
 %%
  legend('CI','median of null model','model data')