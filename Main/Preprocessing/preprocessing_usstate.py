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
vaccinedf = pd.read_csv(
    basefolder+'rawdata/vaccine.csv', index_col=0, header=0)
for state in ['CO', 'IN', 'MN', 'WA']:
    # read raw data
    region = 'usa'
    pr_raw = pd.read_csv(basefolder+'rawdata/'+region +
                         '.csv', header=0, index_col=0)
    pr_raw['startdate'] = pd.to_datetime(pr_raw['startdate'])
    pr_raw['enddate'] = pd.to_datetime(pr_raw['enddate'])
    domestic_raw = pd.read_csv(basefolder +
                               'rawdata/'+region+'domestic.csv', header=0, index_col=0)
    international_raw = pd.read_csv(basefolder +
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

    google = pd.read_csv(
        basefolder+'rawdata/Mobility_Report.csv', header=0, index_col=0)
    google['date'] = pd.to_datetime(google['date'])
    base = pd.DataFrame(index=range(0, 7), columns=['basevalue'])
    mediandf = domestic_mitigate[(domestic_mitigate.index >= pd.to_datetime(
        '2020/01/03')) & (domestic_mitigate.index <= pd.to_datetime('2020/02/06'))]
    for i in base.index:
        base.loc[i, 'basevalue'] = np.median(
            mediandf[mediandf.index.weekday == i][['volume']].values)
    for i in pd.date_range('2020/02/15', '2021/09/21'):
        domestic_mitigate.loc[i, 'volume'] = base.loc[i.weekday(), 'basevalue']*(1+google[(google['iso_3166_2_code'] == (
            'US-'+state)) & (google['date'] == i)][['transit_stations_percent_change_from_baseline']].values.reshape(-1)/100)

    # moving average
    ma = 14
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
                                   'weeklyraw'] = np.array(domestic_normal.loc[start:end, 'ma'].sum()).reshape(-1)
        domestic_mitigate_weekly.loc[date,
                                     'weeklyraw'] = np.array(domestic_mitigate.loc[start:end, 'ma'].sum()).reshape(-1)

    # normalized by first month
    normcoef = pd.DataFrame(index=range(2011, 2023),
                            columns=['coef'])
    for year in range(2011, 2023):
        normcoef.loc[year, 'coef'] = domestic_normal_weekly[(
            domestic_normal_weekly['startdate'].dt.month == 1) & (domestic_normal_weekly['startdate'].dt.year == year)][['weeklyraw']].mean().values

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
    ma = 14
    for date in pd.date_range('2011-01-01', '2022-12-31'):
        startdate = date-pd.DateOffset(days=ma)
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

    # fill state level positive rate
    staterate = pd.read_csv(
        basefolder+'rawdata/'+state+'.csv', header=0, index_col=0)
    pr_raw.loc[201140:202252,
               'positive_rate'] = staterate.loc[201140:202252, 'positive_rate']
    if state == 'CO':
        t2start = 202029
        t2end = 202119
        delta = 0
        mu = 0.05
    elif state=='IN':
        t2start = 202031
        t2end = 202114
        delta = 0.4
        mu = 0.1
    elif state=='MN':
        t2start = 202030
        t2end = 202119
        delta = 0.2
        mu = 0.5
    elif state=='WA':
        t2start = 202024
        t2end = 202139
        delta = 0
        mu = 0.01  
    
    # delete 0 during mask time
    pr_raw['tmprate'] = pr_raw['positive_rate']
    for idx in pr_raw.loc[t2start:202128, :].index:
        if pr_raw.loc[idx, 'positive_rate'] == 0:
            pre = find_rate(pr_raw, -1, idx)
            nex = find_rate(pr_raw, 1, idx)
            if nex == 0:
                pr_raw.loc[idx, 'tmprate'] = pre
            else:
                pr_raw.loc[idx, 'tmprate'] = (pre+nex)/2
    pr_raw['positive_rate'] = pr_raw['tmprate']

    
    seasonstart = 48
    seasonend = 15
    # file output
    # usa
    out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
    out['indicator'] = 0
    out['t2'] = 0
    out.loc[t2start:t2end, 't2'] = 1
    out.loc[202140:, 't2'] = 1
    idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
    out.loc[idx, 'indicator'] = 1
    out.loc[:, 'volume'] = domestic_mitigate_weekly.loc[out.index, 'domestic'].values
    out.loc[:, 'vw'] = international_mitigate_weekly.loc[out.index,
                                                         'international'].values*out.loc[:, 'indicator'].values
    vaccinestart = 202052
    vaccineend = 202128
    vaccine_data = vaccinedf.loc[vaccinestart:vaccineend, 'usa'].values
    vaccine_cpl = np.maximum(1-mu*vaccine_data, delta)
    out['cpl'] = 1
    out.loc[vaccinestart:vaccineend, 'cpl'] = vaccine_cpl
    out.loc[vaccineend:202139, 'cpl'] = out.loc[vaccineend, 'cpl']
    out.loc[202140:, 'cpl'] = 0
    out.to_csv(basefolder+'output/'+state+'/usa.csv', header=True, index=True)
    # usav2
    out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
    out['indicator'] = 0
    out['t2'] = 0
    out.loc[202014:, 't2'] = 1
    idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
    out.loc[idx, 'indicator'] = 1
    out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index, 'domestic'].values
    out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                       'international'].values*out.loc[:, 'indicator'].values
    out.to_csv(basefolder+'output/'+state +
               '/usav2.csv', header=True, index=True)

    # usa3vni
    out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
    out['indicator'] = 1
    out['t2'] = 0
    out.loc[202014:, 't2'] = 1
    idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
              & (out.index >= 202129)].index
    out.loc[idx, 'indicator'] = 0.3
    out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                      'domestic'].values*out.loc[:, 'indicator'].values
    out['indicator'] = 0
    idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
    out.loc[idx, 'indicator'] = 1
    out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                       'international'].values*out.loc[:, 'indicator'].values
    out.to_csv(basefolder+'output/'+state +
               '/usa3vni.csv', header=True, index=True)
    # usamvni
    out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
    out['indicator'] = 1
    out['t2'] = 0
    out.loc[202014:, 't2'] = 1
    idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
              & (out.index >= 202129)].index
    out.loc[idx, 'indicator'] = 0.5
    out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                      'domestic'].values*out.loc[:, 'indicator'].values
    out['indicator'] = 0
    idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
    out.loc[idx, 'indicator'] = 1
    out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                       'international'].values*out.loc[:, 'indicator'].values
    out.to_csv(basefolder+'output/'+state +
               '/usamvni.csv', header=True, index=True)
    # usa7vni
    out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
    out['indicator'] = 1
    out['t2'] = 0
    out.loc[202014:, 't2'] = 1
    idx = out[((out['week'] >= seasonstart) | (out['week'] <= seasonend))
              & (out.index >= 202129)].index
    out.loc[idx, 'indicator'] = 0.7
    out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                      'domestic'].values*out.loc[:, 'indicator'].values
    out['indicator'] = 0
    idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
    out.loc[idx, 'indicator'] = 1
    out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                       'international'].values*out.loc[:, 'indicator'].values
    out.to_csv(basefolder+'output/'+state +
               '/usa7vni.csv', header=True, index=True)
    # usanv3i
    out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
    out['indicator'] = 0
    out['t2'] = 0
    out.loc[202014:, 't2'] = 1
    idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
    out.loc[idx, 'indicator'] = 1
    out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                      'domestic'].values
    out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                       'international'].values*out.loc[:, 'indicator'].values
    out.loc[202129:, 'vw'] = out.loc[202129:, 'vw']*0.3
    out.to_csv(basefolder+'output/'+state +
               '/usanv3i.csv', header=True, index=True)
    # usanvmi
    out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
    out['indicator'] = 0
    out['t2'] = 0
    out.loc[202014:, 't2'] = 1
    idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
    out.loc[idx, 'indicator'] = 1
    out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                      'domestic'].values
    out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                       'international'].values*out.loc[:, 'indicator'].values
    out.loc[202129:, 'vw'] = out.loc[202129:, 'vw']*0.5
    out.to_csv(basefolder+'output/'+state +
               '/usanvmi.csv', header=True, index=True)
    # usanv7i
    out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
    out['indicator'] = 0
    out['t2'] = 0
    out.loc[202014:, 't2'] = 1
    idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
    out.loc[idx, 'indicator'] = 1
    out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index,
                                                      'domestic'].values
    out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                       'international'].values*out.loc[:, 'indicator'].values
    out.loc[202129:, 'vw'] = out.loc[202129:, 'vw']*0.7
    out.to_csv(basefolder+'output/'+state +
               '/usanv7i.csv', header=True, index=True)
    # usad1i2
    out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
    out['indicator'] = 0
    out['t2'] = 0
    out.loc[202014:, 't2'] = 1
    idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
    out.loc[idx, 'indicator'] = 1
    out.loc[:, 'volume'] = domestic_mitigate_weekly.loc[out.index, 'domestic'].values
    out.loc[:, 'vw'] = international_normal_weekly.loc[out.index,
                                                       'international'].values*out.loc[:, 'indicator'].values
    out.to_csv(basefolder+'output/'+state +
               '/usad1i2.csv', header=True, index=True)
    # usad2i1
    out = pr_raw.loc[201140:202252, ['year', 'week', 'positive_rate']].copy()
    out['indicator'] = 0
    out['t2'] = 0
    out.loc[202014:, 't2'] = 1
    idx = out[(out['week'] >= seasonstart) | (out['week'] <= seasonend)].index
    out.loc[idx, 'indicator'] = 1
    out.loc[:, 'volume'] = domestic_normal_weekly.loc[out.index, 'domestic'].values
    out.loc[:, 'vw'] = international_mitigate_weekly.loc[out.index,
                                                         'international'].values*out.loc[:, 'indicator'].values
    out.to_csv(basefolder+'output/'+state +
               '/usad2i1.csv', header=True, index=True)
