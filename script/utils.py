# Utility functions
import argparse
import pandas as pd
from pandas.core.frame import DataFrame
from pandas.core.series import Series
import numpy as np
import os
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import cross_val_score
from sklearn.linear_model import Lasso



def load_data(lag, covariate_list, lag_list, direction, region, timepoint, uselog, treatmentindicator_list, causaltype, causallag, yam_region, volume_list, args, intervolume_list):
    inputdf = pd.read_csv(
        'preprocessed data/'+region+'.csv', header=0, index_col=0)
    if yam_region != '':
        yamdf = pd.read_csv(
            'preprocessed data/'+yam_region+'.csv', header=0, index_col=0)
        inputdf = inputdf.loc[yamdf.index, :]
    else:
        yamdf = None

    # make rawdf
    # add covariate

    rawdf = inputdf.loc[:, covariate_list]

    if uselog:
        rawdf['positive_rate'] = np.log(
            np.maximum(inputdf['positive_rate'], 1e-4))
    else:
        rawdf['positive_rate'] = inputdf['positive_rate']
    for a in ['t1', 't2', 'volume', 'seasonindicator', 'bsweight', 'cpl', 'intervolume']:
        if a in inputdf.columns.values.tolist():
            rawdf[a] = inputdf[a]
    rawdf.index = inputdf.index
    if 'cpl' in rawdf.columns:
        rawdf = make_compliance(rawdf, args.cpltp, args.cpl, args.cpled)
    # add lag info
    for idx in rawdf.index:
        rate = get_lag_rate(lag, idx, rawdf, direction, 'positive_rate')
        if rate is not None:
            rawdf.loc[idx, lag_list] = rate         
            if causaltype == 'new':
                rawdf = rawdf.drop(columns=lag_list)

                indicator = get_lag_rate(
                    causallag-1, idx, rawdf, direction, 't2')
                compliance = get_lag_rate(
                    causallag-1, idx, rawdf, direction, 'cpl')
                rawdf.loc[idx, 'sumd'] = np.sum(
                    indicator*compliance)+rawdf.loc[idx, 't2']*rawdf.loc[idx, 'cpl']
                if args.newclag:
                    lagindicator = get_newclag_indicator(
                        idx, rawdf, causallag, args.newclagnum, args.newclagtp)
                    rawdf.loc[idx, 'sumd'] = np.sum(
                        indicator*compliance*lagindicator)+rawdf.loc[idx, 't2']*rawdf.loc[idx, 'cpl']

            elif causaltype == 'no':
                pass
            else:
                raise NotImplementedError


    # split train,validation,test
    if (rawdf.index.get_loc(timepoint['trainstart']) < lag and direction == 'forward') or (rawdf.index.get_loc(timepoint['trainend'])+lag >= len(rawdf.index) and direction == 'backward'):
        train_idx = get_idx(
            rawdf, timepoint['trainstart'], timepoint['trainend'], direction, lag)
    else:
        train_idx = get_idx(
            rawdf, timepoint['trainstart'], timepoint['trainend'], direction, 0)

    xtrain, ytrain = split_xy(rawdf.loc[train_idx, :], covariate_list)
        # ytrain.loc[:, 'positive_rate']-=1
    if causaltype == 'new':
        for episode in yamdf.columns:
            # for idx in ytrain.index:
            #     try:
            #         ytrain.loc[idx, episode]=np.log(ytrain.loc[idx, 'positive_rate'].values /
            #                                     yamdf.loc[idx, episode].values)
            #     except:
            #         ytrain.loc[:, episode]=np.log
            ytrain.loc[:, episode] = np.log(ytrain.loc[:, 'positive_rate'].values /
                                            np.maximum(yamdf.loc[ytrain.index, episode].values, 1e-3))

    if timepoint['valstart'] is not None:
        val_idx = get_idx(
            rawdf, timepoint['valstart'], timepoint['valend'], direction, 0)
        xval, yval = split_xy(rawdf.loc[val_idx, :], covariate_list)
        if causaltype == 'new':
            raise NotImplementedError
    else:
        xval = None
        yval = None

    pred_idx = get_idx(
        rawdf, timepoint['predstart'], timepoint['predend'], direction, 0)
    xpred, ypred = split_xy(rawdf.loc[pred_idx, :], covariate_list)
    
    if 'bsweight' in rawdf.columns:
        rawdf = make_bs_weight(xtrain, rawdf)

    if direction == 'forward':
        rawdf = rawdf[lag:]
        if yamdf is not None:
            yamdf = yamdf[lag:]
    elif direction == 'backward':
        rawdf = rawdf[:-lag]
        if yamdf is not None:
            yamdf = yamdf[:-lag]
    else:
        raise NotImplementedError
    return rawdf, xtrain, ytrain, xval, yval, xpred, ypred, yamdf


