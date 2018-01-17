
# coding: utf-8

# In[1]:


import numpy as np

import matplotlib.pyplot as plt
# from multiprocessing import Pool
from utility import pval_bootstrap
from utility import p_string
import pandas as pd



def TDBU_plot(out, pval_show = True, pval_h = [0.1, 0.1]):

    fig, ax = plt.subplots(2,1, sharex=True, figsize=(5, 5))
#td
    ciTD = out["ciTD"] * (-1)
    realTD = out["realTD"] * (-1)
    ax[0].axhline(y =0,linewidth=2, color='gray')
    ax[0].set_ylabel(r'$R_{TD}$', rotation = 0, fontsize=15, labelpad = 20)
    lines = []
    dots = []
    meds = []
#
    for s in range(4):
        line, = ax[0].plot([s+1,s+1], ciTD[[0,2],s] , '-', lw=4,color = '#999999',label='95% CI')
        lines.append(line)
        med, = ax[0].plot([s+1], ciTD[1,s], 'o', lw=4, color='black', mfc='#999999', label='null median')
        meds.append(med)
        dot, = ax[0].plot([s+1], realTD[0,s], 'o', lw=4,color = 'black', label='data')
        dots.append(dot)
    if pval_show:
        for i,j in enumerate([0,3,5]):
            ax[0].text(i + 1.5, pval_h[0], p_string(out['pdiffTD'][0,j], limit = 1/10000), verticalalignment='center', horizontalalignment='center')
# bu
    ciBU = out["ciBU"]
    realBU = out["realBU"]
    ax[1].axhline(y =0,linewidth=2, color='gray')
    ax[1].set_ylabel(r'$R_{BU}$', rotation = 0, fontsize=15, labelpad = 20)
    for s in range(4):
        line, = ax[1].plot([s+1,s+1], ciBU[[0,2],s] , '-', lw=4,color = '#999999',label='95% CI')
        lines.append(line)
        med, = ax[1].plot([s+1], ciBU[1,s], 'o', lw=4, color='black', mfc='#999999', label='null median')
        meds.append(med)
        dot, = ax[1].plot([s+1], realBU[0,s], 'o', lw=4,color = 'black', label='data')
        dots.append(dot)
    if pval_show: 
        for i,j in enumerate([0,3,5]):
            ax[1].text(i + 1.5, pval_h[1], p_string(out['pdiffBU'][0,j], limit = 1/10000),                verticalalignment='center', horizontalalignment='center')
    plt.xticks( np.arange(1,5), ('1-plant', '3-plant', '9-plant', '27-plant') , fontsize=13)
    plt.xlim(0.5,4.5)
    plt.xlabel("Spatial scale", fontsize=15, labelpad = 20)
    #plt.show()
    plt.tight_layout()

    return fig, ax
#ax[0].legend(loc='lower left')
#ax[1].legend(loc='lower left')
