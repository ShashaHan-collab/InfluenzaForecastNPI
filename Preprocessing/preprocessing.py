import numpy as np
import pandas as pd
from pandas.core.frame import DataFrame
from sklearn.linear_model import LinearRegression


def get_prediction_from_reg(reg_coef: DataFrame, month, year):
    model = LinearRegression()
    model.coef_ = np.array([reg_coef.loc[month, 'coef']])
    model.intercept_ = reg_coef.loc[month, 'intercept']
    xtrain = np.array([year]).reshape(1, -1)
    return model.predict(xtrain)


def find_rate(raw: DataFrame, direction, idx):
    pos = raw.index.get_loc(idx)
    posrate = raw.columns.get_loc('positive_rate')
    maxlen = len(raw.index)
    while True:
        pos += direction
        if pos < 0 or pos >= maxlen:
            rate = 0
            break
        if raw.iloc[pos, posrate] != 0:
            rate = raw.iloc[pos, posrate]
            break
    return rate

basefolder = 'Preprocessing/'
outputbasefolder='Preprocessing/output/'
vaccinedf = pd.read_csv(basefolder+'rawdata/vaccine.csv', index_col=0, header=0)

cnma = 30
csma = 30
usama = 14
ukma = 14
use_indicator_domestic = False
use_indicator_international = True

# Northern China
# read raw data
region = 'cn'
pr_raw = pd.read_csv(basefolder+'rawdata/'+region+'.csv', header=0, index_col=0)
pr_raw['startdate'] = pd.to_datetime(pr_raw['startdate'])
pr_raw['enddate'] = pd.to_datetime(pr_raw['enddate'])
domestic_raw = pd.read_csv(basefolder+
    'rawdata/'+region+'domestic.csv', header=0, index_col=0)
domestic_raw.index = pd.to_datetime(domestic_raw.index)
international_raw = pd.read_csv(basefolder+
    'rawdata/'+region+'international.csv', header=0, index_col=0)

# domestic
# calculate the montly average
average_d_mitigate = pd.DataFrame(index=[2019, 2020, 2021], columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
average_d_normal = pd.DataFrame(index=[2019, 2020, 2021], columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])

for year in [2019, 2020, 2021]:
    for month in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]:
        if year == 2021 and month >= 7:
            break
        average_d_mitigate.loc[year, month] = domestic_raw[(domestic_raw.index.year == year) & (
            domestic_raw.index.month == month)][['volume']].mean().values

reg_coef = pd.DataFrame(index=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], columns=[
                        'intercept', 'coef'])

# calculate the daily average regression coef per month
for month in range(3, 7):
    xtrain = np.array([2019, 2021]).reshape(-1, 1)
    ytrain = average_d_mitigate.loc[[2019, 2021], month].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[month, 'intercept'] = model.intercept_
    reg_coef.loc[month, 'coef'] = model.coef_[0]

for month in range(7, 13):
    xtrain = np.array([2019, 2020]).reshape(-1, 1)
    ytrain = average_d_mitigate.loc[[2019, 2020], month].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[month, 'intercept'] = model.intercept_
    reg_coef.loc[month, 'coef'] = model.coef_[0]

reg_coef.loc[[1, 2], 'intercept'] = reg_coef.loc[range(
    3, 13), 'intercept'].mean()
reg_coef.loc[[1, 2], 'coef'] = reg_coef.loc[range(3, 13), 'coef'].mean()

average_d_normal.loc[:, :] = average_d_mitigate.values
for month in [1, 2, 3, 4]:
    average_d_normal.loc[2020, month] = get_prediction_from_reg(
        reg_coef, month, 2020)
for month in [1, 2, 7, 8, 9, 10, 11, 12]:
    average_d_normal.loc[2021, month] = get_prediction_from_reg(
        reg_coef, month, 2021)
for month in range(1, 13):
    average_d_normal.loc[2022, month] = get_prediction_from_reg(
        reg_coef, month, 2022)

domestic_normal = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
domestic_mitigate = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])

# normal daily raw
domestic_normal.loc[pd.date_range('2019-01-01', '2021-07-15'),
                    'volume'] = domestic_raw.loc[pd.date_range('2019-01-01', '2021-07-15'), 'volume'].values
for date in pd.date_range('2020-01-01', '2020-04-30'):
    if date.month == 2 and date.day == 29:
        continue
    domestic_normal.loc[date, 'volume'] = domestic_normal.loc[date-pd.DateOffset(
        year=date.year-1), 'volume']+reg_coef.loc[date.month, 'coef']
for date in pd.date_range('2021-01-01', '2021-02-28'):
    if date.month == 2 and date.day == 29:
        continue
    domestic_normal.loc[date, 'volume'] = domestic_normal.loc[date-pd.DateOffset(
        year=date.year-1), 'volume']+reg_coef.loc[date.month, 'coef']
for date in pd.date_range('2021-07-01', '2022-12-31'):
    if date.month == 2 and date.day == 29:
        continue
    domestic_normal.loc[date, 'volume'] = domestic_normal.loc[date-pd.DateOffset(
        year=date.year-1), 'volume']+reg_coef.loc[date.month, 'coef']
for date in reversed(pd.date_range('2010-12-01', '2018-12-31')):
    if date.month == 2 and date.day == 29:
        continue
    domestic_normal.loc[date, 'volume'] = domestic_normal.loc[date+pd.DateOffset(
        year=date.year+1), 'volume']
for date in domestic_normal.index:
    if date.month == 2 and date.day == 29:
        pos = domestic_normal.index.get_loc(date)
        domestic_normal.loc[date, 'volume'] = (
            domestic_normal.iloc[pos-1, 0]+domestic_normal.iloc[pos+1, 0])/2
# mitigate daily raw
domestic_mitigate.loc[pd.date_range('2019-01-01', '2021-07-15'),
                      'volume'] = domestic_raw.loc[pd.date_range('2019-01-01', '2021-07-15'), 'volume'].values
for date in pd.date_range('2021-07-16', '2022-12-31'):
    if date.month == 2 and date.day == 29:
        continue
    domestic_mitigate.loc[date, 'volume'] = domestic_mitigate.loc[date-pd.DateOffset(
        year=date.year-1), 'volume']+reg_coef.loc[date.month, 'coef']
for date in reversed(pd.date_range('2010-12-01', '2018-12-31')):
    if date.month == 2 and date.day == 29:
        continue
    domestic_mitigate.loc[date, 'volume'] = domestic_mitigate.loc[date+pd.DateOffset(
        year=date.year+1), 'volume']
for date in domestic_mitigate.index:
    if date.month == 2 and date.day == 29:
        pos = domestic_mitigate.index.get_loc(date)
        domestic_mitigate.loc[date, 'volume'] = (
            domestic_mitigate.iloc[pos-1, 0]+domestic_mitigate.iloc[pos+1, 0])/2

# moving average
for date in pd.date_range('2011-01-01', '2022-12-31'):
    startdate = date-pd.DateOffset(days=cnma)
    domestic_normal.loc[date,
                        'ma'] = domestic_normal.loc[startdate:date, 'volume'].mean()
    domestic_mitigate.loc[date,
                          'ma'] = domestic_mitigate.loc[startdate:date, 'volume'].mean()

# weekly sum
domestic_normal_weekly = pr_raw.copy()
domestic_mitigate_weekly = pr_raw.copy()
for date in pr_raw.index:
    start = domestic_normal_weekly.loc[date, 'startdate']
    end = domestic_normal_weekly.loc[date, 'enddate']
    domestic_normal_weekly.loc[date,
                               'weeklyraw'] = domestic_normal.loc[start:end, 'ma'].sum()
    domestic_mitigate_weekly.loc[date,
                                 'weeklyraw'] = domestic_mitigate.loc[start:end, 'ma'].sum()
