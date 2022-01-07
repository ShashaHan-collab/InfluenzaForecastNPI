# mask plot
# northern china
# make data
# mask wearing order for the full season
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a1 --noint --cpltp 202149 --cpled 202205 --loadcoef cncoefmask
python script/calavgpercent.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a1 --noint --cpltp 202149 --cpled 202205 --targetname cnmask45-50_d
python script/gen_data_plot.py --sourcecsv cnmask45-50_d --targetexcel data/future/cn --targetsheetname mask45-50_d
# mask wearing order for the first half season
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a1 --noint --cpltp 202206 --cpled 202214 --loadcoef cncoefmask
python script/calavgpercent.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a1 --noint --cpltp 202206 --cpled 202214 --targetname cnmask51-4_d
python script/gen_data_plot.py --sourcecsv cnmask51-4_d --targetexcel data/future/cn --targetsheetname mask51-4_d
# mask wearing order for the second half season
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a1 --noint --cpltp 202149 --cpled 202214 --loadcoef cncoefmask
python script/calavgpercent.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a1 --noint --cpltp 202149 --cpled 202214 --targetname cnmask_d
python script/gen_data_plot.py --sourcecsv cnmask_d --targetexcel data/future/cn --targetsheetname mask_d
# southern china
# make data
# mask wearing order for the full season
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a1 --noint --cpltp 202145 --cpled 202204 --loadcoef cscoefmask
python script/calavgpercent.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a1 --noint --cpltp 202145 --cpled 202204 --targetname csmask45-50_d
python script/gen_data_plot.py --sourcecsv csmask45-50_d --targetexcel data/future/cs --targetsheetname mask45-50_d
# mask wearing order for the first half season
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a1 --noint --cpltp 202204 --cpled 202215 --loadcoef cscoefmask
python script/calavgpercent.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a1 --noint --cpltp 202204 --cpled 202215 --targetname csmask51-4_d
python script/gen_data_plot.py --sourcecsv csmask51-4_d --targetexcel data/future/cs --targetsheetname mask51-4_d
# mask wearing order for the second half season
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a1 --noint --cpltp 202145 --cpled 202215 --loadcoef cscoefmask
python script/calavgpercent.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a1 --noint --cpltp 202145 --cpled 202215 --targetname csmask_d
python script/gen_data_plot.py --sourcecsv csmask_d --targetexcel data/future/cs --targetsheetname mask_d
# uk
# data
# mask wearing order for the full season
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a1 --noint --cpltp 202150 --cpled 202205 --loadcoef ukcoefmask
python script/calavgpercent.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a1 --noint --cpltp 202150 --cpled 202205 --targetname ukmask45-50_d
python script/gen_data_plot.py --sourcecsv ukmask45-50_d --targetexcel data/future/uk --targetsheetname mask45-50_d
# mask wearing order for the first half season
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a1 --noint --cpltp 202206 --cpled 202213 --loadcoef ukcoefmask
python script/calavgpercent.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a1 --noint --cpltp 202206 --cpled 202213 --targetname ukmask51-4_d
python script/gen_data_plot.py --sourcecsv ukmask51-4_d --targetexcel data/future/uk --targetsheetname mask51-4_d
# mask wearing order for the second half season
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a1 --noint --cpltp 202150 --cpled 202213 --loadcoef ukcoefmask
python script/calavgpercent.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a1 --noint --cpltp 202150 --cpled 202213 --targetname ukmask_d
python script/gen_data_plot.py --sourcecsv ukmask_d --targetexcel data/future/uk --targetsheetname mask_d
# usa
# make data
# mask wearing order for the full season
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a1 --noint --cpltp 202148 --cpled 202205 --loadcoef usacoefmask
python script/calavgpercent.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a1 --noint --cpltp 202148 --cpled 202205 --targetname usamask45-50_d
python script/gen_data_plot.py --sourcecsv usamask45-50_d --targetexcel data/future/usa --targetsheetname mask45-50_d
# mask wearing order for the first half season
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a1 --noint --cpltp 202206 --cpled 202215 --loadcoef usacoefmask
python script/calavgpercent.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a1 --noint --cpltp 202206 --cpled 202215 --targetname usamask51-4_d
python script/gen_data_plot.py --sourcecsv usamask51-4_d --targetexcel data/future/usa --targetsheetname mask51-4_d
# mask wearing order for the second half season
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a1 --noint --cpltp 202148 --cpled 202215 --loadcoef usacoefmask
python script/calavgpercent.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a1 --noint --cpltp 202148 --cpled 202215 --targetname usamask_d
python script/gen_data_plot.py --sourcecsv usamask_d --targetexcel data/future/usa --targetsheetname mask_d