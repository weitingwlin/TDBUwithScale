
# coding: utf-8

# In[71]:


import numpy as np

def p_string(p, digit = 3, limit = None):
    '''
    e.g.
    null = np.random.randn(1000)
    x = 5
    pval_bootstrap(x, null)
    '''
    
    form = '{:.'+str(digit)+'f}' # format
    
    if (limit is not None) and (p == 0):
        p_str = 'p < ' + str(limit)
    else:
        p_str = 'p = ' + n.format(p)
            
    return p_str

def pval_bootstrap(x, x_null, tail=1, out_string = True):
    it = len(x_null)
    pctile =  (sum(x_null < x) + sum( x_null == x ) * 0.5) / it;
  
    p = min(pctile, 1 - pctile);
    
    if (out_string is True):
        p = p_string(p, limit = 1/it)
    return p

