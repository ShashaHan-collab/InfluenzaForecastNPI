# Called by the bash script. 
# This axuiliary scripts generates source data for plotting using output data from "calculate_plot_statistics.py".


import pandas as pd
from utils import *
import numpy as np
import os


def main():
    import argparse
    parser = argparse.ArgumentParser()

    parser.add_argument("--sourcecsv", type=str)
    parser.add_argument("--sourcefolder", type=str, default="result")
    parser.add_argument("--targetexcel", type=str)
    parser.add_argument("--targetsheetname", type=str)
    args = parser.parse_args()
    paras = vars(args)

    print('moving excel')
    rawdf = pd.DataFrame()

    rawdf = pd.read_csv(paras['sourcefolder'] +
                        '/'+paras['sourcecsv']+'.csv', header=0, index_col=0)
    rawdf.index.name = 'time'

    if os.path.exists(paras['targetexcel']+'.xlsx'):
        excel = pd.ExcelWriter(paras['targetexcel']+'.xlsx', mode='a')
        wb = excel.book
        if paras['targetsheetname'] in wb.sheetnames:
            wb.remove(wb[paras['targetsheetname']])
        rawdf.to_excel(excel, sheet_name=paras['targetsheetname'])
        excel.save()
        excel.close()
    else:
        rawdf.to_excel(paras['targetexcel']+'.xlsx',
                       sheet_name=paras['targetsheetname'])

    print('Done')


if __name__ == "__main__":
    main()