# normalized by first month
for date in pr_raw.index:
    if pr_raw.loc[date, 'year'] <= 2019:
        domestic_normal_weekly.loc[date,
                                   'domestic_raw'] = domestic_normal_weekly.loc[date, 'weeklyraw']
        domestic_mitigate_weekly.loc[date,
                                     'domestic_raw'] = domestic_mitigate_weekly.loc[date, 'weeklyraw']
    else:
        startdate = pr_raw.loc[date, 'startdate']
        domestic_normal_weekly.loc[date, 'domestic_raw'] = (domestic_normal_weekly.loc[date, 'weeklyraw']/domestic_normal_weekly[(
            domestic_normal_weekly['startdate'].dt.year == startdate.year) & (domestic_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()*domestic_normal_weekly[(
                domestic_normal_weekly['startdate'].dt.year == 2019) & (domestic_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()).values
        domestic_mitigate_weekly.loc[date, 'domestic_raw'] = (domestic_mitigate_weekly.loc[date, 'weeklyraw']/domestic_normal_weekly[(
            domestic_normal_weekly['startdate'].dt.year == startdate.year) & (domestic_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()*domestic_normal_weekly[(
                domestic_normal_weekly['startdate'].dt.year == 2019) & (domestic_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()).values

# normalize to positive rate level
domestic_normal_weekly.loc[:, 'domestic'] = domestic_normal_weekly.loc[:, 'domestic_raw'] / \
    domestic_normal_weekly[domestic_normal_weekly['year'] <= 2019][[
        'domestic_raw']].values.max()*domestic_normal_weekly.loc[:, 'positive_rate'].max()
domestic_mitigate_weekly.loc[:, 'domestic'] = domestic_mitigate_weekly.loc[:, 'domestic_raw'] / \
    domestic_normal_weekly[domestic_normal_weekly['year'] <= 2019][[
        'domestic_raw']].values.max()*domestic_mitigate_weekly.loc[:, 'positive_rate'].max()

# international
reg_coef = pd.DataFrame(index=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], columns=[
                        'intercept', 'coef'])

# calculate the regression coef per month
for month in [1, 2, 5, 6, 7, 8, 9, 10, 11, 12]:
    xtrain = np.array([2019, 2018, 2017, 2016, 2015, 2014,
                      2013, 2012, 2011]).reshape(-1, 1)
    ytrain = international_raw[(international_raw['month'] == month) & (
        international_raw['year'] <= 2019)][['amount']].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[month, 'intercept'] = model.intercept_
    reg_coef.loc[month, 'coef'] = model.coef_[0]
for month in [3, 4]:
    xtrain = np.array([2019, 2018, 2017, 2016,  2014,
                      2013, 2012, 2011]).reshape(-1, 1)
    ytrain = international_raw[(international_raw['month'] == month) & (
        international_raw['year'] <= 2019) & (
        international_raw['year'] != 2015)][['amount']].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[month, 'intercept'] = model.intercept_
    reg_coef.loc[month, 'coef'] = model.coef_[0]
international_raw.loc[201503, 'amount'] = get_prediction_from_reg(
    reg_coef, 3, 2015)[0]
international_raw.loc[201504, 'amount'] = get_prediction_from_reg(
    reg_coef, 4, 2015)[0]
# monthly raw
month_i_mitigate = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
month_i_normal = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
for year in range(2011, 2020):
    for month in range(1, 13):
        month_i_normal.loc[year,
                           month] = international_raw.loc[year*100+month, 'amount']
for year in range(2020, 2023):
    for month in range(1, 13):
        month_i_normal.loc[year, month] = get_prediction_from_reg(
            reg_coef, month, year)
month_i_normal.loc[2010, 12] = get_prediction_from_reg(
    reg_coef, 12, 2010)

for year in range(2011, 2021):
    for month in range(1, 13):
        month_i_mitigate.loc[year,
                             month] = international_raw.loc[year*100+month, 'amount']
for month in range(1, 8):
    month_i_mitigate.loc[2021,
                         month] = international_raw.loc[2021*100+month, 'amount']
for month in range(8, 13):
    month_i_mitigate.loc[2021,
                         month] = month_i_mitigate.loc[2020, month]+reg_coef.loc[month, 'coef']
for month in range(1, 13):
    month_i_mitigate.loc[2022,
                         month] = month_i_mitigate.loc[2021, month]+reg_coef.loc[month, 'coef']
month_i_mitigate.loc[2010, 12] = get_prediction_from_reg(
    reg_coef, 12, 2010)


# daily raw
international_normal = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
international_mitigate = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
for date in international_normal.index:
    international_normal.loc[date, 'volume'] = month_i_normal.loc[date.year,
                                                                  date.month]/date.days_in_month
    international_mitigate.loc[date, 'volume'] = month_i_mitigate.loc[date.year,
                                                                      date.month]/date.days_in_month

# moving average
for date in pd.date_range('2011-01-01', '2022-12-31'):
    startdate = date-pd.DateOffset(days=cnma)
    international_normal.loc[date,
                             'ma'] = international_normal.loc[startdate:date, 'volume'].mean()
    international_mitigate.loc[date,
                               'ma'] = international_mitigate.loc[startdate:date, 'volume'].mean()
# weekly sum
international_normal_weekly = pr_raw.copy()
international_mitigate_weekly = pr_raw.copy()
for date in pr_raw.index:
    start = international_normal_weekly.loc[date, 'startdate']
    end = international_normal_weekly.loc[date, 'enddate']
    international_normal_weekly.loc[date,
                                    'weeklyraw'] = international_normal.loc[start:end, 'ma'].sum().reshape(-1)
    international_mitigate_weekly.loc[date,
                                      'weeklyraw'] = international_mitigate.loc[start:end, 'ma'].sum().reshape(-1)

# normalized by first month
for date in pr_raw.index:
    startdate = pr_raw.loc[date, 'startdate']
    international_normal_weekly.loc[date, 'international_raw'] = (international_normal_weekly.loc[date, 'weeklyraw']/international_normal_weekly[(
        international_normal_weekly['year'] == pr_raw.loc[date, 'year']) & (international_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()).values
    international_mitigate_weekly.loc[date, 'international_raw'] = (international_mitigate_weekly.loc[date, 'weeklyraw']/international_normal_weekly[(
        international_normal_weekly['year'] == pr_raw.loc[date, 'year']) & (international_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()).values

# normalize to positive rate level
international_normal_weekly.loc[:, 'international'] = international_normal_weekly.loc[:, 'international_raw'] / \
    international_normal_weekly[international_normal_weekly['year'] <= 2019][[
        'international_raw']].values.max()*international_normal_weekly.loc[:, 'positive_rate'].max()
international_mitigate_weekly.loc[:, 'international'] = international_mitigate_weekly.loc[:, 'international_raw'] / \
    international_normal_weekly[international_normal_weekly['year'] <= 2019][[
        'international_raw']].values.max()*international_mitigate_weekly.loc[:, 'positive_rate'].max()

seasonstart = 49
seasonend = 14
indicator = pr_raw.loc[201114:202252, ['year', 'week']].copy()
indicator['indicator'] = 0
idx = indicator[(indicator['week'] >= seasonstart) |
                (indicator['week'] <= seasonend)].index
indicator.loc[idx, 'indicator'] = 1
# file output
# cni
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202004:, 't2'] = 1
out.loc[:, 'volume'] = domestic_mitigate_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_mitigate_weekly.loc[out.index,
                                                     'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'cni.csv', header=True, index=True)
# cniv2
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202004:, 't2'] = 1
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'cniv2.csv', header=True, index=True)
# cni3vni
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.3
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'cni3vni.csv', header=True, index=True)
# cnimvni
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.5
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'cnimvni.csv', header=True, index=True)
# cni7vni
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.7
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'cni7vni.csv', header=True, index=True)
# cninv3i
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.3
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'cninv3i.csv', header=True, index=True)
# cninvmi
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.5
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'cninvmi.csv', header=True, index=True)
# cninv7i
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.7
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'cninv7i.csv', header=True, index=True)
# cnd1i2
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202004:, 't2'] = 1
out.loc[:, 'volume'] = domestic_mitigate_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'cnd1i2.csv', header=True, index=True)
# cnd2i1
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202004:, 't2'] = 1
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_mitigate_weekly.loc[out.index,
                                                     'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'cnd2i1.csv', header=True, index=True)
# cnmvmi
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.5
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'cnimvmi.csv', header=True, index=True)
# cnlog
vaccinestart = 202051
vaccineend = 202128
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['tmprate'] = out['positive_rate']
for idx in out.loc[202004:202128, :].index:
    if out.loc[idx, 'positive_rate'] == 0:
        pre = find_rate(out, -1, idx)
        nex = find_rate(out, 1, idx)
        if nex == 0:
            out.loc[idx, 'tmprate'] = pre
        else:
            out.loc[idx, 'tmprate'] = (pre+nex)/2
out['positive_rate'] = out['tmprate']
out.drop('tmprate', inplace=True, axis=1)
out['t2'] = 0
out.loc[202004:, 't2'] = 1
vaccine_data = vaccinedf.loc[vaccinestart:vaccineend, 'china'].values
vaccine_cpl = np.maximum(1-0.5*vaccine_data, 0.1)
out['cpl'] = 1
out.loc[vaccinestart:vaccineend, 'cpl'] = vaccine_cpl
out.loc[vaccineend:202139, 'cpl'] = out.loc[vaccineend, 'cpl']
out.loc[202140:, 'cpl'] = 0
out.to_csv(outputbasefolder+'cnlog.csv', header=True, index=True)

# Southern China
# read raw data
region = 'cs'
pr_raw = pd.read_csv(basefolder+'rawdata/'+region+'.csv', header=0, index_col=0)
pr_raw['startdate'] = pd.to_datetime(pr_raw['startdate'])
pr_raw['enddate'] = pd.to_datetime(pr_raw['enddate'])
domestic_raw = pd.read_csv(basefolder+
    'rawdata/'+region+'domestic.csv', header=0, index_col=0)
