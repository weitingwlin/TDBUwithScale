
# coding: utf-8

# In[1]:


import numpy as np
from numba import jit
from scipy import stats
import matplotlib.pyplot as plt
# from multiprocessing import Pool
from utility import pval_bootstrap
from utility import p_string
import pandas as pd
import time
import sys


# In[2]:


def col_shuffle(data, replacement=True):
    '''
    shuffle each columns in matrix 
    '''
    (n, p) = np.shape(data)
    sh_data = np.zeros((n, p))
    for i in range(p):
        # per column
        sh_data[:,i] = np.random.choice(data[:,i], n, replace = replacement)
    return sh_data


# In[3]:


def mat_shuffle(data, replacement = True):
    shape = data.shape
    data_sh = np.random.choice(data.reshape(-1), shape, replace=True)
    return data_sh


# In[4]:


def TDBU_scale_TS(data_A, data_L, Day):
    '''
    This is a function to create time series (TS) for each set of each scales \
    from (real or simulated) TS of aphids and ladybugs
    '''
    nd = len(Day)
    L3 = np.zeros((27,nd))
    A3 = np.zeros((27,nd))
    L9 = np.zeros((9,nd))
    A9 = np.zeros((9,nd))
    L27 = np.zeros((3,nd))
    A27 = np.zeros((3,nd))
    out = {}
    # 3-plant scale
    for i in range(27):
        ind = np.arange(i*3,(i+1)*3)
        L3[i,:] = np.sum(data_L[ind,:], axis = 0, keepdims = True)
        A3[i,:] = np.sum(data_A[ind,:], axis = 0, keepdims = True)
    # 9-plant scale
    for i in range(9):
        ind = np.arange(i*9,(i+1)*9)
        L9[i,:] = np.sum(data_L[ind,:], axis = 0, keepdims = True)
        A9[i,:] = np.sum(data_A[ind,:], axis = 0, keepdims = True)
    # 27-plant scale
    for i in range(3):
        ind = np.arange(i*27,(i+1)*27)
        L27[i,:] = np.sum(data_L[ind,:], axis = 0, keepdims = True)
        A27[i,:] = np.sum(data_A[ind,:], axis = 0, keepdims = True)
        
    # packing results into a dictionary 
    out["L3"] = L3
    out["A3"] = A3
    out["L9"] = L9
    out["A9"] = A9
    out["L27"] = L27
    out["A27"] = A27
    return out


# In[5]:


