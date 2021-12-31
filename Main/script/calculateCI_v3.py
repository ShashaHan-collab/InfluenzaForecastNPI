# this script cauculates the mean and confidence interval for the effects we are interested in
import pandas as pd
import numpy as np


def calculateCI(basepath, targetpath, basetype, starttime, endtime, tau=False, targettype='', tau_intercept=False, internationalvolume=False, bs=False):
    bstimes = 10000
    np.random.seed(0)
    mean, lower, upper = np.zeros((bstimes,)), np.zeros(
        (bstimes,)), np.zeros((bstimes,))
    result = None
    if internationalvolume:
        # tmpbase=pd.ExcelWriter(basepath+'.xlsx', mode='a')
        # tmpbase = pd.DataFrame(tmpbase.book['neithertwonpis'])
        tmpbase = pd.read_excel(
            basepath+'.xlsx', sheet_name='neithertwonpis', header=0, index_col=0, engine='openpyxl')
    else:
        tmpbase = pd.read_csv(basepath, index_col=0, header=0)

    if 'average' in tmpbase.index.astype(str).values:
        tmpbase.drop(index=['average'], inplace=True)
    if 'lower' in tmpbase.index.astype(str).values:
        tmpbase.drop(index=['lower'], inplace=True)
    if 'upper' in tmpbase.index.astype(str).values:
        tmpbase.drop(index=['upper'], inplace=True)
    if tau_intercept:
        idx = tmpbase.index.values
        if bs:
            result = np.random.choice(
                tmpbase.loc[idx, 'intercept'].values, bstimes, replace=True)
        else:
            result = tmpbase.loc[idx, 'intercept'].values
    elif tau:
        idx = tmpbase.index.values
        if bs:
            result = np.random.choice(
                tmpbase.loc[idx, 'sumd'].values, bstimes, replace=True)
        else:
            result = tmpbase.loc[idx, 'sumd'].values
    elif internationalvolume:
        coefdf = pd.read_csv(targetpath+'.csv', index_col=0, header=0)
        coef = coefdf.loc['average', 'vw']
        mean = coef/tmpbase.loc[starttime:endtime, 'mean'].mean()
        upper = coef/tmpbase.loc[starttime:endtime, 'upper'].mean()
        lower = coef/tmpbase.loc[starttime:endtime, 'lower'].mean()
        median = None
    else:
        tdf = pd.read_csv(targetpath, index_col=0, header=0)
        if basetype == 'positive_rate':
            basedf = pd.DataFrame()
            basedf['0'] = tmpbase['positive_rate']
            basedf.index = tmpbase.index
        else:
            basedf = tmpbase
        if targettype == 'positive_rate':
            targetdf = pd.DataFrame()
            targetdf['0'] = tdf['positive_rate']
            targetdf.index = tdf.index
        else:
            targetdf = tdf

        if bs:
            basecol = np.random.choice(
                basedf.columns.values, bstimes, replace=True)
            targetcol = np.random.choice(
                targetdf.columns.values, bstimes, replace=True)
        else:
            basecol = basedf.columns.values
            targetcol = targetdf.columns.values
        basedf = basedf.loc[starttime:endtime, :]
        targetdf = targetdf.loc[starttime:endtime, :]

        result = np.mean(targetdf.loc[:, targetcol].values -
                         basedf.loc[:, basecol].values, axis=0)

    if not internationalvolume:
        mean = np.mean(result)
        lower = np.percentile(result, 2.5)
        upper = np.percentile(result, 97.5)
        median = np.percentile(result, 50)

    return mean, lower, upper, result, median


resultdf = pd.DataFrame(
    columns=['name', 'mean', 'lowerbound', 'upperbound', 'median', 'starttime', 'endtime'])

cn19s = 202001
cn19e = 202014
cn20s = 202049
cn20e = 202114
cn21s = 202149
cn21e = 202214
cs19s = 202001
cs19e = 202015
cs20s = 202045
cs20e = 202115
cs21s = 202145
cs21e = 202215
uk19s = 202001
uk19e = 202013
uk20s = 202050
uk20e = 202113
uk21s = 202150
uk21e = 202213
usa19s = 202001
usa19e = 202015
usa20s = 202048
usa20e = 202115
usa21s = 202148
usa21e = 202215
hb19s = cn19s
hb19e = cs19e

