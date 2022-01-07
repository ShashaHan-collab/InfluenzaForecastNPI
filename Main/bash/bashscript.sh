# make coefficients for seasonal model and the estimated average flu level under mitigated travel volume
# northern china
# the estimated average flu level under mitigated travel volume
python script/imputation_reglike.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05
# coefficients for seasonal model
python script/moveandrename.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cncoef --targetfolder result --sourcetype coef
python script/moveandrename.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatym --targetfolder data --movetype mean
python script/moveandrename.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatym --targetfolder result --movetype mean
# southern china
python script/imputation_reglike.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05
python script/moveandrename.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cscoef --targetfolder result --sourcetype coef
python script/moveandrename.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatym --targetfolder data --movetype mean
python script/moveandrename.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatym --targetfolder result --movetype mean
# uk
python script/imputation_reglike.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05
python script/moveandrename.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname ukcoef --targetfolder result --sourcetype coef
python script/moveandrename.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatym --targetfolder data --movetype mean
python script/moveandrename.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatym --targetfolder result --movetype mean
# usa
python script/imputation_reglike.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05
python script/moveandrename.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usacoef --targetfolder result --sourcetype coef
python script/moveandrename.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatym --targetfolder data --movetype mean
python script/moveandrename.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatym --targetfolder result --movetype mean
# make the estimated flu level under normal travel volume for 5000 scenarios
# northern china
python script/imputation_reglike.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cncoef
python script/moveandrename.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatyv2 --targetfolder data
python script/moveandrename.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatyv2 --targetfolder result
# southern china
python script/imputation_reglike.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cscoef
python script/moveandrename.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatyv2 --targetfolder data
python script/moveandrename.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatyv2 --targetfolder result
# uk
python script/imputation_reglike.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef
python script/moveandrename.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatyv2 --targetfolder data
python script/moveandrename.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatyv2 --targetfolder result
# usa
python script/imputation_reglike.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef usacoef
python script/moveandrename.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatyv2 --targetfolder data
python script/moveandrename.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatyv2 --targetfolder result
# make the coefficients for the mask model, using the estimated flu level under the mitigate travel volume
# northern china
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 13 --yam cnihatym --model lr
python script/moveandrename.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 13 --yam cnihatym --model lr --targetname cncoefmask --targetfolder result --sourcetype coef
# southern china
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 11 --yam csihatym --model lr
python script/moveandrename.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 11 --yam csihatym --model lr --targetname cscoefmask --targetfolder result --sourcetype coef
# uk
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 24 --yam uk3hatym --model lr
python script/moveandrename.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 24 --yam uk3hatym --model lr --targetname ukcoefmask --targetfolder result --sourcetype coef
# usa
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 35 --yam usa3hatym --model lr
python script/moveandrename.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 35 --yam usa3hatym --model lr --targetname usacoefmask --targetfolder result --sourcetype coef
# make the estimated flu level under mitigate travel volume before 2021 week 40 and normal volume then
# northern china
python script/imputation_reglike.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05  --loadcoef cncoef --loadpositiverate cnihatym
python script/moveandrename.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatyfmsn --targetfolder data
python script/moveandrename.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatyfmsn --targetfolder result
# southern china
python script/imputation_reglike.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cscoef --loadpositiverate csihatym
python script/moveandrename.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatyfmsn --targetfolder data
python script/moveandrename.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatyfmsn --targetfolder result
# uk
python script/imputation_reglike.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef --loadpositiverate uk3hatym
python script/moveandrename.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatyfmsn --targetfolder data
python script/moveandrename.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatyfmsn --targetfolder result
# usa
python script/imputation_reglike.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef usacoef --loadpositiverate usa3hatym
python script/moveandrename.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatyfmsn --targetfolder data
python script/moveandrename.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatyfmsn --targetfolder result
# predict different scenarios with and without covid-19 and prepare source data for figure "Estimated influenza activities under the scenarios with no SARS-COV-2 transmission and with SARS-COV-2 transmission, both without COVID-19 NPIs"
# dos2unix bash/covid19.sh
bash bash/covid19.sh
# predict different scenarios with and without covid-19 in Hubei and prepare source data for figure "Estimated influenza activities under the scenarios with no SARS-COV-2 transmission and with SARS-COV-2 transmission, both without COVID-19 NPIs in Hubei Province, China."
# dos2unix bash/hbcovid19.sh
bash bash/hbcovid19.sh
# predict and prepare source data for figure "Estimated influenza activities under the mask-wearing order alone and no intervention as well as the observed activity" and "Estimated influenza activities under the mobility change alone and no intervention as well as the observed activity."
# dos2unix bash/colleterial.sh
bash bash/colleterial.sh
# predict the no-npi data in the futrue and prepare source data for figure "Predicted influenza activities in 2021–2022 season under no NPI and varying NPIs.", "Predicted influenza activities in 2021–2022 season under NPIs with alternative assumptions" and "Predicted influenza activities in 2021–2022 season under alternative mask-wearing interventions and combined NPIs"
# dos2unix bash/compare.sh
bash bash/compare.sh
# predict the flu level under mask wearing order and prepare source data for figure "Predicted influenza activities in 2021–2022 season under no NPI and varying NPIs" and "Predicted influenza activities in 2021–2022 season under NPIs with alternative assumptions"
# dos2unix bash/futuremask.sh
bash bash/futuremask.sh
# predict the flu level for different international travel volume and prepare source data for figure "Predicted influenza activities in 2021–2022 season under NPIs with alternative assumptions"
# dos2unix bash/futureinternational.sh
bash bash/futureinternational.sh
# predict the flu level for different domestic travel volume and prepare source data for figure "Predicted influenza activities in 2021–2022 season under NPIs with alternative assumptions"
# dos2unix bash/futuredomestic.sh
bash bash/futuredomestic.sh
# predict the flu level under different effectiveness of mask wearing and prepare source data for figure "Predicted influenza activities in 2021–2022 season under alternative mask-wearing interventions and combined NPIs"
# dos2unix bash/futuremask_fullwithoutsumD.sh
bash bash/futuremask_fullwithoutsumD.sh
# predict the flu level under vaccination and prepare source data for figure "Predicted influenza activities in 2021–2022 season under alternative mask-wearing interventions and combined NPIs"
# dos2unix bash/futuremask_vaccine.sh
bash bash/futuremask_vaccine.sh
# predict the flu level under mask wearing order with mask model effective for the whole time and prepare source data for figure "Predicted influenza activities in 2021–2022 season under alternative mask-wearing interventions and combined NPIs"
# dos2unix bash/futuremask_withsumD.sh
bash bash/futuremask_withsumD.sh
# predict the flu level under international/domestic travel volume change alone and prepare source data for figure "Estimated influenza activities under the international mobility change alone, the domestic mobility change alone and no intervention as well as the observed activity"
# dos2unix bash/testformobilityintdom.sh
bash bash/testformobilityintdom.sh
# predict the effect of different combinations of npis in the future and prepare source data for figure "Predicted influenza activities in 2021–2022 season under alternative mask-wearing interventions and combined NPIs"
# dos2unix bash/futurepolicy.sh
bash bash/futurepolicy.sh
# calculate the data for the fitness of our model and prepare source data for figure "Influenza activity in 2011-2021"
# dos2unix bash/fit.sh
bash bash/fit.sh
# estimate the value of tau in mask model
# dos2unix bash/maketau.sh
bash bash/maketau.sh
# calculate the estimated confidence intervals under different scenarios
python script/calculateCI_v3.py
# validation and prepare source data for figure "Fitted influenza activity that is obtained from using the 2011-2016 data for training and the 2017 data for test, in comparison to observed influenza activity", "Fitted influenza activity that is obtained from using the 2011-2017 data for training and the 2018 data for test, in comparison to observed influenza activity" and "Fitted influenza activity that is obtained from using the 2011-2018 data for training and the 2019 data for test, in comparison to observed influenza activity"
bash bash/validation.sh
bash bash/validation17.sh
bash bash/validation18.sh