domestic_raw.index = pd.to_datetime(domestic_raw.index)
international_raw = pd.read_csv(basefolder+
    'rawdata/'+region+'international.csv', header=0, index_col=0)

# domestic
# calculate the montly average
average_d_mitigate = pd.DataFrame(index=[2019, 2020, 2021], columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
average_d_normal = pd.DataFrame(index=[2019, 2020, 2021], columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])

for year in [2019, 2020, 2021]:
    for month in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]:
        if year == 2021 and month >= 7:
            break
        average_d_mitigate.loc[year, month] = domestic_raw[(domestic_raw.index.year == year) & (
            domestic_raw.index.month == month)][['volume']].mean().values

reg_coef = pd.DataFrame(index=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], columns=[
                        'intercept', 'coef'])

# calculate the daily average regression coef per month
for month in range(1, 7):
    xtrain = np.array([2019, 2021]).reshape(-1, 1)
    ytrain = average_d_mitigate.loc[[2019, 2021], month].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[month, 'intercept'] = model.intercept_
    reg_coef.loc[month, 'coef'] = model.coef_[0]

for month in range(7, 13):
    xtrain = np.array([2019, 2020]).reshape(-1, 1)
    ytrain = average_d_mitigate.loc[[2019, 2020], month].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[month, 'intercept'] = model.intercept_
    reg_coef.loc[month, 'coef'] = model.coef_[0]

average_d_normal.loc[:, :] = average_d_mitigate.values
for month in [1, 2, 3, 4]:
    average_d_normal.loc[2020, month] = get_prediction_from_reg(
        reg_coef, month, 2020)
for month in [7, 8, 9, 10, 11, 12]:
    average_d_normal.loc[2021, month] = get_prediction_from_reg(
        reg_coef, month, 2021)
for month in range(1, 13):
    average_d_normal.loc[2022, month] = get_prediction_from_reg(
        reg_coef, month, 2022)

domestic_normal = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
domestic_mitigate = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])

# normal daily raw
domestic_normal.loc[pd.date_range('2019-01-01', '2021-07-15'),
                    'volume'] = domestic_raw.loc[pd.date_range('2019-01-01', '2021-07-15'), 'volume'].values
for date in pd.date_range('2020-01-01', '2020-04-30'):
    if date.month == 2 and date.day == 29:
        continue
    domestic_normal.loc[date, 'volume'] = domestic_normal.loc[date-pd.DateOffset(
        year=date.year-1), 'volume']+reg_coef.loc[date.month, 'coef']
for date in pd.date_range('2021-07-01', '2022-12-31'):
    if date.month == 2 and date.day == 29:
        continue
    domestic_normal.loc[date, 'volume'] = domestic_normal.loc[date-pd.DateOffset(
        year=date.year-1), 'volume']+reg_coef.loc[date.month, 'coef']
for date in reversed(pd.date_range('2010-12-01', '2018-12-31')):
    if date.month == 2 and date.day == 29:
        continue
    domestic_normal.loc[date, 'volume'] = domestic_normal.loc[date+pd.DateOffset(
        year=date.year+1), 'volume']
for date in domestic_normal.index:
    if date.month == 2 and date.day == 29:
        pos = domestic_normal.index.get_loc(date)
        domestic_normal.loc[date, 'volume'] = (
            domestic_normal.iloc[pos-1, 0]+domestic_normal.iloc[pos+1, 0])/2

# mitigate daily raw
domestic_mitigate.loc[pd.date_range('2019-01-01', '2021-07-15'),
                      'volume'] = domestic_raw.loc[pd.date_range('2019-01-01', '2021-07-15'), 'volume'].values
for date in pd.date_range('2021-07-16', '2022-12-31'):
    if date.month == 2 and date.day == 29:
        continue
    domestic_mitigate.loc[date, 'volume'] = domestic_mitigate.loc[date-pd.DateOffset(
        year=date.year-1), 'volume']+reg_coef.loc[date.month, 'coef']
for date in reversed(pd.date_range('2010-12-01', '2018-12-31')):
    if date.month == 2 and date.day == 29:
        continue
    domestic_mitigate.loc[date, 'volume'] = domestic_mitigate.loc[date+pd.DateOffset(
        year=date.year+1), 'volume']
for date in domestic_mitigate.index:
    if date.month == 2 and date.day == 29:
        pos = domestic_mitigate.index.get_loc(date)
        domestic_mitigate.loc[date, 'volume'] = (
            domestic_mitigate.iloc[pos-1, 0]+domestic_mitigate.iloc[pos+1, 0])/2

# moving average
for date in pd.date_range('2011-01-01', '2022-12-31'):
    startdate = date-pd.DateOffset(days=csma)
    domestic_normal.loc[date,
                        'ma'] = domestic_normal.loc[startdate:date, 'volume'].mean()
    domestic_mitigate.loc[date,
                          'ma'] = domestic_mitigate.loc[startdate:date, 'volume'].mean()

# weekly sum
domestic_normal_weekly = pr_raw.copy()
domestic_mitigate_weekly = pr_raw.copy()
for date in pr_raw.index:
    start = domestic_normal_weekly.loc[date, 'startdate']
    end = domestic_normal_weekly.loc[date, 'enddate']
    domestic_normal_weekly.loc[date,
                               'weeklyraw'] = domestic_normal.loc[start:end, 'ma'].sum()
    domestic_mitigate_weekly.loc[date,
                                 'weeklyraw'] = domestic_mitigate.loc[start:end, 'ma'].sum()
