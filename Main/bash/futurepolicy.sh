# mask + 50% international
# northern china
# make data
# mask wearing order for the full season
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatynvmi --model lr --cpl a1 --noint --cpltp 202149 --cpled 202214 --loadcoef cncoefmask
python script/name_data.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatynvmi --model lr --cpl a1 --noint --cpltp 202149 --cpled 202214 --targetname cnmask50ifirststage --targetfolder result
python script/imputation_reglike.py --lag 52 --region cninvmi --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate cnmask50ifirststage  --loadcoef cncoef
python script/calavgpercent.py --lag 52 --region cninvmi --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnmask50i
python script/gen_data_plot.py --sourcecsv cnmask50i --targetexcel data/combinenpi/cn --targetsheetname mask50i
# mask + 50% international
# northern china
# make data
# mask wearing order for the full season
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatymvni --model lr --cpl a1 --noint --cpltp 202149 --cpled 202214 --loadcoef cncoefmask
python script/name_data.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatymvni --model lr --cpl a1 --noint --cpltp 202149 --cpled 202214 --targetname cnmask50vfirststage --targetfolder result
python script/imputation_reglike.py --lag 52 --region cnimvni --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate cnmask50vfirststage  --loadcoef cncoef
python script/calavgpercent.py --lag 52 --region cnimvni --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnmask50v
python script/gen_data_plot.py --sourcecsv cnmask50v --targetexcel data/combinenpi/cn --targetsheetname mask50v
# northern china
# prepare rawdata under different volume
python script/imputation_reglike.py --lag 52 --region cnimvmi --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05  --loadcoef cncoef --loadpositiverate cnihatym
python script/name_data.py --lag 52 --region cnimvmi --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatymvmi
# mitigate domestic mitigate international flu level with the effect of previous mask wearing
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatymvmi --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cncoefmask
python script/calavgpercent.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatymvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname cnmvmi
python script/gen_data_plot.py --sourcecsv cnmvmi --targetexcel data/combinenpi/cn --targetsheetname mvmi
# southern china
# make data
# mask wearing order for the full season
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatynvmi --model lr --cpl a1 --noint --cpltp 202145 --cpled 202215 --loadcoef cscoefmask
python script/name_data.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatynvmi --model lr --cpl a1 --noint --cpltp 202145 --cpled 202215 --targetname csmask50ifirststage --targetfolder result
python script/imputation_reglike.py --lag 52 --region csib3nvmi --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate csmask50ifirststage --loadcoef cscoef
python script/calavgpercent.py --lag 52 --region csib3nvmi --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csmask50i
python script/gen_data_plot.py --sourcecsv csmask50i --targetexcel data/combinenpi/cs --targetsheetname mask50i
# southern china
# make data
# mask wearing order for the full season
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatymvni --model lr --cpl a1 --noint --cpltp 202145 --cpled 202215 --loadcoef cscoefmask
python script/name_data.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatymvni --model lr --cpl a1 --noint --cpltp 202145 --cpled 202215 --targetname csmask50vfirststage --targetfolder result
python script/imputation_reglike.py --lag 52 --region csib3mvni --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate csmask50vfirststage --loadcoef cscoef
python script/calavgpercent.py --lag 52 --region csib3mvni --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csmask50v
python script/gen_data_plot.py --sourcecsv csmask50v --targetexcel data/combinenpi/cs --targetsheetname mask50v
# southern china
# prepare data
python script/imputation_reglike.py --lag 52 --region csimvmi --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cscoef --loadpositiverate csihatym
python script/name_data.py --lag 52 --region csimvmi --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatymvmi
# mitigate domestic mitigate international
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatymvmi --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cscoefmask
python script/calavgpercent.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatymvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname csmvmi
python script/gen_data_plot.py --sourcecsv csmvmi --targetexcel data/combinenpi/cs --targetsheetname mvmi
# uk
# data
# mask wearing order for the full season
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatynvmi --model lr --cpl a1 --noint --cpltp 202150 --cpled 202213 --loadcoef ukcoefmask
python script/name_data.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatynvmi --model lr --cpl a1 --noint --cpltp 202150 --cpled 202213 --targetname ukmask50ifirststage --targetfolder result
python script/imputation_reglike.py --lag 52 --region uknvmi --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05  --loadpositiverate ukmask50ifirststage --loadcoef ukcoef
python script/calavgpercent.py --lag 52 --region uknvmi --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname ukmask50i
python script/gen_data_plot.py --sourcecsv ukmask50i --targetexcel data/combinenpi/uk --targetsheetname mask50i
# uk
# data
# mask wearing order for the full season
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatymvni --model lr --cpl a1 --noint --cpltp 202150 --cpled 202213 --loadcoef ukcoefmask
python script/name_data.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatymvni --model lr --cpl a1 --noint --cpltp 202150 --cpled 202213 --targetname ukmask50vfirststage --targetfolder result
python script/imputation_reglike.py --lag 52 --region ukmvni --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05  --loadpositiverate ukmask50vfirststage --loadcoef ukcoef
python script/calavgpercent.py --lag 52 --region ukmvni --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname ukmask50v
python script/gen_data_plot.py --sourcecsv ukmask50v --targetexcel data/combinenpi/uk --targetsheetname mask50v
# uk
# prepare data
python script/imputation_reglike.py --lag 52 --region ukmvmi --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef --loadpositiverate uk3hatym
python script/name_data.py --lag 52 --region ukmvmi --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatymvmi
# mitigate domestic mitigate international
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatymvmi --model lr --cpl a0 --noint --cpltp 202140 --loadcoef ukcoefmask
python script/calavgpercent.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatymvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname rukmvmi
python script/gen_data_plot.py --sourcecsv rukmvmi --targetexcel data/combinenpi/uk --targetsheetname mvmi
# usa
# make data
# mask wearing order for the full season
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatynvmi --model lr --cpl a1 --noint --cpltp 202148 --cpled 202215 --loadcoef usacoefmask
python script/name_data.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatynvmi --model lr --cpl a1 --noint --cpltp 202148 --cpled 202215 --targetname usamask50ifirststage --targetfolder result
python script/imputation_reglike.py --lag 52 --region usanvmi --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate usamask50ifirststage --loadcoef usacoef
python script/calavgpercent.py --lag 52 --region usanvmi --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usamask50i
python script/gen_data_plot.py --sourcecsv usamask50i --targetexcel data/combinenpi/usa --targetsheetname mask50i
# usa
# make data
# mask wearing order for the full season
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatymvni --model lr --cpl a1 --noint --cpltp 202148 --cpled 202215 --loadcoef usacoefmask
python script/name_data.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatymvni --model lr --cpl a1 --noint --cpltp 202148 --cpled 202215 --targetname usamask50vfirststage --targetfolder result
python script/imputation_reglike.py --lag 52 --region usamvni --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate usamask50vfirststage --loadcoef usacoef
python script/calavgpercent.py --lag 52 --region usamvni --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usamask50v
python script/gen_data_plot.py --sourcecsv usamask50v --targetexcel data/combinenpi/usa --targetsheetname mask50v
# usa
# prepare data
python script/imputation_reglike.py --lag 52 --region usamvmi --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef usacoef --loadpositiverate usa3hatym
python script/name_data.py --lag 52 --region usamvmi --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatymvmi
# mitigate domestic mitigate international
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatymvmi --model lr --cpl a0 --noint --cpltp 202140  --loadcoef usacoefmask
python script/calavgpercent.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatymvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname rusamvmi
python script/gen_data_plot.py --sourcecsv rusamvmi --targetexcel data/combinenpi/usa --targetsheetname mvmi