def TDBU_scale_logreg(dataA, dataL, Day):
    nd = len(Day)
    out = TDBU_scale_TS(dataA, dataL, Day)
    
    # umpack TS 
    A3 = out["A3"]
    L3 = out["L3"]
    A9 = out["A9"]
    L9 = out["L9"]
    A27 = out["A27"]
    L27 = out["L27"]
    
    # data sheets
    MA_L_1 = np.zeros((81, nd))
    DF_L_1 = np.zeros((81, nd))
    MA_A_1 = np.zeros((81, nd))
    DF_A_1 = np.zeros((81, nd))
    MA_L_3 = np.zeros((27, nd))
    DF_L_3 = np.zeros((27, nd))
    MA_A_3 = np.zeros((27, nd))
    DF_A_3 = np.zeros((27, nd))
    MA_L_9 = np.zeros((9, nd))
    DF_L_9 = np.zeros((9, nd))
    MA_A_9 = np.zeros((9, nd))
    DF_A_9 = np.zeros((9, nd))
    MA_L_27 = np.zeros((3, nd))
    DF_L_27 = np.zeros((3, nd))
    MA_A_27 = np.zeros((3, nd))
    DF_A_27 = np.zeros((3, nd))
    BU = np.zeros((1,4))
    TD = np.zeros((1,4))
    
    # initialize t:
    t = 0
    for d in range(0, nd-1):
        if (Day[d+1] - Day[d]) == 1: 
            # two consecutive days

            # 1-day 
            MA_L_1[:,t] = np.mean(dataL[:, [d, d+1]], axis =1);
            DF_L_1[:,t] = np.diff(np.log(dataL[:,[d, d+1]] + 1), axis =1).reshape(81);
            MA_A_1[:,t] = np.mean(dataA[:, [d, d+1]], axis =1);
            DF_A_1[:,t] = np.diff(np.log(dataA[:,[d, d+1]] + 1), axis =1).reshape(81);
            
            # 3-day 
            MA_L_3[:,t] = np.mean(L3[:, [d, d+1]], axis =1);
            DF_L_3[:,t] = np.diff(np.log(L3[:,[d, d+1]] + 1), axis =1).reshape(27);
            MA_A_3[:,t] = np.mean(A3[:, [d, d+1]], axis =1);
            DF_A_3[:,t] = np.diff(np.log(A3[:,[d, d+1]] + 1), axis =1).reshape(27);
            
            # 9-day 
            MA_L_9[:,t] = np.mean(L9[:, [d, d+1]], axis =1);
            DF_L_9[:,t] = np.diff(np.log(L9[:,[d, d+1]] + 1), axis =1).reshape(9);
            MA_A_9[:,t] = np.mean(A9[:, [d, d+1]], axis =1);
            DF_A_9[:,t] = np.diff(np.log(A9[:,[d, d+1]] + 1), axis =1).reshape(9);
            
            # 27-day 
            MA_L_27[:,t] = np.mean(L27[:, [d, d+1]], axis =1);
            DF_L_27[:,t] = np.diff(np.log(L27[:,[d, d+1]] + 1), axis =1).reshape(3);
            MA_A_27[:,t] = np.mean(A27[:, [d, d+1]], axis =1);
            DF_A_27[:,t] = np.diff(np.log(A27[:,[d, d+1]] + 1), axis =1).reshape(3);

            t = t+1;
    
    # remove double zeros: keep data where at least one species present
    ind1 = (MA_L_1 != 0) *1 + (MA_A_1 != 0)*1 > 0
    ind3 = (MA_L_3 != 0) *1 + (MA_A_3 != 0)*1 > 0
    ind9 = (MA_L_9 != 0) *1 + (MA_A_9 != 0)*1 > 0
    ind27 = (MA_L_27 != 0) *1 + (MA_A_27 != 0)*1 > 0
    
    # calculating R_TD and R_BU
    _, _, r_value, _, _ = stats.linregress(MA_A_1[ind1], DF_L_1[ind1])
    BU[0,0] = r_value
    _, _, r_value, _, _ = stats.linregress(MA_L_1[ind1], DF_A_1[ind1])
    TD[0,0] = r_value
    _, _, r_value, _, _ = stats.linregress(MA_A_3[ind3], DF_L_3[ind3])
    BU[0,1] = r_value
    _, _, r_value, _, _ = stats.linregress(MA_L_3[ind3], DF_A_3[ind3])
    TD[0,1] = r_value
    _, _, r_value, _, _ = stats.linregress(MA_A_9[ind9], DF_L_9[ind9])
    BU[0,2] = r_value
    _, _, r_value, _, _ = stats.linregress(MA_L_9[ind9], DF_A_9[ind9])
    TD[0,2] = r_value
    _, _, r_value, _, _ = stats.linregress(MA_A_27[ind27], DF_L_27[ind27])
    BU[0,3] = r_value
    _, _, r_value, _, _ = stats.linregress(MA_L_27[ind27], DF_A_27[ind27])
    TD[0,3] = r_value
    
    
    return TD, BU


# In[6]:



def null_TDBU(dataA, dataL, Day, replacement, func):
    sh_A = func(dataA, replacement = replacement)
    sh_L = func(dataL, replacement = replacement)
    return TDBU_scale_logreg(sh_A, sh_L, Day)


# In[7]:


@jit
def TDBU_bootstrap_logreg_diff(dataA, dataL, Day, itt = 1000, replacement = True, func=mat_shuffle):
    '''
    A function similar to the Matlab one:
    https://github.com/weitingwlin/TDBUwithScale/blob/master/DataAnalysis/TDBU_bootstrap_logreg_diff.m
    '''
    sh_TD = np.zeros((itt, 4))
    sh_BU = np.zeros((itt, 4))
    pTD = np.zeros((1,4))
    pBU = np.zeros((1,4))
    
    realTD, realBU = TDBU_scale_logreg(dataA, dataL, Day)
 #   pool = Pool(4)
 #   callback = CallBack(total=itt)
    for i in range(itt):
#        pool.apply_async(null_TDBU, (dataA, dataL, Day, replacement, func), callback=callback, error_callback=print)
#         sh_A = mat_shuffle(dataA, replacement = replacement )
#         sh_L = mat_shuffle(dataL, replacement = replacement )
       sh_TD[i,:], sh_BU[i,:] = null_TDBU(dataA, dataL, Day, replacement, func)