# normalized by first month
for date in pr_raw.index:
    if pr_raw.loc[date, 'year'] <= 2019:
        domestic_normal_weekly.loc[date,
                                   'domestic_raw'] = domestic_normal_weekly.loc[date, 'weeklyraw']
        domestic_mitigate_weekly.loc[date,
                                     'domestic_raw'] = domestic_mitigate_weekly.loc[date, 'weeklyraw']
    else:
        startdate = pr_raw.loc[date, 'startdate']
        domestic_normal_weekly.loc[date, 'domestic_raw'] = (domestic_normal_weekly.loc[date, 'weeklyraw']/domestic_normal_weekly[(
            domestic_normal_weekly['startdate'].dt.year == startdate.year) & (domestic_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()*domestic_normal_weekly[(
                domestic_normal_weekly['startdate'].dt.year == 2019) & (domestic_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()).values
        domestic_mitigate_weekly.loc[date, 'domestic_raw'] = (domestic_mitigate_weekly.loc[date, 'weeklyraw']/domestic_normal_weekly[(
            domestic_normal_weekly['startdate'].dt.year == startdate.year) & (domestic_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()*domestic_normal_weekly[(
                domestic_normal_weekly['startdate'].dt.year == 2019) & (domestic_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()).values

# normalize to positive rate level
domestic_normal_weekly.loc[:, 'domestic'] = domestic_normal_weekly.loc[:, 'domestic_raw'] / \
    domestic_normal_weekly[domestic_normal_weekly['year'] <= 2019][[
        'domestic_raw']].values.max()*domestic_normal_weekly.loc[:, 'positive_rate'].max()
domestic_mitigate_weekly.loc[:, 'domestic'] = domestic_mitigate_weekly.loc[:, 'domestic_raw'] / \
    domestic_normal_weekly[domestic_normal_weekly['year'] <= 2019][[
        'domestic_raw']].values.max()*domestic_mitigate_weekly.loc[:, 'positive_rate'].max()

# international
reg_coef = pd.DataFrame(index=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], columns=[
                        'intercept', 'coef'])

# calculate the regression coef per month
for month in [1, 2, 5, 6, 7, 8, 9, 10, 11, 12]:
    xtrain = np.array([2019, 2018, 2017, 2016, 2015, 2014,
                      2013, 2012, 2011]).reshape(-1, 1)
    ytrain = international_raw[(international_raw['month'] == month) & (
        international_raw['year'] <= 2019)][['amount']].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[month, 'intercept'] = model.intercept_
    reg_coef.loc[month, 'coef'] = model.coef_[0]
for month in [3, 4]:
    xtrain = np.array([2019, 2018, 2017, 2016,  2014,
                      2013, 2012, 2011]).reshape(-1, 1)
    ytrain = international_raw[(international_raw['month'] == month) & (
        international_raw['year'] <= 2019) & (
        international_raw['year'] != 2015)][['amount']].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[month, 'intercept'] = model.intercept_
    reg_coef.loc[month, 'coef'] = model.coef_[0]
international_raw.loc[201503, 'amount'] = get_prediction_from_reg(
    reg_coef, 3, 2015)[0]
international_raw.loc[201504, 'amount'] = get_prediction_from_reg(
    reg_coef, 4, 2015)[0]
# monthly raw
month_i_mitigate = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
month_i_normal = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
for year in range(2011, 2020):
    for month in range(1, 13):
        month_i_normal.loc[year,
                           month] = international_raw.loc[year*100+month, 'amount']
for year in range(2020, 2023):
    for month in range(1, 13):
        month_i_normal.loc[year, month] = get_prediction_from_reg(
            reg_coef, month, year)
month_i_normal.loc[2010, 12] = get_prediction_from_reg(
    reg_coef, 12, 2010)

for year in range(2011, 2021):
    for month in range(1, 13):
        month_i_mitigate.loc[year,
                             month] = international_raw.loc[year*100+month, 'amount']
for month in range(1, 8):
    month_i_mitigate.loc[2021,
                         month] = international_raw.loc[2021*100+month, 'amount']
for month in range(8, 13):
    month_i_mitigate.loc[2021,
                         month] = month_i_mitigate.loc[2020, month]+reg_coef.loc[month, 'coef']
for month in range(1, 13):
    month_i_mitigate.loc[2022,
                         month] = month_i_mitigate.loc[2021, month]+reg_coef.loc[month, 'coef']
month_i_mitigate.loc[2010, 12] = get_prediction_from_reg(
    reg_coef, 12, 2010)


# daily raw
international_normal = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
international_mitigate = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
for date in international_normal.index:
    international_normal.loc[date, 'volume'] = month_i_normal.loc[date.year,
                                                                  date.month]/date.days_in_month
    international_mitigate.loc[date, 'volume'] = month_i_mitigate.loc[date.year,
                                                                      date.month]/date.days_in_month

# moving average
for date in pd.date_range('2011-01-01', '2022-12-31'):
    startdate = date-pd.DateOffset(days=csma)
    international_normal.loc[date,
                             'ma'] = international_normal.loc[startdate:date, 'volume'].mean()
    international_mitigate.loc[date,
                               'ma'] = international_mitigate.loc[startdate:date, 'volume'].mean()
# weekly sum
international_normal_weekly = pr_raw.copy()
international_mitigate_weekly = pr_raw.copy()
for date in pr_raw.index:
    start = international_normal_weekly.loc[date, 'startdate']
    end = international_normal_weekly.loc[date, 'enddate']
    international_normal_weekly.loc[date,
                                    'weeklyraw'] = international_normal.loc[start:end, 'ma'].sum().reshape(-1)
    international_mitigate_weekly.loc[date,
                                      'weeklyraw'] = international_mitigate.loc[start:end, 'ma'].sum().reshape(-1)

# normalized by first month
for date in pr_raw.index:
    startdate = pr_raw.loc[date, 'startdate']
    international_normal_weekly.loc[date, 'international_raw'] = (international_normal_weekly.loc[date, 'weeklyraw']/international_normal_weekly[(
        international_normal_weekly['year'] == pr_raw.loc[date, 'year']) & (international_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()).values
    international_mitigate_weekly.loc[date, 'international_raw'] = (international_mitigate_weekly.loc[date, 'weeklyraw']/international_normal_weekly[(
        international_normal_weekly['year'] == pr_raw.loc[date, 'year']) & (international_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()).values

# normalize to positive rate level
international_normal_weekly.loc[:, 'international'] = international_normal_weekly.loc[:, 'international_raw'] / \
    international_normal_weekly[international_normal_weekly['year'] <= 2019][[
        'international_raw']].values.max()*international_normal_weekly.loc[:, 'positive_rate'].max()
international_mitigate_weekly.loc[:, 'international'] = international_mitigate_weekly.loc[:, 'international_raw'] / \
    international_normal_weekly[international_normal_weekly['year'] <= 2019][[
        'international_raw']].values.max()*international_mitigate_weekly.loc[:, 'positive_rate'].max()

seasonstart = 45
seasonend = 15
indicator = pr_raw.loc[201114:202252, ['year', 'week']].copy()
indicator['indicator'] = 0
idx = indicator[(indicator['week'] >= seasonstart) |
                (indicator['week'] <= seasonend)].index
indicator.loc[idx, 'indicator'] = 1
# file output
# csib3
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202004:, 't2'] = 1
out.loc[:, 'volume'] = domestic_mitigate_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_mitigate_weekly.loc[out.index,
                                                     'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'csib3.csv', header=True, index=True)
# csiv2b3
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202004:, 't2'] = 1
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'csiv2b3.csv', header=True, index=True)
# csi3vni
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.3
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'csi3vni.csv', header=True, index=True)
# csib3mvni
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.5
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'csib3mvni.csv', header=True, index=True)
# csi7vni
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.7
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'csi7vni.csv', header=True, index=True)
# csinv3i
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.3
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'csinv3i.csv', header=True, index=True)
# csib3nvmi
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.5
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'csib3nvmi.csv', header=True, index=True)
# csinv7i
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.7
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'csinv7i.csv', header=True, index=True)
# csd1i2
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202004:, 't2'] = 1
out.loc[:, 'volume'] = domestic_mitigate_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'csd1i2.csv', header=True, index=True)
# csd2i1
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202004:, 't2'] = 1
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_mitigate_weekly.loc[out.index,
                                                     'international'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'csd2i1.csv', header=True, index=True)
# csimumi
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202004:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.5
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'csimvmi.csv', header=True, index=True)
# cslog
vaccinestart = 202051
vaccineend = 202128
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['tmprate'] = out['positive_rate']
for idx in out.loc[202004:202128, :].index:
    if out.loc[idx, 'positive_rate'] == 0:
        pre = find_rate(out, -1, idx)
        nex = find_rate(out, 1, idx)
        if nex == 0:
            out.loc[idx, 'tmprate'] = pre
        else:
            out.loc[idx, 'tmprate'] = (pre+nex)/2
out['positive_rate'] = out['tmprate']
out.drop('tmprate', inplace=True, axis=1)
out['t2'] = 0
out.loc[202004:, 't2'] = 1
vaccine_data = vaccinedf.loc[vaccinestart:vaccineend, 'china'].values
vaccine_cpl = np.maximum(1-0.5*vaccine_data, 0.3)
out['cpl'] = 1
out.loc[vaccinestart:vaccineend, 'cpl'] = vaccine_cpl
out.loc[vaccineend:202139, 'cpl'] = out.loc[vaccineend, 'cpl']
out.loc[202140:, 'cpl'] = 0
out.to_csv(outputbasefolder+'cslog.csv', header=True, index=True)

# usa
# read raw data
region = 'usa'
pr_raw = pd.read_csv(basefolder+'rawdata/'+region+'.csv', header=0, index_col=0)
pr_raw['startdate'] = pd.to_datetime(pr_raw['startdate'])
pr_raw['enddate'] = pd.to_datetime(pr_raw['enddate'])
domestic_raw = pd.read_csv(basefolder+
    'rawdata/'+region+'domestic.csv', header=0, index_col=0)
international_raw = pd.read_csv(basefolder+
    'rawdata/'+region+'international.csv', header=0, index_col=0)

# domestic
# calculate the regression coef per month
reg_coef = pd.DataFrame(index=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], columns=[
                        'intercept', 'coef'])

for month in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]:
    xtrain = np.array([2011, 2012, 2013, 2014, 2015, 2016,
                      2017, 2018, 2019]).reshape(-1, 1)
    ytrain = domestic_raw[(domestic_raw['month'] == month) & (
        domestic_raw['year'] <= 2019) & (
        domestic_raw['year'] >= 2011)][['amount']].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[month, 'intercept'] = model.intercept_
    reg_coef.loc[month, 'coef'] = model.coef_[0]

# monthly raw
month_d_mitigate = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
month_d_normal = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
for year in range(2011, 2020):
    for month in range(1, 13):
        month_d_normal.loc[year,
                           month] = domestic_raw.loc[year*100+month, 'amount']
for year in [2020, 2021, 2022]:
    for month in range(1, 13):
        month_d_normal.loc[year, month] = get_prediction_from_reg(
            reg_coef, month, year)
month_d_normal.loc[2010, 12] = domestic_raw.loc[201012, 'amount']
for year in range(2011, 2021):
    for month in range(1, 13):
        month_d_mitigate.loc[year,
                             month] = domestic_raw.loc[year*100+month, 'amount']
for month in [1, 2, 3, 4, 5]:
    month_d_mitigate.loc[2021,
                         month] = domestic_raw.loc[2021*100+month, 'amount']
for month in [6, 7, 8, 9, 10, 11, 12]:
    month_d_mitigate.loc[2021,
                         month] = month_d_mitigate.loc[2020, month]+reg_coef.loc[month, 'coef']
for month in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]:
    month_d_mitigate.loc[2022,
                         month] = month_d_mitigate.loc[2021, month]+reg_coef.loc[month, 'coef']
