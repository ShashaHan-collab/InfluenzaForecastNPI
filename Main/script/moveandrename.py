# this scrpit can move and rename the raw flu/coefficient data file
import pandas as pd
from utils import *
import numpy as np


def main():
    import argparse
    parser = argparse.ArgumentParser()
    universalparser(parser)

    parser.add_argument("--targetname", type=str)
    parser.add_argument("--targetfolder", type=str, default='data')
    parser.add_argument("--sourcetype", type=str, default='output')
    parser.add_argument("--movetype", type=str, default='move')
    args = parser.parse_args()
    paras = vars(args)

    print('moving csv')
    exp_name = make_exp_name(paras, paras['lsa'])

    rawdf = pd.read_csv(
        'result/'+paras['sourcetype']+exp_name+'.csv', header=0, index_col=0)
    if paras['movetype'] == 'mean':
        if paras['sourcetype'] != 'coef':
            tmp = rawdf.loc[:, :].mean(axis=1)
            for i in rawdf.columns:
                rawdf.loc[:, i] = tmp
        else:
            for i in rawdf.index:
                rawdf.loc[i, :] = rawdf.loc['average', :]
    rawdf.to_csv(paras['targetfolder']+'/'+paras['targetname'] +
                 '.csv', index=True, header=True)
    print('Done')


if __name__ == "__main__":
    main()