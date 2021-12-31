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
# predict different scenarios with and without covid-19
# dos2unix bash/plot4regioncovid19.sh
bash bash/plot4regioncovid19.sh
# predict different scenarios with and without covid-19 in Hubei
# dos2unix bash/plothbcovid19.sh
bash bash/plothbcovid19.sh
# predict data for fig 1 and 2
# dos2unix bash/plot4regioncolleterial.sh
bash bash/plot4regioncolleterial.sh
# predict the no-npi data in fig 4
# dos2unix bash/plot4regioncompare.sh
bash bash/plot4regioncompare.sh
# predict the flu level under mask wearing order in fig 4 and 5
# dos2unix bash/plot4regionfuturemask.sh
bash bash/plot4regionfuturemask.sh
# predict the flu level for different international travel volume in fig 4 and 5
# dos2unix bash/plot4regionfutureinternational.sh
bash bash/plot4regionfutureinternational.sh
# predict the flu level for different domestic travel volume in fig 4 and 5
# dos2unix bash/plot4regionfuturedomestic.sh
bash bash/plot4regionfuturedomestic.sh
# predict the flu level under different effectiveness of mask wearing in Extended Data Fig. 3
# dos2unix bash/plot4regionfuturemask_fullwithoutsumD.sh
bash bash/plot4regionfuturemask_fullwithoutsumD.sh
# predict the flu level under vaccination in Extended Data Fig. 3
# dos2unix bash/plot4regionfuturemask_vaccine.sh
bash bash/plot4regionfuturemask_vaccine.sh
# predict the flu level under mask wearing order with mask model effective for the whole time in Extended Data Fig. 3
# dos2unix bash/plot4regionfuturemask_withsumD.sh
bash bash/plot4regionfuturemask_withsumD.sh
# predict the flu level under international/domestic travel volume change alone in Extended Data Fig. 2
# dos2unix bash/testformobilityintdom.sh
bash bash/testformobilityintdom.sh
# predict the effect of different combinations of npis in the future
# dos2unix bash/plotfuturepolicy.sh
bash bash/plotfuturepolicy.sh
# calculate the data for the fitness of our model
# dos2unix bash/plotfit.sh
bash bash/plotfit.sh
# estimate the value of tau in mask model
# dos2unix bash/maketau.sh
bash bash/maketau.sh
# calculate the estimated confidence intervals under different scenarios
python script/calculateCI_v3.py
# validation
bash bash/validation.sh
bash bash/validation17.sh
bash bash/validation18.sh