month_d_mitigate.loc[2010, 12] = domestic_raw.loc[201012, 'amount']

# daily raw
domestic_normal = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
domestic_mitigate = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
for date in domestic_normal.index:
    domestic_normal.loc[date, 'volume'] = month_d_normal.loc[date.year,
                                                             date.month]/date.days_in_month
    domestic_mitigate.loc[date, 'volume'] = month_d_mitigate.loc[date.year,
                                                                 date.month]/date.days_in_month

# moving average
for date in pd.date_range('2011-01-01', '2022-12-31'):
    startdate = date-pd.DateOffset(days=usama)
    domestic_normal.loc[date,
                        'ma'] = domestic_normal.loc[startdate:date, 'volume'].mean()
    domestic_mitigate.loc[date,
                          'ma'] = domestic_mitigate.loc[startdate:date, 'volume'].mean()

# weekly sum
domestic_normal_weekly = pr_raw.copy()
domestic_mitigate_weekly = pr_raw.copy()
for date in pr_raw.index:
    start = domestic_normal_weekly.loc[date, 'startdate']
    end = domestic_normal_weekly.loc[date, 'enddate']
    domestic_normal_weekly.loc[date,
                               'weeklyraw'] = np.array(domestic_normal.loc[start:end, 'ma'].sum()).reshape(-1)
    domestic_mitigate_weekly.loc[date,
                                 'weeklyraw'] = np.array(domestic_mitigate.loc[start:end, 'ma'].sum()).reshape(-1)

# normalized by first month
normcoef = pd.DataFrame(index=range(2011, 2023),
                        columns=['coef'])
for year in range(2011, 2023):
    normcoef.loc[year, 'coef'] = domestic_normal_weekly[(
        domestic_normal_weekly['startdate'].dt.month == 1) & (domestic_normal_weekly['year'] == year)][['weeklyraw']].mean().values

for date in pr_raw.index:
    startdate = pr_raw.loc[date, 'startdate']
    domestic_normal_weekly.loc[date, 'domestic_raw'] = domestic_normal_weekly.loc[date,
                                                                                  'weeklyraw']/normcoef.loc[domestic_normal_weekly.loc[date, 'year'], 'coef']
    domestic_mitigate_weekly.loc[date, 'domestic_raw'] = domestic_mitigate_weekly.loc[date,
                                                                                      'weeklyraw']/normcoef.loc[domestic_mitigate_weekly.loc[date, 'year'], 'coef']

# normalize to positive rate level
domestic_normal_weekly.loc[:, 'domestic'] = domestic_normal_weekly.loc[:, 'domestic_raw'] / \
    domestic_normal_weekly[domestic_normal_weekly['year'] <= 2019][[
        'domestic_raw']].values.max()*domestic_normal_weekly.loc[:, 'positive_rate'].max()
domestic_mitigate_weekly.loc[:, 'domestic'] = domestic_mitigate_weekly.loc[:, 'domestic_raw'] / \
    domestic_normal_weekly[domestic_normal_weekly['year'] <= 2019][[
        'domestic_raw']].values.max()*domestic_mitigate_weekly.loc[:, 'positive_rate'].max()

# international
# calculate the regression coef per month
reg_coef = pd.DataFrame(index=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], columns=[
                        'intercept', 'coef'])

for month in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]:
    xtrain = np.array([2011, 2012, 2013, 2014, 2015, 2016,
                      2017, 2018, 2019]).reshape(-1, 1)
    ytrain = international_raw[(international_raw['month'] == month) & (
        international_raw['year'] <= 2019) & (
        international_raw['year'] >= 2011)][['amount']].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[month, 'intercept'] = model.intercept_
    reg_coef.loc[month, 'coef'] = model.coef_[0]

# monthly raw
month_i_mitigate = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
month_i_normal = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
for year in range(2011, 2020):
    for month in range(1, 13):
        month_i_normal.loc[year,
                           month] = international_raw.loc[year*100+month, 'amount']
for year in [2020, 2021, 2022]:
    for month in range(1, 13):
        month_i_normal.loc[year, month] = get_prediction_from_reg(
            reg_coef, month, year)
month_i_normal.loc[2010, 12] = get_prediction_from_reg(reg_coef, 12, 2010)
for year in range(2011, 2021):
    for month in range(1, 13):
        month_i_mitigate.loc[year,
                             month] = international_raw.loc[year*100+month, 'amount']
for month in [1, 2, 3, 4, 5, 6]:
    month_i_mitigate.loc[2021,
                         month] = international_raw.loc[2021*100+month, 'amount']
for month in [7, 8, 9, 10, 11, 12]:
    month_i_mitigate.loc[2021,
                         month] = month_i_mitigate.loc[2020, month]+reg_coef.loc[month, 'coef']
for month in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]:
    month_i_mitigate.loc[2022,
                         month] = month_i_mitigate.loc[2021, month]+reg_coef.loc[month, 'coef']
month_i_mitigate.loc[2010, 12] = get_prediction_from_reg(reg_coef, 12, 2010)

# daily raw
international_normal = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
international_mitigate = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
for date in international_normal.index:
    international_normal.loc[date, 'volume'] = month_i_normal.loc[date.year,
                                                                  date.month]/date.days_in_month
    international_mitigate.loc[date, 'volume'] = month_i_mitigate.loc[date.year,
                                                                      date.month]/date.days_in_month

# moving average
for date in pd.date_range('2011-01-01', '2022-12-31'):
    startdate = date-pd.DateOffset(days=usama)
    international_normal.loc[date,
                             'ma'] = international_normal.loc[startdate:date, 'volume'].mean()
    international_mitigate.loc[date,
                               'ma'] = international_mitigate.loc[startdate:date, 'volume'].mean()

# weekly sum
international_normal_weekly = pr_raw.copy()
international_mitigate_weekly = pr_raw.copy()
for date in pr_raw.index:
    start = international_normal_weekly.loc[date, 'startdate']
    end = international_normal_weekly.loc[date, 'enddate']
    international_normal_weekly.loc[date,
                                    'weeklyraw'] = np.array(international_normal.loc[start:end, 'ma'].sum()).reshape(-1)
    international_mitigate_weekly.loc[date,
                                      'weeklyraw'] = np.array(international_mitigate.loc[start:end, 'ma'].sum()).reshape(-1)

# normalized by first month
for date in pr_raw.index:
    startdate = pr_raw.loc[date, 'startdate']
    international_normal_weekly.loc[date, 'international_raw'] = (international_normal_weekly.loc[date, 'weeklyraw']/international_normal_weekly[(
        international_normal_weekly['startdate'].dt.year == startdate.year) & (international_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()).values
    international_mitigate_weekly.loc[date, 'international_raw'] = (international_mitigate_weekly.loc[date, 'weeklyraw']/international_normal_weekly[(
        international_normal_weekly['startdate'].dt.year == startdate.year) & (international_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()).values

# normalize to positive rate level
international_normal_weekly.loc[:, 'international'] = international_normal_weekly.loc[:, 'international_raw'] / \
    international_normal_weekly[international_normal_weekly['year'] <= 2019][[
        'international_raw']].values.max()*international_normal_weekly.loc[:, 'positive_rate'].max()
international_mitigate_weekly.loc[:, 'international'] = international_mitigate_weekly.loc[:, 'international_raw'] / \
    international_normal_weekly[international_normal_weekly['year'] <= 2019][[
        'international_raw']].values.max()*international_mitigate_weekly.loc[:, 'positive_rate'].max()

seasonstart = 48
seasonend = 15
indicator = pr_raw.loc[201140:202252, ['year', 'week']].copy()
indicator['indicator'] = 0
idx = indicator[(indicator['week'] >= seasonstart) |
                (indicator['week'] <= seasonend)].index
indicator.loc[idx, 'indicator'] = 1
# file output
# usa
out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202014:202128, 't2'] = pr_raw.loc[202014:202128, 'maskindex']
out.loc[202129:202139, 't2'] = pr_raw.loc[202128, 'maskindex']
out.loc[202140:, 't2'] = 1
out.loc[:, 'volume'] = domestic_mitigate_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_mitigate_weekly.loc[out.index,
                                                     'international'].values*(indicator['indicator'].values if use_indicator_international else 1)
vaccinestart = 202052
vaccineend = 202128
vaccine_data = vaccinedf.loc[vaccinestart:vaccineend, 'usa'].values
# vaccine_cpl = np.maximum(1-0.05*vaccine_data, 0)
vaccine_cpl = np.maximum(1-0.5*vaccine_data, 0.7)
out['cpl'] = 1
out.loc[vaccinestart:vaccineend, 'cpl'] = vaccine_cpl
out.loc[vaccineend:202139, 'cpl'] = out.loc[vaccineend, 'cpl']
out.loc[202140:, 'cpl'] = 0
out.to_csv(outputbasefolder+'usa.csv', header=True, index=True)
# usav2
out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202014:, 't2'] = 1
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'usav2.csv', header=True, index=True)

# usa3vni
out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202014:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.3
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_domestic else 1)
out['indicator'] = 0
idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
out.loc[idx, 'indicator'] = 1
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'usa3vni.csv', header=True, index=True)
# usamvni
out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202014:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.5
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_domestic else 1)
out['indicator'] = 0
idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
out.loc[idx, 'indicator'] = 1
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'usamvni.csv', header=True, index=True)
# usa7vni
out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202014:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.7
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_domestic else 1)
out['indicator'] = 0
idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
out.loc[idx, 'indicator'] = 1
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'usa7vni.csv', header=True, index=True)
# usanv3i
out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202014:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.3
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*(indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'usanv3i.csv', header=True, index=True)
# usanvmi
out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202014:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.5
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*(indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'usanvmi.csv', header=True, index=True)
# usanv7i
out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202014:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.7
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*(indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'usanv7i.csv', header=True, index=True)
# usad1i2
out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 0
out['t2'] = 0
out.loc[202014:, 't2'] = 1
idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
out.loc[idx, 'indicator'] = 1
out.loc[:, 'volume'] = domestic_mitigate_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'usad1i2.csv', header=True, index=True)
# usad2i1
out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 0
out['t2'] = 0
out.loc[202014:, 't2'] = 1
idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
out.loc[idx, 'indicator'] = 1
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_mitigate_weekly.loc[out.index,
                                                     'international'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'usad2i1.csv', header=True, index=True)