print('calculating COVID-19 - No COVID')

name = 'Northern China: COVID-19 - No COVID'
starttime = cn19s
endtime = cn19e
basepath = 'data/ci/cnnocovid.csv'
targetpath = 'data/ci/cncovid.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Northern China: COVID-19 - No COVID'
starttime = cn20s
endtime = cn20e
basepath = 'data/ci/cnnocovid.csv'
targetpath = 'data/ci/cncovid.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: COVID-19 - No COVID'
starttime = cs19s
endtime = cs19e
basepath = 'data/ci/csnocovid.csv'
targetpath = 'data/ci/cscovid.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: COVID-19 - No COVID'
starttime = cs20s
endtime = cs20e
basepath = 'data/ci/csnocovid.csv'
targetpath = 'data/ci/cscovid.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: COVID-19 - No COVID'
starttime = uk19s
endtime = uk19e
basepath = 'data/ci/uknocovid.csv'
targetpath = 'data/ci/ukcovid.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: COVID-19 - No COVID'
starttime = uk20s
endtime = uk20e
basepath = 'data/ci/uknocovid.csv'
targetpath = 'data/ci/ukcovid.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: COVID-19 - No COVID'
starttime = usa19s
endtime = usa19e
basepath = 'data/ci/usanocovid.csv'
targetpath = 'data/ci/usacovid.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: COVID-19 - No COVID'
starttime = usa20s
endtime = usa20e
basepath = 'data/ci/usanocovid.csv'
targetpath = 'data/ci/usacovid.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Hubei: COVID-19 - No COVID'
starttime = hb19s
endtime = hb19e
basepath = 'data/ci/hbnocovid.csv'
targetpath = 'data/ci/hbcovid.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)


print('calculating mask - No npi')
name = 'Northern China: mask - No npi'
starttime = cn19s
endtime = cn19e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/ci/cnmask.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Northern China: mask - No npi'
starttime = cn20s
endtime = cn20e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/ci/cnmask.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: mask - No npi'
starttime = cs19s
endtime = cs19e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/ci/csmask.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: mask - No npi'
starttime = cs20s
endtime = cs20e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/ci/csmask.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: mask - No npi'
starttime = uk19s
endtime = uk19e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/ci/ukmask.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: mask - No npi'
starttime = uk20s
endtime = uk20e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/ci/ukmask.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: mask - No npi'
starttime = usa19s
endtime = usa19e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/ci/usamask.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: mask - No npi'
starttime = usa20s
endtime = usa20e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/ci/usamask.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

print('calculating mobility - No npi')
name = 'Northern China: mobility - No npi'
starttime = cn19s
endtime = cn19e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/ci/cnmobility.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Northern China: mobility - No npi'
starttime = cn20s
endtime = cn20e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/ci/cnmobility.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: mobility - No npi'
starttime = cs19s
endtime = cs19e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/ci/csmobility.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: mobility - No npi'
starttime = cs20s
endtime = cs20e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/ci/csmobility.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: mobility - No npi'
starttime = uk19s
endtime = uk19e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/ci/ukmobility.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: mobility - No npi'
starttime = uk20s
endtime = uk20e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/ci/ukmobility.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: mobility - No npi'
starttime = usa19s
endtime = usa19e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/ci/usamobility.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: mobility - No npi'
starttime = usa20s
endtime = usa20e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/ci/usamobility.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