def get_idx(df: DataFrame, start, end, direction, lag):
    if direction == 'forward':
        startrow = df.index.get_loc(start)+lag
        endrow = df.index.get_loc(end)+1
        idx = df.index[startrow:endrow:1]
    elif direction == 'backward':
        startrow = df.index.get_loc(end)-lag
        endrow = df.index.get_loc(start)-1
        if endrow == -1:
            endrow = None
        idx = df.index[startrow:endrow:-1]
    else:
        raise NotImplementedError
    return idx


def get_lag_rate(lag, idx, rawdf: DataFrame, direction, ratetype):
    if direction == 'forward':
        rate = get_pre_timepoint(lag, idx, rawdf, ratetype)
    elif direction == 'backward':
        rate = get_next_timepoint(lag, idx, rawdf, ratetype)
    else:
        raise NotImplementedError
    return rate


def get_treat_indicator(lag, idx, rawdf: DataFrame, direction, causalstart):
    idx_loc = rawdf.index.get_loc(idx)
    if direction == 'forward':
        pre_idx = rawdf.index[idx_loc-lag: idx_loc]
        treat = (pre_idx.values < causalstart).astype(int)
    elif direction == 'backward':
        next_idx = rawdf.index[idx_loc+1: idx_loc+lag+1]
        treat = (next_idx.values > causalstart).astype(int)
    else:
        raise NotImplementedError
    return treat


def get_pre_timepoint(lag, idx, rawdf: DataFrame, ratetype):
    loc = rawdf.index.get_loc(idx)
    if loc < lag:
        return None
    idxall = rawdf.index[loc-lag: loc]
    # positive_rate = rawdf.loc[idxall, 'positive_rate'].values
    positive_rate = rawdf.loc[idxall, ratetype].values
    return positive_rate


def get_next_timepoint(lag, idx, rawdf: DataFrame, ratetype):
    loc = rawdf.index.get_loc(idx)
    if loc + lag >= len(rawdf.index):
        return None
    idxall = rawdf.index[loc+1: loc+lag+1]
    positive_rate = rawdf.loc[idxall, 'positive_rate'].values
    positive_rate = rawdf.loc[idxall, ratetype].values
    return positive_rate


def split_train_test(df: DataFrame, include: Series, treatment: Series):
    include = include.values.astype(bool)
    treatment = treatment.values.astype(bool)
    train = df[include & (~treatment)]
    test = df[include & treatment]
    return train.values, test.values


def split_xy(df: DataFrame, covlist):
    col = df.columns.values.tolist()
    for a in ['positive_rate', 't1', 't2', 'volume', 'seasonindicator', 'bsweight', 'cpl', 'intervolume']:
        if a in col and a not in covlist:
            col.remove(a)
    x = pd.DataFrame(columns=col)
    y = pd.DataFrame(columns=['positive_rate'])
    y['positive_rate'] = df['positive_rate']
    x[col] = df[col]
    y.index = df.index
    x.index = df.index
    return x, y


def select_parameter(model, alphas, xtrain, ytrain):
    scores = {}
    for alpha in alphas:
        if model == 'lasso':
            regressor = Lasso(max_iter=100000, alpha=alpha)
        elif model == 'ols':
            return 0
        scores[alpha] = np.mean(cross_val_score(
            regressor, xtrain, ytrain, scoring='neg_mean_squared_error', cv=4))
        # scores[alpha] = np.mean(cross_val_score(
        #      regressor, xtrain, ytrain, scoring='r2', cv=4))
    alpha = max(scores.items(), key=lambda x: x[1])[0]
    return alpha