# usamvmi
out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202014:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.5
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'usamvmi.csv', header=True, index=True)

# england
# read raw data
region = 'uk'
pr_raw = pd.read_csv(basefolder+'rawdata/'+region+'.csv', header=0, index_col=0)
pr_raw['startdate'] = pd.to_datetime(pr_raw['startdate'])
pr_raw['enddate'] = pd.to_datetime(pr_raw['enddate'])
domestic_raw = pd.read_csv(basefolder+
    'rawdata/'+region+'domestic.csv', header=0, index_col=0)
domestic_raw_0305 = pd.read_csv(basefolder+
    'rawdata/'+region+'domestic_0305.csv', header=0, index_col=0)
international_raw = pd.read_csv(basefolder+
    'rawdata/'+region+'international.csv', header=0, index_col=0)

# domestic
# calculate the regression coef per quarter
reg_coef = pd.DataFrame(index=[1, 2, 3, 4], columns=[
                        'intercept', 'coef'])

for quarter in [1, 2, 3, 4]:
    xtrain = np.array([2011, 2012, 2013, 2014, 2015, 2016,
                      2017, 2018, 2019]).reshape(-1, 1)
    ytrain = domestic_raw[(domestic_raw['quarter'] == quarter) & (
        domestic_raw['year'] <= 2019) & (
        domestic_raw['year'] >= 2011)][['volume']].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[quarter, 'intercept'] = model.intercept_
    reg_coef.loc[quarter, 'coef'] = model.coef_[0]

# quarterly raw
quarter_d_mitigate = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4])
quarter_d_normal = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4])

for year in range(2011, 2020):
    for quarter in range(1, 5):
        quarter_d_normal.loc[year,
                             quarter] = domestic_raw.loc[year*10+quarter, 'volume']

for year in range(2020, 2023):
    for quarter in range(1, 5):
        quarter_d_normal.loc[year, quarter] = get_prediction_from_reg(
            reg_coef, quarter, year)
quarter_d_normal.loc[2010, 4] = domestic_raw.loc[20104, 'volume']

for year in range(2011, 2021):
    for quarter in range(1, 5):
        quarter_d_mitigate.loc[year,
                               quarter] = domestic_raw.loc[year*10+quarter, 'volume']
quarter_d_mitigate.loc[2010, 4] = domestic_raw.loc[20104, 'volume']
quarter_d_mitigate.loc[2021, 1] = domestic_raw.loc[20211, 'volume']
for quarter in range(2, 5):
    quarter_d_mitigate.loc[2021, quarter] = quarter_d_mitigate.loc[2020,
                                                                   quarter]+reg_coef.loc[quarter, 'coef']
for quarter in range(1, 5):
    quarter_d_mitigate.loc[2022, quarter] = quarter_d_mitigate.loc[2021,
                                                                   quarter]+reg_coef.loc[quarter, 'coef']

# monthly raw
month_d_mitigate = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
month_d_normal = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
for year in range(2010, 2023):
    for month in range(1, 13):
        month_d_normal.loc[year,
                           month] = quarter_d_normal.loc[year, int((month+2)/3)]/3
        month_d_mitigate.loc[year,
                             month] = quarter_d_mitigate.loc[year, int((month+2)/3)]/3
for month in range(1, 13):
    month_d_mitigate.loc[2020,
                         month] = month_d_mitigate.loc[2019, month]*domestic_raw_0305.loc[month, 'average']/100

# daily raw
domestic_normal = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
domestic_mitigate = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
for date in domestic_normal.index:
    domestic_normal.loc[date, 'volume'] = month_d_normal.loc[date.year,
                                                             date.month]/date.days_in_month
    domestic_mitigate.loc[date, 'volume'] = month_d_mitigate.loc[date.year,
                                                                 date.month]/date.days_in_month

# moving average
for date in pd.date_range('2011-01-01', '2022-12-31'):
    startdate = date-pd.DateOffset(days=ukma)
    domestic_normal.loc[date,
                        'ma'] = domestic_normal.loc[startdate:date, 'volume'].mean()
    domestic_mitigate.loc[date,
                          'ma'] = domestic_mitigate.loc[startdate:date, 'volume'].mean()

# weekly sum
domestic_normal_weekly = pr_raw.copy()
domestic_mitigate_weekly = pr_raw.copy()
for date in pr_raw.index:
    start = domestic_normal_weekly.loc[date, 'startdate']
    end = domestic_normal_weekly.loc[date, 'enddate']
    domestic_normal_weekly.loc[date,
                               'weeklyraw'] = domestic_normal.loc[start:end, 'ma'].sum().reshape(-1)
    domestic_mitigate_weekly.loc[date,
                                 'weeklyraw'] = domestic_mitigate.loc[start:end, 'ma'].sum().reshape(-1)

# normalized by first month
normcoef = pd.DataFrame(index=range(2011, 2023),
                        columns=['mitigate', 'normal'])
for year in range(2011, 2023):
    normcoef.loc[year, 'normal'] = domestic_normal_weekly[(
        domestic_normal_weekly['startdate'].dt.month == 1) & (domestic_normal_weekly['year'] == year)][['weeklyraw']].mean().values
    normcoef.loc[year, 'mitigate'] = normcoef.loc[year, 'normal']
normcoef.loc[2020, 'mitigate'] = domestic_mitigate_weekly[(
    domestic_mitigate_weekly['startdate'].dt.month == 1) & (domestic_mitigate_weekly['year'] == 2020)][['weeklyraw']].mean().values

for date in pr_raw.index:
    startdate = pr_raw.loc[date, 'startdate']
    domestic_normal_weekly.loc[date, 'domestic_raw'] = domestic_normal_weekly.loc[date,
                                                                                  'weeklyraw']/normcoef.loc[domestic_normal_weekly.loc[date, 'year'], 'normal']
    domestic_mitigate_weekly.loc[date, 'domestic_raw'] = domestic_mitigate_weekly.loc[date,
                                                                                      'weeklyraw']/normcoef.loc[domestic_mitigate_weekly.loc[date, 'year'], 'mitigate']

# normalize to positive rate level
domestic_normal_weekly.loc[:, 'domestic'] = domestic_normal_weekly.loc[:, 'domestic_raw'] / \
    domestic_normal_weekly[domestic_normal_weekly['year'] <= 2019][[
        'domestic_raw']].values.max()*domestic_normal_weekly.loc[:, 'positive_rate'].max()
domestic_mitigate_weekly.loc[:, 'domestic'] = domestic_mitigate_weekly.loc[:, 'domestic_raw'] / \
    domestic_normal_weekly[domestic_normal_weekly['year'] <= 2019][[
        'domestic_raw']].values.max()*domestic_mitigate_weekly.loc[:, 'positive_rate'].max()

# international
# calculate the regression coef per quarter
reg_coef = pd.DataFrame(index=[1, 2, 3, 4], columns=[
                        'intercept', 'coef'])

for quarter in [1, 2, 3, 4]:
    xtrain = np.array([2011, 2012, 2013, 2014, 2015, 2016,
                      2017, 2018, 2019]).reshape(-1, 1)
    ytrain = international_raw[(international_raw['quarter'] == quarter) & (
        international_raw['year'] <= 2019) & (
        international_raw['year'] >= 2011)][['volume']].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[quarter, 'intercept'] = model.intercept_
    reg_coef.loc[quarter, 'coef'] = model.coef_[0]