print('calculating npi - No npi')
name = 'Northern China: npi - No npi'
starttime = cn19s
endtime = cn19e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/cni.csv'
basetype = ''
targettype = 'positive_rate'
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, targettype=targettype)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Northern China: npi - No npi'
starttime = cn20s
endtime = cn20e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/cni.csv'
basetype = ''
targettype = 'positive_rate'
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, targettype=targettype)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: npi - No npi'
starttime = cs19s
endtime = cs19e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/csib3.csv'
basetype = ''
targettype = 'positive_rate'
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, targettype=targettype)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: npi - No npi'
starttime = cs20s
endtime = cs20e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/csib3.csv'
basetype = ''
targettype = 'positive_rate'
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, targettype=targettype)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: npi - No npi'
starttime = uk19s
endtime = uk19e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/uk.csv'
basetype = ''
targettype = 'positive_rate'
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, targettype=targettype)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: npi - No npi'
starttime = uk20s
endtime = uk20e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/uk.csv'
basetype = ''
targettype = 'positive_rate'
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, targettype=targettype)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: npi - No npi'
starttime = usa19s
endtime = usa19e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/usa.csv'
basetype = ''
targettype = 'positive_rate'
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, targettype=targettype)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: npi - No npi'
starttime = usa20s
endtime = usa20e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/usa.csv'
basetype = ''
targettype = 'positive_rate'
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, targettype=targettype)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

print('calculating future mask - No npi')
name = 'Northern China: future mask - No npi'
starttime = cn21s
endtime = cn21e
basepath = 'data/ci/cn21nomask.csv'
targetpath = 'data/ci/cn21mask.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: future mask - No npi'
starttime = cs21s
endtime = cs21e
basepath = 'data/ci/cs21nomask.csv'
targetpath = 'data/ci/cs21mask.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: future mask - No npi'
starttime = uk21s
endtime = uk21e
basepath = 'data/ci/uk21nomask.csv'
targetpath = 'data/ci/uk21mask.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: future mask - No npi'
starttime = usa21s
endtime = usa21e
basepath = 'data/ci/usa21nomask.csv'
targetpath = 'data/ci/usa21mask.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

print('calculating future Inbound mobility')
name = 'Northern China: future Inbound mobility'
starttime = cn21s
endtime = cn21e
basepath = 'data/ci/cn21nomask.csv'
targetpath = 'data/ci/cn21mi.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: future Inbound mobility'
starttime = cs21s
endtime = cs21e
basepath = 'data/ci/cs21nomask.csv'
targetpath = 'data/ci/cs21mi.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: future Inbound mobility'
starttime = uk21s
endtime = uk21e
basepath = 'data/ci/uk21nomask.csv'
targetpath = 'data/ci/uk21mi.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: future Inbound mobility'
starttime = usa21s
endtime = usa21e
basepath = 'data/ci/usa21nomask.csv'
targetpath = 'data/ci/usa21mi.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

print('calculating future Domestic mobility')
name = 'Northern China: future Domestic mobility'
starttime = cn21s
endtime = cn21e
basepath = 'data/ci/cn21nomask.csv'
targetpath = 'data/ci/cn21mv.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: future Domestic mobility'
starttime = cs21s
endtime = cs21e
basepath = 'data/ci/cs21nomask.csv'
targetpath = 'data/ci/cs21mv.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: future Domestic mobility'
starttime = uk21s
endtime = uk21e
basepath = 'data/ci/uk21nomask.csv'
targetpath = 'data/ci/uk21mv.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: future Domestic mobility'
starttime = usa21s
endtime = usa21e
basepath = 'data/ci/usa21nomask.csv'
targetpath = 'data/ci/usa21mv.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)


