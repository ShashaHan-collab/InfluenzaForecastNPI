# forecast flu activity in the 2021-2022 influenza season
# northern China

# estimate flu activity under observed mobility
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

# estimate parameters of mask model
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

# predict influenza activity in scenarios without NPIs and prepare source data for Figure "Predicted influenza activities in 2021–2022 season under no NPI and varying NPIs.", "Predicted influenza activities in 2021–2022 season under NPIs with alternative assumptions" and "Predicted influenza activities in 2021–2022 season under alternative mask-wearing interventions and combined NPIs"
# dos2unix example_forecast/Run/compare.sh
bash example_forecast/Run/compare.sh

# predict influenza activity in scenarios with mask-wearing interventions alone, and prepare source data for Figure "Predicted influenza activities in 2021–2022 season under no NPI and varying NPIs" and "Predicted influenza activities in 2021–2022 season under NPIs with alternative assumptions"
# dos2unix example_forecast/Run/futuremask.sh
bash example_forecast/Run/futuremask.sh

# predict influenza activity in scenarios with different international mobility mitigation measures, and prepare source data for Figure "Predicted influenza activities in 2021–2022 season under NPIs with alternative assumptions"
# dos2unix example_forecast/Run/futureinternational.sh
bash example_forecast/Run/futureinternational.sh

# predict influenza activity in scenarios with different domestic mobility mitigation measures, and prepare source data for figure "Predicted influenza activities in 2021–2022 season under NPIs with alternative assumptions"
# dos2unix example_forecast/Run/futuredomestic.sh
bash example_forecast/Run/futuredomestic.sh

# predict influenza activity in scenarios with different magnitudies of mask-wearing interventions, and prepare source data for figure "Predicted influenza activities in 2021–2022 season under alternative mask-wearing interventions and combined NPIs"
# dos2unix example_forecast/Run/futuremask_fullwithoutsumD.sh
bash example_forecast/Run/futuremask_fullwithoutsumD.sh

# predict influenza activity in scenarios with influenza vaccination, and prepare source data for figure "Predicted influenza activities in 2021–2022 season under alternative mask-wearing interventions and combined NPIs"
# dos2unix example_forecast/Run/futuremask_vaccine.sh
bash example_forecast/Run/futuremask_vaccine.sh

# predict influenza activity in scenarios with different timing of mask-wearing interventions, and prepare source data for figure "Predicted influenza activities in 2021–2022 season under alternative mask-wearing interventions and combined NPIs"
# dos2unix example_forecast/Run/futuremask_withsumD.sh
bash example_forecast/Run/futuremask_withsumD.sh