def write_score(fitscore, valscore, trainscore, expname):
    resultpath = 'result/score.csv'
    if os.path.exists(resultpath):
        result = pd.read_csv(resultpath, header=0, index_col=0)
    else:
        result = pd.DataFrame()

    result = result.append({'bootstrapscore': fitscore, 'val_score': valscore, 'trainscore': trainscore,
                            'experiment': expname}, ignore_index=True)
    result.to_csv(resultpath, header=True, index=True)


def max_score_alpha(paras):
    if paras['lsa'] != 1:
        expname = make_exp_name(paras, 1)
        alpha = 1
        maxscore = 0
    else:
        alphas = [1e-5, 1e-4, 1e-03, 1e-02, 1e-01, 1e-6]
        scoredf = pd.read_csv('result/score.csv', index_col=0, header=0)
        maxscore = 0
        expname = ''
        alpha = 1e-5
        for a in alphas:
            en = make_exp_name(paras, a)
            score = scoredf[scoredf['experiment']
                            == en].iloc[-1, :][['trainscore']].values[0]
            if score > maxscore:
                maxscore = score
                alpha = a
                expname = en

    return expname, alpha, maxscore


def make_exp_name(paras, alpha):
    experiment_name = ''
    for key, value in paras.items():
        if key == 'lsa':
            value = alpha
        elif key in ['synregion', 'synstart', 'synend', 'plotmax', 'plotstart', 'plotend', 'plotwidth', 'plotheight', 'loadcoef', 'dir', 'vstart', 'vend', 'ln', 'nrol', 'targetname', 'targetfolder', 'seed', 'loadpositiverate', 'sourcetype', 'movetype', 'newclagtp', 'newclag', 'newclagnum', 'vaccine']:
            # elif key in ['synregion', 'synstart', 'synend', 'plotmax', 'plotstart', 'plotend', 'plotwidth', 'plotheight', 'loadcoef', 'dir', 'vstart', 'vend', 'ln', 'nrol', 'targetname', 'targetfolder', 'cpltp', 'cpled', 'region', 'model', 'rep','seed','loadpositiverate','sourcetype','yam','CI', 'newclagtp','newclag','newclagnum', 'vaccine']:
            continue
        experiment_name = experiment_name+'_'+str(key)+str(value)
    return experiment_name


def make_bs_weight(traindf: DataFrame, rawdf: DataFrame):
    trainidx = traindf.index
    groupinfo = {}
    tmprawdf = rawdf.loc[traindf.index, :].copy()
    for idx in trainidx:
        bsweight = tmprawdf.loc[idx, 'bsweight']
        if bsweight not in groupinfo:
            groupcount = len(tmprawdf[tmprawdf['bsweight'] == bsweight].index)
            totalweight = (bsweight % 100)/100
            groupinfo[bsweight] = totalweight/groupcount
        rawdf.loc[idx, 'bsweight'] = groupinfo[bsweight]
    return rawdf


def make_compliance(rawdf: DataFrame, idx, type, idxed):
    if type == 'geo':
        seq = range(rawdf.index.get_loc(idx), len(rawdf.index))
        seq = np.array(seq)+1-rawdf.index.get_loc(idx)
        rawdf.loc[idx:idxed, 'cpl'] = rawdf.loc[idx:idxed, 'cpl']/seq
    elif type == 'a1':
        rawdf.loc[idx:idxed, 'cpl'] = 1
    elif type == 'a0':
        rawdf.loc[idx:idxed, 'cpl'] = 0
    elif type == 'a7':
        rawdf.loc[idx:idxed, 'cpl'] = 0.7
    elif type == 'a5':
        rawdf.loc[idx:idxed, 'cpl'] = 0.5
    elif type == 'a3':
        rawdf.loc[idx:idxed, 'cpl'] = 0.3
    else:
        raise NotImplementedError

    return rawdf