# quarterly raw
quarter_i_mitigate = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4])
quarter_i_normal = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4])

for year in range(2011, 2020):
    for quarter in range(1, 5):
        quarter_i_normal.loc[year,
                             quarter] = international_raw.loc[year*10+quarter, 'volume']

for year in range(2020, 2023):
    for quarter in range(1, 5):
        quarter_i_normal.loc[year, quarter] = get_prediction_from_reg(
            reg_coef, quarter, year)
quarter_i_normal.loc[2010, 4] = international_raw.loc[20104, 'volume']

for year in range(2011, 2021):
    for quarter in range(1, 5):
        quarter_i_mitigate.loc[year,
                               quarter] = international_raw.loc[year*10+quarter, 'volume']
quarter_i_mitigate.loc[2010, 4] = international_raw.loc[20104, 'volume']
quarter_i_mitigate.loc[2021, 1] = international_raw.loc[20211, 'volume']
for quarter in range(2, 5):
    quarter_i_mitigate.loc[2021, quarter] = quarter_i_mitigate.loc[2020,
                                                                   quarter]+reg_coef.loc[quarter, 'coef']
for quarter in range(1, 5):
    quarter_i_mitigate.loc[2022, quarter] = quarter_i_mitigate.loc[2021,
                                                                   quarter]+reg_coef.loc[quarter, 'coef']

# monthly raw
month_i_mitigate = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
month_i_normal = pd.DataFrame(index=range(2010, 2023), columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
for year in range(2010, 2023):
    for month in range(1, 13):
        month_i_normal.loc[year,
                           month] = quarter_i_normal.loc[year, int((month+2)/3)]/3
        month_i_mitigate.loc[year,
                             month] = quarter_i_mitigate.loc[year, int((month+2)/3)]/3

# daily raw
international_normal = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
international_mitigate = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
for date in international_normal.index:
    international_normal.loc[date, 'volume'] = month_i_normal.loc[date.year,
                                                                  date.month]/date.days_in_month
    international_mitigate.loc[date, 'volume'] = month_i_mitigate.loc[date.year,
                                                                      date.month]/date.days_in_month

# moving average
for date in pd.date_range('2011-01-01', '2022-12-31'):
    startdate = date-pd.DateOffset(days=ukma)
    international_normal.loc[date,
                             'ma'] = international_normal.loc[startdate:date, 'volume'].mean()
    international_mitigate.loc[date,
                               'ma'] = international_mitigate.loc[startdate:date, 'volume'].mean()

# weekly sum
international_normal_weekly = pr_raw.copy()
international_mitigate_weekly = pr_raw.copy()
for date in pr_raw.index:
    start = international_normal_weekly.loc[date, 'startdate']
    end = international_normal_weekly.loc[date, 'enddate']
    international_normal_weekly.loc[date,
                                    'weeklyraw'] = international_normal.loc[start:end, 'ma'].sum().reshape(-1)
    international_mitigate_weekly.loc[date,
                                      'weeklyraw'] = international_mitigate.loc[start:end, 'ma'].sum().reshape(-1)

# normalized by first month
normcoef = pd.DataFrame(index=range(2011, 2023),
                        columns=['mitigate', 'normal'])
for year in range(2011, 2023):
    normcoef.loc[year, 'normal'] = international_normal_weekly[(
        international_normal_weekly['startdate'].dt.month == 1) & (international_normal_weekly['year'] == year)][['weeklyraw']].mean().values
    normcoef.loc[year, 'mitigate'] = normcoef.loc[year, 'normal']

for date in pr_raw.index:
    startdate = pr_raw.loc[date, 'startdate']
    international_normal_weekly.loc[date, 'international_raw'] = international_normal_weekly.loc[date,
                                                                                                 'weeklyraw']/normcoef.loc[international_normal_weekly.loc[date, 'year'], 'normal']
    international_mitigate_weekly.loc[date, 'international_raw'] = international_mitigate_weekly.loc[date,
                                                                                                     'weeklyraw']/normcoef.loc[international_mitigate_weekly.loc[date, 'year'], 'mitigate']

# normalize to positive rate level
international_normal_weekly.loc[:, 'international'] = international_normal_weekly.loc[:, 'international_raw'] / \
    international_normal_weekly[international_normal_weekly['year'] <= 2019][[
        'international_raw']].values.max()*international_normal_weekly.loc[:, 'positive_rate'].max()
international_mitigate_weekly.loc[:, 'international'] = international_mitigate_weekly.loc[:, 'international_raw'] / \
    international_normal_weekly[international_normal_weekly['year'] <= 2019][[
        'international_raw']].values.max()*international_mitigate_weekly.loc[:, 'positive_rate'].max()

seasonstart = 50
seasonend = 13
indicator = pr_raw.loc[201101:202252, ['year', 'week']].copy()
indicator['indicator'] = 0
idx = indicator[(indicator['week'] >= seasonstart) |
                (indicator['week'] <= seasonend)].index
indicator.loc[idx, 'indicator'] = 1
# file output
# uk
out = pr_raw.loc[201101:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202030:, 't2'] = 1
out.loc[:, 'volume'] = domestic_mitigate_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_mitigate_weekly.loc[out.index,
                                                     'international'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'uk.csv', header=True, index=True)
# ukv2
out = pr_raw.loc[201101:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202030:, 't2'] = 1
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'ukv2.csv', header=True, index=True)
# uk3vni
out = pr_raw.loc[201101:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202030:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.3
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_domestic else 1)
out['indicator'] = 0
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'uk3vni.csv', header=True, index=True)
# ukmvni
out = pr_raw.loc[201101:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202030:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.5
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_domestic else 1)
out['indicator'] = 0
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'ukmvni.csv', header=True, index=True)
# uk7vni
out = pr_raw.loc[201101:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202030:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.7
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_domestic else 1)
out['indicator'] = 0
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'uk7vni.csv', header=True, index=True)
# uknv3i
out = pr_raw.loc[201101:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202030:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.3
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*(indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'uknv3i.csv', header=True, index=True)
# uknvmi
out = pr_raw.loc[201101:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202030:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.5
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*(indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'uknvmi.csv', header=True, index=True)
# uknv7i
out = pr_raw.loc[201101:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202030:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.7
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*(indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'uknv7i.csv', header=True, index=True)
# ukd1i2
out = pr_raw.loc[201101:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202030:, 't2'] = 1
out.loc[:, 'volume'] = domestic_mitigate_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'ukd1i2.csv', header=True, index=True)
# ukd2i1
out = pr_raw.loc[201101:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202030:, 't2'] = 1
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index, 'domestic'].values * \
    (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_mitigate_weekly.loc[out.index,
                                                     'international'].values*(indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'ukd2i1.csv', header=True, index=True)
# ukmvmi
out = pr_raw.loc[201101:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 1
out['t2'] = 0
out.loc[202030:, 't2'] = 1
idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
          & (out.index >= 202129)].index
out.loc[idx, 'indicator'] = 0.5
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                  'domestic'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_domestic else 1)
out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                   'international'].values*out.loc[:, 'indicator'].values * (indicator['indicator'].values if use_indicator_international else 1)
out.to_csv(outputbasefolder+'ukmvmi.csv', header=True, index=True)
# uklog
vaccinestart = 202050
vaccineend = 202128
out = pr_raw.loc[201101:202252, ['year', 'week', 'positive_rate']].copy()
out['tmprate'] = out['positive_rate']
for idx in out.loc[202004:202128, :].index:
    if out.loc[idx, 'positive_rate'] == 0:
        pre = find_rate(out, -1, idx)
        nex = find_rate(out, 1, idx)
        if nex == 0:
            out.loc[idx, 'tmprate'] = pre
        else:
            out.loc[idx, 'tmprate'] = (pre+nex)/2
out['positive_rate'] = out['tmprate']
out.drop('tmprate', inplace=True, axis=1)
out['t2'] = 0
out.loc[202030:, 't2'] = 1
vaccine_data = vaccinedf.loc[vaccinestart:vaccineend, 'uk'].values
vaccine_cpl = np.maximum(1-0.5*vaccine_data, 0.6)
out['cpl'] = 1
out.loc[vaccinestart:vaccineend, 'cpl'] = vaccine_cpl
out.loc[vaccineend:202139, 'cpl'] = out.loc[vaccineend, 'cpl']
out.loc[202140:, 'cpl'] = 0
out.to_csv(outputbasefolder+'uklog.csv', header=True, index=True)

# Hubei Province
# read raw data
region = 'hb'
pr_raw = pd.read_csv(basefolder+'rawdata/'+region+'.csv', header=0, index_col=0)
pr_raw['startdate'] = pd.to_datetime(pr_raw['startdate'])
pr_raw['enddate'] = pd.to_datetime(pr_raw['enddate'])
domestic_raw = pd.read_csv(basefolder+
    'rawdata/'+region+'domestic.csv', header=0, index_col=0)
