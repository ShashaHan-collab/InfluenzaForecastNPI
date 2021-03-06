# estimate model parameters and predict flu activity
# northern China
# predict flu activity under observed mobility 
python script/estimation_forecast.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05

# estimate model parameters
python script/auxiliary_name_file.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cncoef --targetfolder result --sourcetype coef
python script/auxiliary_name_file.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatym --targetfolder preprocessed_data --movetype mean
python script/auxiliary_name_file.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatym --targetfolder result --movetype mean

# southern China
python script/estimation_forecast.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05
python script/auxiliary_name_file.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cscoef --targetfolder result --sourcetype coef
python script/auxiliary_name_file.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatym --targetfolder preprocessed_data --movetype mean
python script/auxiliary_name_file.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatym --targetfolder result --movetype mean

# England
python script/estimation_forecast.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05
python script/auxiliary_name_file.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname ukcoef --targetfolder result --sourcetype coef
python script/auxiliary_name_file.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatym --targetfolder preprocessed_data --movetype mean
python script/auxiliary_name_file.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatym --targetfolder result --movetype mean

# USA
python script/estimation_forecast.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usacoef --targetfolder result --sourcetype coef
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatym --targetfolder preprocessed_data --movetype mean
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatym --targetfolder result --movetype mean

# bootstrap for 5000 times for estimating confidence intervals

# northern China
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cncoef
python script/auxiliary_name_file.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatyv2 --targetfolder preprocessed_data
python script/auxiliary_name_file.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatyv2 --targetfolder result

# southern China
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cscoef
python script/auxiliary_name_file.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatyv2 --targetfolder preprocessed_data
python script/auxiliary_name_file.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatyv2 --targetfolder result

# England
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef
python script/auxiliary_name_file.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatyv2 --targetfolder preprocessed_data
python script/auxiliary_name_file.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatyv2 --targetfolder result

# USA
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef usacoef
python script/auxiliary_name_file.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatyv2 --targetfolder preprocessed_data
python script/auxiliary_name_file.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatyv2 --targetfolder result

# estimate parameters for mask model
# northern China
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 13 --yam cnihatym --model lr
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 13 --yam cnihatym --model lr --targetname cncoefmask --targetfolder result --sourcetype coef

# southern China
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 11 --yam csihatym --model lr
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 11 --yam csihatym --model lr --targetname cscoefmask --targetfolder result --sourcetype coef

# England
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 24 --yam uk3hatym --model lr
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 24 --yam uk3hatym --model lr --targetname ukcoefmask --targetfolder result --sourcetype coef

# USA
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 35 --yam usa3hatym --model lr
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 35 --yam usa3hatym --model lr --targetname usacoefmask --targetfolder result --sourcetype coef

# make the estimated flu level under mitigate travel volume before 2021 week 40 and normal volume then
# northern China
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05  --loadcoef cncoef --loadpositiverate cnihatym
python script/auxiliary_name_file.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatyfmsn --targetfolder preprocessed_data
python script/auxiliary_name_file.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatyfmsn --targetfolder result

# southern China
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cscoef --loadpositiverate csihatym
python script/auxiliary_name_file.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatyfmsn --targetfolder preprocessed_data
python script/auxiliary_name_file.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatyfmsn --targetfolder result

# England
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef --loadpositiverate uk3hatym
python script/auxiliary_name_file.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatyfmsn --targetfolder preprocessed_data
python script/auxiliary_name_file.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatyfmsn --targetfolder result

# USA
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef usacoef --loadpositiverate usa3hatym
python script/auxiliary_name_file.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatyfmsn --targetfolder preprocessed_data
python script/auxiliary_name_file.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatyfmsn --targetfolder result

# predict flu activity in scenarios with and without covid-19, and prepare source data for Figure "Estimated influenza activities under the scenarios with no SARS-COV-2 transmission and with SARS-COV-2 transmission, both without COVID-19 NPIs"
# dos2unix example_estimation/Run/covid19.sh
bash example_estimation/Run/covid19.sh

# predict flu activity in scenarios with and without covid-19 in Hubei Province, and prepare source data for Figure "Estimated influenza activities under the scenarios with no SARS-COV-2 transmission and with SARS-COV-2 transmission, both without COVID-19 NPIs in Hubei Province, China."
# dos2unix example_estimation/Run/hbcovid19.sh
bash example_estimation/Run/hbcovid19.sh

# predict flu activity, and prepare source data for Figure "Estimated influenza activities under the mask-wearing order alone and no intervention as well as the observed activity" and "Estimated influenza activities under the mobility change alone and no intervention as well as the observed activity."
# dos2unix example_estimation/Run/colleterial.sh
bash example_estimation/Run/colleterial.sh

# predict flu activity under international/domestic mobility change alone, and prepare source data for Figure "Estimated influenza activities under the international mobility change alone, the domestic mobility change alone and no intervention as well as the observed activity"
# dos2unix example_estimation/Run/testformobilityintdom.sh
bash example_estimation/Run/testformobilityintdom.sh

# calculate the data for the fitness of our model and prepare source data for figure "Influenza activity in 2011-2021"
# dos2unix example_estimation/Run/fit.sh
bash example_estimation/Run/fit.sh

# estimate the value of tau in mask model
# dos2unix example_estimation/Run/maketau.sh
bash example_estimation/Run/maketau.sh

# calculate the 95% confidence intervals under different scenarios
python script/calculate_report_statistics.py

# do model validation and prepare source data for Figure "Fitted influenza activity that is obtained from using the 2011-2016 data for training and the 2017 data for test, in comparison to observed influenza activity", "Fitted influenza activity that is obtained from using the 2011-2017 data for training and the 2018 data for test, in comparison to observed influenza activity" and "Fitted influenza activity that is obtained from using the 2011-2018 data for training and the 2019 data for test, in comparison to observed influenza activity"
# dos2unix example_estimation/Run/validation.sh
bash example_estimation/Run/validation.sh
# dos2unix example_estimation/Run/validation17.sh
bash example_estimation/Run/validation17.sh
# dos2unix example_estimation/Run/validation18.sh
bash example_estimation/Run/validation18.sh
