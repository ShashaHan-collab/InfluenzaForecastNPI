# Called by the bash script. This script calculates the regression/lasso coefficients and do the prediction based on past flu level. The output of this script contains the coef of regression, the predicted flu level. Relevant parameters are as follow. 
# rep - repeat times
# model - lr for linear regression and lasso for Lasso
# region - file name of the past data of positive rate
# cov - name for covariates used in regression
# tstart - starting time of training set
# tend - ending time of training set
# vstart - starting time of validation
# vend - ending time of validation
# pstart - starting time of prediction
# pend - ending time of prediction
# CI - output the fitted value on training set if set true
# lsa - lasso penalty uesd
# ctype - set to "new" for the mask model used
# noint - set to true if ignore the intercept in regression
# clag - length of lag L
# loadcoef - load existing coef file if set. Used to accelerate the program
# cpl - set the value of compliance between cpltp and cpled. 'a0': set to 0. 'a1': set to 1.
# cpltp - time point
# cpled - time point
# seed - set the seed used
# loadpositiverate - load existing positive rate file if set. Used to accelerate the program
# newclag - whether use new lag for test effect of mask order after some time point
# newclagnum - tensity of mask order
# newclagtp - starting point of the new lag
# vaccine - effect of vaccination

from tqdm import tqdm
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.linear_model import Lasso
from sklearn.model_selection import cross_val_score
from sklearn.ensemble import RandomForestRegressor
import pandas as pd
from utils import *