print('calculating tau')
name = 'Northern China: tau'
starttime = 0
endtime = 0
basepath = 'data/ci/cntau.csv'
targetpath = ''
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, tau=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)
name = 'Northern China: exp(tau)'
data = {'name': name, 'mean': np.exp(mean), 'lowerbound': np.exp(lower), 'median': np.exp(median),
        'upperbound': np.exp(upper), 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: tau'
starttime = 0
endtime = 0
basepath = 'data/ci/cstau.csv'
targetpath = ''
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, tau=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)
name = 'Southern China: exp(tau)'
data = {'name': name, 'mean': np.exp(mean), 'lowerbound': np.exp(lower), 'median': np.exp(median),
        'upperbound': np.exp(upper), 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: tau'
starttime = 0
endtime = 0
basepath = 'data/ci/uktau.csv'
targetpath = ''
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, tau=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)
name = 'England: exp(tau)'
data = {'name': name, 'mean': np.exp(mean), 'lowerbound': np.exp(lower), 'median': np.exp(median),
        'upperbound': np.exp(upper), 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: tau'
starttime = 0
endtime = 0
basepath = 'data/ci/usatau.csv'
targetpath = ''
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, tau=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)
name = 'U.S.: exp(tau)'
data = {'name': name, 'mean': np.exp(mean), 'lowerbound': np.exp(lower), 'median': np.exp(median),
        'upperbound': np.exp(upper), 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

print('calculating intercept')
name = 'Northern China: intercept'
starttime = 0
endtime = 0
basepath = 'data/ci/cntau.csv'
targetpath = ''
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, tau_intercept=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)
name = 'Northern China: exp(intercept)'
data = {'name': name, 'mean': np.exp(mean), 'lowerbound': np.exp(lower), 'median': np.exp(median),
        'upperbound': np.exp(upper), 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: intercept'
starttime = 0
endtime = 0
basepath = 'data/ci/cstau.csv'
targetpath = ''
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, tau_intercept=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)
name = 'Southern China: exp(intercept)'
data = {'name': name, 'mean': np.exp(mean), 'lowerbound': np.exp(lower), 'median': np.exp(median),
        'upperbound': np.exp(upper), 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: intercept'
starttime = 0
endtime = 0
basepath = 'data/ci/uktau.csv'
targetpath = ''
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, tau_intercept=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)
name = 'England: exp(intercept)'
data = {'name': name, 'mean': np.exp(mean), 'lowerbound': np.exp(lower), 'median': np.exp(median),
        'upperbound': np.exp(upper), 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: intercept'
starttime = 0
endtime = 0
basepath = 'data/ci/usatau.csv'
targetpath = ''
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, tau_intercept=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)
name = 'U.S.: exp(intercept)'
data = {'name': name, 'mean': np.exp(mean), 'lowerbound': np.exp(lower), 'median': np.exp(median),
        'upperbound': np.exp(upper), 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)


print('Calculating International Volume')
name = 'Northern China: international Volume'
starttime = cn19s
endtime = cn19e
basepath = 'data/colleterialeffects/cn'
targetpath = 'result/cncoef'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, internationalvolume=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Northern China: international Volume'
starttime = cn20s
endtime = cn20e
basepath = 'data/colleterialeffects/cn'
targetpath = 'result/cncoef'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, internationalvolume=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

# name = 'Northern China: international Volume'
# starttime = cn21s
# endtime = cn21e
# basepath = 'data/colleterialeffects/cn'
# targetpath = 'result/cncoef'
# basetype = ''
# mean, lower, upper,_ = calculateCI(
#     basepath, targetpath, basetype, starttime, endtime, internationalvolume=True)
# data = {'name': name, 'mean': mean, 'lowerbound': lower,'median':median,
#         'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
# resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: international Volume'
starttime = cs19s
endtime = cs19e
basepath = 'data/colleterialeffects/cs'
targetpath = 'result/cscoef'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, internationalvolume=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: international Volume'
starttime = cs20s
endtime = cs20e
basepath = 'data/colleterialeffects/cs'
targetpath = 'result/cscoef'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, internationalvolume=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

# name = 'Southern China: international Volume'
# starttime = cs21s
# endtime = cs21e
# basepath = 'data/colleterialeffects/cs'
# targetpath = 'result/cscoef'
# basetype = ''
# mean, lower, upper,_ = calculateCI(
#     basepath, targetpath, basetype, starttime, endtime, internationalvolume=True)
# data = {'name': name, 'mean': mean, 'lowerbound': lower,'median':median,
#         'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
# resultdf = resultdf.append(data, ignore_index=True)

name = 'England: international Volume'
starttime = uk19s
endtime = uk19e
basepath = 'data/colleterialeffects/uk'
targetpath = 'result/ukcoef'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, internationalvolume=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: international Volume'
starttime = uk20s
endtime = uk20e
basepath = 'data/colleterialeffects/uk'
targetpath = 'result/ukcoef'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, internationalvolume=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