domestic_raw.index = pd.to_datetime(domestic_raw.index)

# domestic
# calculate the montly average
average_d_mitigate = pd.DataFrame(index=[2019, 2020, 2021], columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
average_d_normal = pd.DataFrame(index=[2019, 2020, 2021], columns=[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])

for year in [2019, 2020, 2021]:
    for month in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]:
        if year == 2021 and month >= 7:
            break
        average_d_mitigate.loc[year, month] = domestic_raw[(domestic_raw.index.year == year) & (
            domestic_raw.index.month == month)][['volume']].mean().values

reg_coef = pd.DataFrame(index=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], columns=[
                        'intercept', 'coef'])

# calculate the daily average regression coef per month
for month in range(1, 7):
    xtrain = np.array([2019, 2021]).reshape(-1, 1)
    ytrain = average_d_mitigate.loc[[2019, 2021], month].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[month, 'intercept'] = model.intercept_
    reg_coef.loc[month, 'coef'] = model.coef_[0]

for month in range(7, 13):
    xtrain = np.array([2019, 2020]).reshape(-1, 1)
    ytrain = average_d_mitigate.loc[[2019, 2020], month].values
    model = LinearRegression()
    model.fit(xtrain, ytrain)
    reg_coef.loc[month, 'intercept'] = model.intercept_
    reg_coef.loc[month, 'coef'] = model.coef_[0]

average_d_normal.loc[:, :] = average_d_mitigate.values
for month in [1, 2, 3, 4]:
    average_d_normal.loc[2020, month] = get_prediction_from_reg(
        reg_coef, month, 2020)
for month in [7, 8, 9, 10, 11, 12]:
    average_d_normal.loc[2021, month] = get_prediction_from_reg(
        reg_coef, month, 2021)
for month in range(1, 13):
    average_d_normal.loc[2022, month] = get_prediction_from_reg(
        reg_coef, month, 2022)

domestic_normal = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])
domestic_mitigate = pd.DataFrame(index=pd.date_range(
    '2010-12-01', '2022-12-31'), columns=['volume', 'ma'])

# normal daily raw
domestic_normal.loc[pd.date_range('2019-01-01', '2021-07-15'),
                    'volume'] = domestic_raw.loc[pd.date_range('2019-01-01', '2021-07-15'), 'volume'].values
for date in pd.date_range('2020-01-01', '2020-04-30'):
    if date.month == 2 and date.day == 29:
        continue
    domestic_normal.loc[date, 'volume'] = domestic_normal.loc[date-pd.DateOffset(
        year=date.year-1), 'volume']+reg_coef.loc[date.month, 'coef']
for date in pd.date_range('2021-07-01', '2022-12-31'):
    if date.month == 2 and date.day == 29:
        continue
    domestic_normal.loc[date, 'volume'] = domestic_normal.loc[date-pd.DateOffset(
        year=date.year-1), 'volume']+reg_coef.loc[date.month, 'coef']
for date in reversed(pd.date_range('2010-12-01', '2018-12-31')):
    if date.month == 2 and date.day == 29:
        continue
    domestic_normal.loc[date, 'volume'] = domestic_normal.loc[date+pd.DateOffset(
        year=date.year+1), 'volume']
for date in domestic_normal.index:
    if date.month == 2 and date.day == 29:
        pos = domestic_normal.index.get_loc(date)
        domestic_normal.loc[date, 'volume'] = (
            domestic_normal.iloc[pos-1, 0]+domestic_normal.iloc[pos+1, 0])/2

# mitigate daily raw
domestic_mitigate.loc[pd.date_range('2019-01-01', '2021-07-15'),
                      'volume'] = domestic_raw.loc[pd.date_range('2019-01-01', '2021-07-15'), 'volume'].values
for date in pd.date_range('2021-07-16', '2022-12-31'):
    if date.month == 2 and date.day == 29:
        continue
    domestic_mitigate.loc[date, 'volume'] = domestic_mitigate.loc[date-pd.DateOffset(
        year=date.year-1), 'volume']+reg_coef.loc[date.month, 'coef']
for date in reversed(pd.date_range('2010-12-01', '2018-12-31')):
    if date.month == 2 and date.day == 29:
        continue
    domestic_mitigate.loc[date, 'volume'] = domestic_mitigate.loc[date+pd.DateOffset(
        year=date.year+1), 'volume']
for date in domestic_mitigate.index:
    if date.month == 2 and date.day == 29:
        pos = domestic_mitigate.index.get_loc(date)
        domestic_mitigate.loc[date, 'volume'] = (
            domestic_mitigate.iloc[pos-1, 0]+domestic_mitigate.iloc[pos+1, 0])/2

# moving average
ma = 30
for date in pd.date_range('2011-01-01', '2022-12-31'):
    startdate = date-pd.DateOffset(days=ma)
    domestic_normal.loc[date,
                        'ma'] = domestic_normal.loc[startdate:date, 'volume'].mean()
    domestic_mitigate.loc[date,
                          'ma'] = domestic_mitigate.loc[startdate:date, 'volume'].mean()

# weekly sum
domestic_normal_weekly = pr_raw.copy()
domestic_mitigate_weekly = pr_raw.copy()
for date in pr_raw.index:
    start = domestic_normal_weekly.loc[date, 'startdate']
    end = domestic_normal_weekly.loc[date, 'enddate']
    domestic_normal_weekly.loc[date,
                               'weeklyraw'] = domestic_normal.loc[start:end, 'ma'].sum()
    domestic_mitigate_weekly.loc[date,
                                 'weeklyraw'] = domestic_mitigate.loc[start:end, 'ma'].sum()
# normalized by first month
for date in pr_raw.index:
    if pr_raw.loc[date, 'year'] <= 2019:
        domestic_normal_weekly.loc[date,
                                   'domestic_raw'] = domestic_normal_weekly.loc[date, 'weeklyraw']
        domestic_mitigate_weekly.loc[date,
                                     'domestic_raw'] = domestic_mitigate_weekly.loc[date, 'weeklyraw']
    else:
        startdate = pr_raw.loc[date, 'startdate']
        domestic_normal_weekly.loc[date, 'domestic_raw'] = (domestic_normal_weekly.loc[date, 'weeklyraw']/domestic_normal_weekly[(
            domestic_normal_weekly['startdate'].dt.year == startdate.year) & (domestic_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()*domestic_normal_weekly[(
                domestic_normal_weekly['startdate'].dt.year == 2019) & (domestic_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()).values
        domestic_mitigate_weekly.loc[date, 'domestic_raw'] = (domestic_mitigate_weekly.loc[date, 'weeklyraw']/domestic_normal_weekly[(
            domestic_normal_weekly['startdate'].dt.year == startdate.year) & (domestic_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()*domestic_normal_weekly[(
                domestic_normal_weekly['startdate'].dt.year == 2019) & (domestic_normal_weekly['startdate'].dt.month == 1)][['weeklyraw']].mean()).values

# normalize to positive rate level
domestic_normal_weekly.loc[:, 'domestic'] = domestic_normal_weekly.loc[:, 'domestic_raw'] / \
    domestic_normal_weekly[domestic_normal_weekly['year'] <= 2019][[
        'domestic_raw']].values.max()*domestic_normal_weekly.loc[:, 'positive_rate'].max()
domestic_mitigate_weekly.loc[:, 'domestic'] = domestic_mitigate_weekly.loc[:, 'domestic_raw'] / \
    domestic_normal_weekly[domestic_normal_weekly['year'] <= 2019][[
        'domestic_raw']].values.max()*domestic_mitigate_weekly.loc[:, 'positive_rate'].max()

# international
# using the international mobility in Southern China
cs = pd.read_csv(basefolder+'output/csib3.csv', header=0, index_col=0)
csv2 = pd.read_csv(basefolder+'output/csiv2b3.csv', header=0, index_col=0)

# file output
# hb
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['t2'] = 0
out.loc[202004:, 't2'] = 1
out.loc[:, 'volume'] = domestic_mitigate_weekly.loc[out.index, 'domestic'].values
out.loc[:, 'vw'] = cs.loc[out.index, 'vw'].values
out.to_csv(outputbasefolder+'hb.csv', header=True, index=True)
# hbv2
out = pr_raw.loc[201114:202252, ['year', 'week', 'positive_rate']].copy()
out['indicator'] = 0
out['t2'] = 0
out.loc[202004:, 't2'] = 1
out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index, 'domestic'].values
out.loc[:, 'vw'] = csv2.loc[out.index, 'vw'].values
out.to_csv(outputbasefolder+'hbv2.csv', header=True, index=True)

print('done!')