def main():
    import argparse
    parser = argparse.ArgumentParser()
    # parser.add_argument("--test_mode", action='store_true')

    # parser.add_argument("--cstart", type=int, default=202004,
    #                     help='control group start date')
    # parser.add_argument("--cend", type=int, default=202046,
    #                     help='control group end date')

    universalparser(parser)

    args = parser.parse_args()
    paras = vars(args)

    np.random.seed(args.seed)

    timepoint = {}

    # covariate_list = ['week', 'aratio']
    covariate_list = paras['cov']
    if covariate_list == 'nocov':
        covariate_list = []
    else:
        covariate_list = covariate_list.split(sep=',')
    lag = paras['lag']
    model = paras['model']
    # treatment = paras['treatment']
    direction = paras['dir']
    region = paras['region']
    # test_mode = paras['test_mode']
    test_mode = False
    repeatnum = paras['rep']
    timepoint['trainstart'] = paras['tstart']
    timepoint['trainend'] = paras['tend']
    timepoint['valstart'] = paras['vstart']
    timepoint['valend'] = paras['vend']
    timepoint['predstart'] = paras['pstart']
    timepoint['predend'] = paras['pend']
    # timepoint['ctrlstart']=paras['cstart']
    # timepoint['cend']=paras['cend']
    needtrainCI = paras['CI']
    alpha = paras['lsa']
    des = paras['des']
    uselog = paras['ln']
    # needtreatmentindicator = paras['trIn']
    causaltype = paras['ctype']

    fit_intercept = paras['noint']
    rolling_pred = not paras['nrol']
    causallag = paras['clag']
    yam_region = paras['yam']
    train_type = paras['tt']

    lag_list = []
    treatmentindicator_list = []
    volume_list = []
    intervolume_list = []
    for i in range(lag):
        lag_list.append('lag'+str(i+1))

    for i in range(causallag):
        treatmentindicator_list.append('indi'+str(i+1))

    for i in range(args.volumelag):
        volume_list.append('v'+str(i+1))
        intervolume_list.append('interv'+str(i+1))

    print('Processing Data')
    # Input raw data [Q1: raw data??]
    rawdfbase, xtrain, ytrain, xval, yval, xpred, ypred, yamdf = load_data(
        lag, covariate_list, lag_list, direction, region, timepoint, uselog, treatmentindicator_list, causaltype, causallag, yam_region, volume_list, args, intervolume_list)
    print('trainging set start from: '+str(xtrain.index.values[0]))

    if paras['yam'] != '':
        amdf = pd.read_csv('data/'+paras['yam']+'.csv', header=0, index_col=0)
    # Train the model
    if alpha == 1 and model == 'lasso':
        alphas = [1e-5, 1e-4, 1e-03, 1e-02, 1e-01]
        # alpha = select_parameter(model, alphas, xtrain.values, ytrain.values)
    else:
        alphas = [alpha]

    # make prediction

    coefdf = DataFrame()
    loadcoef = False if args.loadcoef == '' else True
    if loadcoef:
        coefdf = pd.read_csv('result/'+args.loadcoef +
                             '.csv', header=0, index_col=0)
        coefdf.drop(index=['average'], inplace=True)
        coefdf.drop(index=['lower'], inplace=True)
        coefdf.drop(index=['upper'], inplace=True)
        coefdf.index = coefdf.index.astype(int)
    yhatdf = DataFrame()
    loadyhat = False if args.loadpositiverate == '' else True
    if loadyhat:
        yhatdf = pd.read_csv('result/'+args.loadpositiverate +
                             '.csv', header=0, index_col=0)
        intersectid = yhatdf.index.intersection(rawdfbase.index)
        # rawdfbase.loc[intersectid,'positive_rate']=yhatdf.loc[intersectid,:].mean(axis=1)

    if causaltype == 'new':
        ytrainbase = ytrain.copy()
    if args.vaccine != 1:
        print('using vaccine :' + str(args.vaccine))
    for alpha in alphas:
        experiment_name = make_exp_name(paras, alpha)
        print('Experiment: '+experiment_name)

        resultdf = DataFrame()
        predict_idx = xpred.index
        fitscore = 0
        valscore = 0
        trainscore = 0
        print('Do Prediction with alpha'+str(alpha))
        # for episode in tqdm(range(repeatnum)):
        for episode in range(repeatnum):
            rawdf = rawdfbase.copy()
            if loadyhat:
                rawdf.loc[intersectid,
                          'positive_rate'] = yhatdf.loc[intersectid, str(episode)]
            if model == 'rf':
                regressor = RandomForestRegressor(
                    n_estimators=50, max_depth=alpha)
            elif model == 'lasso':
                regressor = Lasso(max_iter=1000000, alpha=alpha,
                                  fit_intercept=fit_intercept)
            elif model == 'lr':
                regressor = LinearRegression(fit_intercept=fit_intercept)

            if causaltype == 'new':
                ytrain = ytrainbase.loc[ytrain.index, str(episode)]

            # bootstrap
            if train_type == 'bs':
                choice = np.random.choice(
                    xtrain.shape[0], size=xtrain.shape[0], replace=True)
                xtrain_bootstrap = xtrain.values[choice, :]
                ytrain_bootstrap = ytrain.values[choice]
                # coefdf.loc[episode, 'choice']=xtrain.index[0]
            elif train_type == 'bw':
                weight = rawdf.loc[xtrain.index, 'bsweight'].values
                choice = np.random.choice(
                    xtrain.shape[0], size=xtrain.shape[0], replace=True, p=weight)
                xtrain_bootstrap = xtrain.values[choice, :]
                ytrain_bootstrap = ytrain.values[choice]
                # coefdf.loc[episode, 'choice']=xtrain.index[0]
            else:
                xtrain_bootstrap = xtrain.values
                ytrain_bootstrap = ytrain.values

            if not loadcoef:
                regressor.fit(xtrain_bootstrap, ytrain_bootstrap)
            else:
                if fit_intercept:
                    regressor.intercept_ = coefdf.loc[episode, 'intercept']
                else:
                    regressor.intercept_=0
                regressor.coef_ = coefdf.loc[episode, xtrain.columns.values]
            # if loadyhat:
            #     rawdf.loc[intersectid,'positive_rate']=yhatdf.loc[intersectid,str(episode)]

            fitscore += regressor.score(xtrain_bootstrap, ytrain_bootstrap)
            trainscore += regressor.score(xtrain.values, ytrain.values)

            coefdf.loc[episode, 'intercept'] = regressor.intercept_
            coefdf.loc[episode, xtrain.columns.values] = regressor.coef_
            # if coefdf.loc[episode,'vs']==0:
            #     print(xtrain.index[choice].values)

            rollingdf = DataFrame()
            for idx in predict_idx:
                pred_x = get_lag_rate(
                    lag, idx, rawdf, direction, 'positive_rate')
                if causaltype == 'no':
                    pred_x = np.hstack(
                        (rawdf.loc[idx, covariate_list].values, pred_x)).reshape(1, -1)
                elif causaltype == 'new':
                    break
                else:
                    raise NotImplementedError

                # if args.volumelag > 0 and causaltype not in ['vs', 'vs0','vs2','vs1']:
                #     volume = get_lag_rate(
                #         args.volumelag, idx, rawdf, direction, 'volume')
                #     pred_x = np.hstack(
                #         (pred_x, volume.reshape(1, -1))).reshape(1, -1)

                pred_y = regressor.predict(pred_x)
                if args.vaccine != 1:
                    pred_y *= args.vaccine

                # Update seasonal indicator
                # if causaltype == 'vs' and pred_y.reshape(-1) >= 0.1:
                #     rawdf.loc[idx, 'seasonindicator'] = 1

                # pred_y = np.dot(np.append(1,pred_x[:,pos]), beta)
                if not rolling_pred:
                    if uselog:
                        rollingdf.loc[idx,
                                      'positive_rate'] = pred_y.reshape(-1)
                    else:
                        rollingdf.loc[idx, 'positive_rate'] = np.maximum(
                            pred_y.reshape(-1), 0)
                else:
                    if uselog:
                        rawdf.loc[idx, 'positive_rate'] = pred_y.reshape(-1)
                    else:
                        rawdf.loc[idx, 'positive_rate'] = np.maximum(
                            pred_y.reshape(-1), 0)

            resultdf[episode] = rawdf['positive_rate']
            if causaltype == 'new':
                resultdf.loc[predict_idx,
                             episode] = regressor.predict(xpred.values)

                resultdf.loc[predict_idx,
                             episode] = np.exp(resultdf.loc[predict_idx,
                                                            episode].values)*yamdf.loc[predict_idx, str(episode)].values
            elif not rolling_pred:
                resultdf.loc[predict_idx,
                             episode] = rollingdf.loc[predict_idx, 'positive_rate'].values
            if needtrainCI:
                # print(xtrain.values.shape)
                resultdf.loc[xtrain.index, episode] = regressor.predict(
                    xtrain.values).reshape(-1)
                if causaltype == 'new':
                    resultdf.loc[xtrain.index,
                                 episode] = np.exp(resultdf.loc[xtrain.index,
                                                                episode].values)*yamdf.loc[xtrain.index, str(episode)].values

            if xval is not None:  # long time no maintanance, have bugs
                valscore += regressor.score(xval.values, yval.values)
                resultdf.loc[xval.index, episode] = regressor.predict(
                    xval.values)
        resultdf.index = rawdfbase.index
        if uselog:
            resultdf = resultdf.applymap(np.exp)
        fitscore /= repeatnum
        valscore /= repeatnum
        trainscore /= repeatnum

        print('Writing Result')
        resultdf.to_csv('result/output'+experiment_name +
                        '.csv', header=True, index=True)
        rawdfbase.to_csv('result/rawdf'+experiment_name +
                         '.csv', header=True, index=True)
        coefdf.loc['average', :] = coefdf.mean(axis=0)
        coefdf.loc['lower', :] = coefdf.quantile(q=0.025, axis=0)
        coefdf.loc['upper', :] = coefdf.quantile(q=0.975, axis=0)
        coefdf.to_csv('result/coef'+experiment_name +
                      '.csv', header=True, index=True)
        write_score(fitscore, valscore, trainscore, experiment_name)
    print('Done!')


if __name__ == "__main__":
    main()