def get_newclag_indicator(current_idx, rawdf: DataFrame, oldlag, newlag, newclagtp):
    # print(newlag)
    newlag=int(oldlag*newlag/10)
    # print(newlag)
    current_timpoint_loc = rawdf.index.get_loc(current_idx)
    old_timepoint = rawdf.index[current_timpoint_loc-oldlag+1]
    new_timepoint = rawdf.index[current_timpoint_loc-newlag+1]
    indicator = rawdf.loc[old_timepoint:current_idx, :].index.values
    indicator = 1-((indicator < new_timepoint) & (indicator >= newclagtp))
    return indicator[:-1]


def universalparser(parser: argparse.ArgumentParser):
    parser.add_argument("--lag", type=int, default=52)
    parser.add_argument("--rep", type=int, default=5000, help='repeat times')
    parser.add_argument("--model", type=str, default='lasso')
    # parser.add_argument("--treatment", type=str, default='travelmask')
    parser.add_argument("--dir", type=str, default='forward')
    parser.add_argument("--region", type=str, default="cni")
    parser.add_argument("--cov", type=str, default='nocov',
                        help='covariate list')
    parser.add_argument("--tstart", type=int, default=201302)
    parser.add_argument("--tend", type=int, default=202005)
    parser.add_argument("--vstart", type=int, default=None)
    parser.add_argument("--vend", type=int, default=None)
    parser.add_argument("--pstart", type=int, default=202006)
    parser.add_argument("--pend", type=int, default=202128)
    parser.add_argument("--CI", action='store_true')
    parser.add_argument("--lsa", type=float, default=1, help='lasso alpha')
    parser.add_argument("--des", type=str, default='None')
    parser.add_argument("--ln", action='store_true', help='use log on y')
    # parser.add_argument("--trIn", action='store_true')
    parser.add_argument("--ctype", type=str, default='no',
                        help='causal model adopted:no,a=additive,m=muliplicative,am=additive multiple model, vs:volume times seasonal indicator, vs0: vs model with only time point 0 ,vs2: seasonal model including intervolume and volume, vs1: seasonal model only include intervolume')
    parser.add_argument("--noint", action='store_false', help='nointercept')
    parser.add_argument("--nrol", action='store_true',
                        help='not predict on a rolling basis')
    parser.add_argument("--clag", type=int, default=52)
    parser.add_argument(
        "--yam", type=str, default='', help='region name of y used for am causal model')
    parser.add_argument("--tt", type=str, default='bs',
                        help='training type, bs=bootstrap,f=full fit with train set,bw=bootstrap with weighted sampling,if used, use bsweight in sample to calculate weight')
    parser.add_argument("--vlag", type=int, default=0,
                        help='lag number for volume,vlag=0 means do not use volume data', dest='volumelag')
    parser.add_argument("--loadcoef", type=str, default='',
                        dest='loadcoef', help='coef file path that will be loaded')
    # parser.add_argument("--mltiy", action='store_true',
    #                     help='whether need to load multiple series of y from yam, if true, each episode train with a different series of y', dest='mltiy')
    parser.add_argument("--cpl", type=str, default='geo',
                        help='compliance type for dmask, geo=geometry decline, a1=all 1', dest='cpl')
    parser.add_argument("--cpltp", type=int, default=202252,
                        help='baseline timepoint for the compliance dicount factor', dest='cpltp')
    parser.add_argument("--cpled", type=int, default=202252,
                        help='baseline ending timepoint for the compliance dicount factor', dest='cpled')
    parser.add_argument("--seed", type=int, default=0,
                        help='seeds used', dest='seed')
    parser.add_argument('--loadpositiverate', type=str, default='',
                        dest='loadpositiverate', help='result file path that will be loaded')
    parser.add_argument('--newclag', action='store_true',
                        help='wheyher use new lag for test effect of mask', dest='newclag')
    parser.add_argument('--newclagnum', type=int, default=0,
                        help='new lag for test effect of mask', dest='newclagnum')
    parser.add_argument('--newclagtp', type=int, default=202252,
                        help='change point of the new lag for test effect of mask', dest='newclagtp')
    parser.add_argument('--vaccine', type=float, default=1,
                        dest='vaccine', help='effect of vaccine')
