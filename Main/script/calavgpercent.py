# this script calculates the mean and upperr/lower bound line from raw flu level data
# edited SH: Q1. Could you clarify the purpose of the file? Q2. What do you mean by "raw flu level data"? 

import pandas as pd
from utils import *
import numpy as np


def main():
    import argparse
    parser = argparse.ArgumentParser()
    universalparser(parser)

    parser.add_argument("--targetname", type=str)
    args = parser.parse_args()
    paras = vars(args)

    print('moving prediction result')
    exp_name = make_exp_name(paras, paras['lsa'])
# Q3. Input ??. I didn't find the files in the folder. 
    rawdf = pd.read_csv('result/output'+exp_name+'.csv', header=0, index_col=0)
    targetdf = pd.DataFrame()
    targetdf['mean'] = rawdf.mean(axis=1)
    targetdf['lower'] = np.maximum(
        np.percentile(rawdf.values, q=2.5, axis=1), 0)
    targetdf['upper'] = np.maximum(
        np.percentile(rawdf.values, q=97.5, axis=1), 0)
    targetdf.index = rawdf.index
    targetdf.index.name = 'time'

    targetdf.to_csv('result/'+paras['targetname'] +
                    '.csv', index=True, header=True)
    print('Done')


if __name__ == "__main__":
    main()
