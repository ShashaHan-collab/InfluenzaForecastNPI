# this script choose the best L/mu/delta for the mask model
from numpy.core.numeric import Inf
import pandas as pd
from sklearn import linear_model
from utils import *
import numpy as np
import os
from sklearn.linear_model import LinearRegression


def calr2(y_true, y_pred):
    return 1-((y_true - y_pred) ** 2).sum()/((y_true - y_true.mean()) ** 2).sum()


def main():
    import argparse
    parser = argparse.ArgumentParser()

    parser.add_argument("--ymask", type=str)
    parser.add_argument("--haty", type=str)
    parser.add_argument("--start", type=int)
    parser.add_argument("--end", type=int)
    parser.add_argument("--fitintercept", action='store_true')
    parser.add_argument("--vaccine", type=str)
    parser.add_argument("--vaccinestart", type=int)
    parser.add_argument("--r2type", type=str, default='haty')
    parser.add_argument("--model", type=int, default=1)

    args = parser.parse_args()
    paras = vars(args)

    start = paras['start']
    end = paras['end']
    vaccinestart = paras['vaccinestart']
    resultdf = pd.DataFrame()
    alphas = [0, 0.01, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5]
    deltas = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
    thetas = [0, 0.01, 0.05, 0.1, 0.5]
    vaccinedf = pd.read_csv('data/vaccine.csv', index_col=0, header=0)
    vaccine_data = vaccinedf.loc[vaccinestart:end, paras['vaccine']].values

    for theta in thetas:
        for delta in deltas:
            ymaskdf = pd.read_csv(
                'data/'+paras['ymask']+'.csv', header=0, index_col=0)
            hatydf = pd.read_csv(
                'data/'+paras['haty']+'.csv', header=0, index_col=0)

            if paras['model'] == 1:
                vaccine_cpl = np.maximum(1-theta*vaccine_data, 0.5)-delta
            elif paras['model'] == 2:
                vaccine_cpl = np.maximum(1-theta*vaccine_data, delta)
            ymaskdf.loc[vaccinestart:end, 'cpl'] = vaccine_cpl
            fitintercept = paras['fitintercept']
            trainidx = ymaskdf.loc[start:end, :].index
            maxl = 0
            maxr2 = -Inf
            coef = 0
            intercept = 0
            bestraw = pd.DataFrame()
            for l in range(1, 53):
                rawdf = ymaskdf.copy()
                for idx in trainidx:
                    indicator = get_lag_rate(
                        l-1, idx, rawdf, 'forward', 't2')
                    compliance = get_lag_rate(
                        l-1, idx, rawdf, 'forward', 'cpl')
                    rawdf.loc[idx, 'sumd'] = np.sum(
                        indicator*compliance)+rawdf.loc[idx, 't2']*rawdf.loc[idx, 'cpl']
                lmodel = LinearRegression(fit_intercept=fitintercept)
                xtrain = rawdf.loc[trainidx, 'sumd'].values.reshape(-1, 1)
                ytrain = np.log(
                    rawdf.loc[trainidx, 'positive_rate'].values/hatydf.loc[trainidx, '0'].values)
                lmodel.fit(xtrain, ytrain)

                if paras['r2type'] == 'haty':
                    ytrue = rawdf.loc[trainidx, 'positive_rate'].values
                    ypred = np.exp(lmodel.predict(xtrain)) * \
                        hatydf.loc[trainidx, '0'].values
                    r2 = calr2(ytrue, ypred)
                elif paras['r2type'] == 'log':
                    r2 = lmodel.score(xtrain, ytrain)

                if r2 > maxr2:
                    maxr2 = r2
                    maxl = l
                    coef = lmodel.coef_[0]
                    intercept = lmodel.intercept_ if fitintercept else 0
                    bestraw = rawdf.copy()
            print('result for '+paras['ymask'] + " starting from "+str(
                start)+' and theta=' + str(theta) + ' and delta=' + str(delta))
            print("max L = " + str(maxl))
            print("tau: "+str(coef))
            print("intercept: "+str(intercept))
            print("fit r2: "+str(maxr2))
            data = {'region': paras['ymask'], 'start': start, 'end': end,
                    'mu': theta, 'delta': delta, 'maxL': maxl, 'tau': coef, 'intercept': intercept, 'r2': maxr2}
            resultdf = resultdf.append(data, ignore_index=True)
    resultdf.to_csv('result/'+paras['ymask'] + " starting from "+str(
        start)+'with r2type='+paras['r2type']+' and model='+str(paras['model'])+'.csv', index=True, header=True)


if __name__ == "__main__":
    main()