#         sh_TD[i,:] = outTD
#         sh_BU[i,:] = outBU
#    pool.close()
#    pool.join()
#     # get ci and median
#    res = callback.results
#    for i in range(itt):
#        result = res[i]
#        sh_TD[i, :], sh_BU[i, :] = result[0], result[1]
    
    ciTD = np.percentile(sh_TD, [2.5, 50, 97.5], axis =0)
    ciBU = np.percentile(sh_BU, [2.5, 50, 97.5], axis =0)
     
    for j in range(4):
        pTD[0,j] = pval_bootstrap(realTD[0,j], sh_TD[:,j], tail = 2, out_string = False)
        pBU[0,j] = pval_bootstrap(realBU[0,j], sh_BU[:,j], tail = 2, out_string = False)
        
    # get diff
    ci_diffTD = np.zeros((3,6))
    ci_diffBU = np.zeros((3,6))
    realdiffTD = np.zeros((1,6))
    realdiffBU = np.zeros((1,6))
    p_diffTD = np.zeros((1,6))
    p_diffBU = np.zeros((1,6))
    seq = np.reshape([0,1,0,2,0,3, 1,2, 1,3,2,3], (6,2))
    for s in range(6):
        realdiffTD[0, s] = realTD[0,seq[s, 1]] - realTD[0,seq[s, 0]] 
        diffTDsh = sh_TD[:, seq[s, 1]] - sh_TD[:, seq[s, 0]]  
        ci_diffTD[:,s] = np.percentile( diffTDsh , [2.5, 50, 97.5], axis =0).reshape(3)
        p_diffTD[0,s] = pval_bootstrap(realdiffTD[0,s], diffTDsh, tail = 2, out_string = False)
        # BU
        realdiffBU[0,s] = realBU[0,seq[s, 1]] - realBU[0,seq[s, 0]] 
        diffBUsh = sh_BU[:, seq[s, 1]] - sh_BU[:, seq[s, 0]]  
        ci_diffBU[:,s] = np.percentile( diffBUsh , [2.5, 50, 97.5], axis =0).reshape(3)
        p_diffBU[0,s] = pval_bootstrap(realdiffBU[0,s], diffBUsh, tail = 2, out_string = False)
    ## compile output
    out = {}
    out["realTD"] = realTD
    out["realBU"] = realBU
    out["ciTD"] = ciTD
    out["ciBU"] = ciBU
    out["pTD"] = pTD
    out["pBU"] = pBU
    out["realdiffTD"] = realdiffTD
    out["realdiffBU"] = realdiffBU
    out["cidiffTD"] = ci_diffTD
    out["cidiffBU"] = ci_diffBU
    out["pdiffTD"] = p_diffTD
    out["pdiffBU"] = p_diffBU
    
    return out


# In[33]:




def TDBU_plot(out):
    
    fig, ax = plt.subplots(2,1, sharex=True, figsize=(5, 5))
#td
    ciTD = out["ciTD"] * (-1)
    realTD = out["realTD"] * (-1)
    ax[0].axhline(y =0,linewidth=2, color='gray')
    ax[0].set_ylabel(r'$R_{TD}$', rotation = 0)
    lines = []
    dots = []
    meds = []
#
    for s in range(4):
        line, = ax[0].plot([s+1,s+1], ciTD[[0,2],s] , '-', lw=4,color = '#999999',label='95% CI')
        lines.append(line)
        dot, = ax[0].plot([s+1], realTD[0,s], 'o', lw=4,color = 'black', label='data')
        dots.append(dot)
        med, = ax[0].plot([s+1], ciTD[1,s], 'o', lw=4, color='black', mfc='#999999', label='null median')
        meds.append(med)
    for i,j in enumerate([0,3,5]):
        ax[0].text(i + 1.5, 0.1, p_string(out['pdiffTD'][0,j], limit = 1/10000),                verticalalignment='center', horizontalalignment='center')
# bu
    ciBU = out["ciBU"] 
    realBU = out["realBU"]
    ax[1].axhline(y =0,linewidth=2, color='gray')
    ax[1].set_ylabel(r'$R_{BU}$', rotation = 0)
    for s in range(4):
        line, = ax[1].plot([s+1,s+1], ciBU[[0,2],s] , '-', lw=4,color = '#999999',label='95% CI')
        lines.append(line)
        dot, = ax[1].plot([s+1], realBU[0,s], 'o', lw=4,color = 'black', label='data')
        dots.append(dot)
        med, = ax[1].plot([s+1], ciBU[1,s], 'o', lw=4, color='black', mfc='#999999', label='null median')
        meds.append(med)
    for i,j in enumerate([0,3,5]):
        ax[1].text(i + 1.5, 0.1, p_string(out['pdiffBU'][0,j], limit = 1/10000),                verticalalignment='center', horizontalalignment='center')
    plt.xticks( np.arange(1,5), ('1-plant', '3-plant', '9-plant', '27-plant') )
    plt.xlim(0.5,4.5)
    plt.xlabel("Spatial scale")
    #plt.show()
    plt.tight_layout()

    return fig, ax
#ax[0].legend(loc='lower left')
#ax[1].legend(loc='lower left')