# name = 'England: international Volume'
# starttime = uk21s
# endtime = uk21e
# basepath = 'data/colleterialeffects/uk'
# targetpath = 'result/ukcoef'
# basetype = ''
# mean, lower, upper,_ = calculateCI(
#     basepath, targetpath, basetype, starttime, endtime, internationalvolume=True)
# data = {'name': name, 'mean': mean, 'lowerbound': lower,'median':median,
#         'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
# resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: international Volume'
starttime = usa19s
endtime = usa19e
basepath = 'data/colleterialeffects/usa'
targetpath = 'result/usacoef'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, internationalvolume=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: international Volume'
starttime = usa20s
endtime = usa20e
basepath = 'data/colleterialeffects/usa'
targetpath = 'result/usacoef'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, internationalvolume=True)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

# name = 'U.S.: international Volume'
# starttime = usa21s
# endtime = usa21e
# basepath = 'data/colleterialeffects/usa'
# targetpath = 'result/usacoef'
# basetype = ''
# mean, lower, upper,_ = calculateCI(
#     basepath, targetpath, basetype, starttime, endtime, internationalvolume=True)
# data = {'name': name, 'mean': mean, 'lowerbound': lower,'median':median,
#         'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
# resultdf = resultdf.append(data, ignore_index=True)

print('Calculating int/dom volume alone')
name = 'Northern China: int mobility change alone - no npi'
starttime = cn20s
endtime = cn20e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/ci/cnd2i1.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Northern China: dom mobility change alone - no npi'
starttime = cn20s
endtime = cn20e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/ci/cnd1i2.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: int mobility change alone - no npi'
starttime = cs20s
endtime = cs20e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/ci/csd2i1.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: dom mobility change alone - no npi'
starttime = cs20s
endtime = cs20e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/ci/csd1i2.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: int mobility change alone - no npi'
starttime = uk20s
endtime = uk20e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/ci/ukd2i1.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: dom mobility change alone - no npi'
starttime = uk20s
endtime = uk20e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/ci/ukd1i2.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: int mobility change alone - no npi'
starttime = usa20s
endtime = usa20e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/ci/usad2i1.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: dom mobility change alone - no npi'
starttime = usa20s
endtime = usa20e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/ci/usad1i2.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Northern China: int mobility change alone - no npi'
starttime = cn19s
endtime = cn19e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/ci/cnd2i1.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Northern China: dom mobility change alone - no npi'
starttime = cn19s
endtime = cn19e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/ci/cnd1i2.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: int mobility change alone - no npi'
starttime = cs19s
endtime = cs19e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/ci/csd2i1.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: dom mobility change alone - no npi'
starttime = cs19s
endtime = cs19e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/ci/csd1i2.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: int mobility change alone - no npi'
starttime = uk19s
endtime = uk19e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/ci/ukd2i1.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: dom mobility change alone - no npi'
starttime = uk19s
endtime = uk19e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/ci/ukd1i2.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: int mobility change alone - no npi'
starttime = usa19s
endtime = usa19e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/ci/usad2i1.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: dom mobility change alone - no npi'
starttime = usa19s
endtime = usa19e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/ci/usad1i2.csv'
basetype = ''
mean, lower, upper, _, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime)
data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)


print('Calculating int/all percentage')
name = 'Northern China: int/all percentage'
starttime = cn19s
endtime = cn19e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/ci/cnd2i1.csv'
basetype = ''
mean, lower, upper, ichange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

starttime = cn19s
endtime = cn19e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/ci/cnmobility.csv'
basetype = ''
mean, lower, upper, achange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

result = np.maximum(np.minimum(ichange[achange != 0]/achange[achange != 0], 1), 0)
mean = np.mean(result)
lower = np.percentile(result, 2.5)
upper = np.percentile(result, 97.5)
median = np.percentile(result, 50)

data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Northern China: int/all percentage'
starttime = cn20s
endtime = cn20e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/ci/cnd2i1.csv'
basetype = ''
mean, lower, upper, ichange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

starttime = cn20s
endtime = cn20e
basepath = 'data/ci/cnnonpi.csv'
targetpath = 'data/ci/cnmobility.csv'
basetype = ''
mean, lower, upper, achange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

result = np.maximum(np.minimum(ichange[achange != 0]/achange[achange != 0], 1), 0)
mean = np.mean(result)
lower = np.percentile(result, 2.5)
upper = np.percentile(result, 97.5)
median = np.percentile(result, 50)

data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: int/all percentage'
starttime = cs19s
endtime = cs19e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/ci/csd2i1.csv'
basetype = ''
mean, lower, upper, ichange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

starttime = cs19s
endtime = cs19e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/ci/csmobility.csv'
basetype = ''
mean, lower, upper, achange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

result = np.maximum(np.minimum(ichange[achange != 0]/achange[achange != 0], 1), 0)
mean = np.mean(result)
lower = np.percentile(result, 2.5)
upper = np.percentile(result, 97.5)
median = np.percentile(result, 50)

data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'Southern China: int/all percentage'
starttime = cs20s
endtime = cs20e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/ci/csd2i1.csv'
basetype = ''
mean, lower, upper, ichange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

starttime = cs20s
endtime = cs20e
basepath = 'data/ci/csnonpi.csv'
targetpath = 'data/ci/csmobility.csv'
basetype = ''
mean, lower, upper, achange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

result = np.maximum(np.minimum(ichange[achange != 0]/achange[achange != 0], 1), 0)
mean = np.mean(result)
lower = np.percentile(result, 2.5)
upper = np.percentile(result, 97.5)
median = np.percentile(result, 50)

data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: int/all percentage'
starttime = uk19s
endtime = uk19e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/ci/ukd2i1.csv'
basetype = ''
mean, lower, upper, ichange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

starttime = uk19s
endtime = uk19e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/ci/ukmobility.csv'
basetype = ''
mean, lower, upper, achange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

result = np.maximum(np.minimum(ichange[achange != 0]/achange[achange != 0], 1), 0)
mean = np.mean(result)
lower = np.percentile(result, 2.5)
upper = np.percentile(result, 97.5)
median = np.percentile(result, 50)

data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'England: int/all percentage'
starttime = uk20s
endtime = uk20e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/ci/ukd2i1.csv'
basetype = ''
mean, lower, upper, ichange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

starttime = uk20s
endtime = uk20e
basepath = 'data/ci/uknonpi.csv'
targetpath = 'data/ci/ukmobility.csv'
basetype = ''
mean, lower, upper, achange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

result = np.maximum(np.minimum(ichange[achange != 0]/achange[achange != 0], 1), 0)
mean = np.mean(result)
lower = np.percentile(result, 2.5)
upper = np.percentile(result, 97.5)
median = np.percentile(result, 50)

data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: int/all percentage'
starttime = usa19s
endtime = usa19e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/ci/usad2i1.csv'
basetype = ''
mean, lower, upper, ichange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

starttime = usa19s
endtime = usa19e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/ci/usamobility.csv'
basetype = ''
mean, lower, upper, achange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

result = np.maximum(np.minimum(ichange[achange != 0]/achange[achange != 0], 1), 0)
mean = np.mean(result)
lower = np.percentile(result, 2.5)
upper = np.percentile(result, 97.5)
median = np.percentile(result, 50)

data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)

name = 'U.S.: int/all percentage'
starttime = usa20s
endtime = usa20e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/ci/usad2i1.csv'
basetype = ''
mean, lower, upper, ichange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

starttime = usa20s
endtime = usa20e
basepath = 'data/ci/usanonpi.csv'
targetpath = 'data/ci/usamobility.csv'
basetype = ''
mean, lower, upper, achange, median = calculateCI(
    basepath, targetpath, basetype, starttime, endtime, bs=False)

result = np.maximum(np.minimum(ichange[achange != 0]/achange[achange != 0], 1), 0)
mean = np.mean(result)
lower = np.percentile(result, 2.5)
upper = np.percentile(result, 97.5)
median = np.percentile(result, 50)

data = {'name': name, 'mean': mean, 'lowerbound': lower, 'median': median,
        'upperbound': upper, 'starttime': starttime, 'endtime': endtime}
resultdf = resultdf.append(data, ignore_index=True)


resultdf.to_csv('result/CIv3.csv', index=True, header=True)
