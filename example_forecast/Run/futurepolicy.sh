# mask + 50% international
# northern china
# make data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatynvmi --model lr --cpl a1 --noint --cpltp 202149 --cpled 202214 --loadcoef cncoefmask
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatynvmi --model lr --cpl a1 --noint --cpltp 202149 --cpled 202214 --targetname cnmask50ifirststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region cninvmi --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate cnmask50ifirststage  --loadcoef cncoef
python script/calculate_plot_statistics.py --lag 52 --region cninvmi --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnmask50i
python script/auxiliary_gen_excel_data.py --sourcecsv cnmask50i --targetexcel result/combinenpi/cn --targetsheetname mask50i
# mask + 50% international
# northern china
# make data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatymvni --model lr --cpl a1 --noint --cpltp 202149 --cpled 202214 --loadcoef cncoefmask
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatymvni --model lr --cpl a1 --noint --cpltp 202149 --cpled 202214 --targetname cnmask50vfirststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region cnimvni --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate cnmask50vfirststage  --loadcoef cncoef
python script/calculate_plot_statistics.py --lag 52 --region cnimvni --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnmask50v
python script/auxiliary_gen_excel_data.py --sourcecsv cnmask50v --targetexcel result/combinenpi/cn --targetsheetname mask50v
# northern china
# prepare rawdata under different volume
python script/estimation_forecast.py --lag 52 --region cnimvmi --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05  --loadcoef cncoef --loadpositiverate cnihatym
python script/auxiliary_name_file.py --lag 52 --region cnimvmi --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatymvmi
# mitigate domestic mitigate international flu level with the effect of previous mask wearing
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatymvmi --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cncoefmask
python script/calculate_plot_statistics.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatymvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname cnmvmi
python script/auxiliary_gen_excel_data.py --sourcecsv cnmvmi --targetexcel result/combinenpi/cn --targetsheetname mvmi
# southern china
# make data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatynvmi --model lr --cpl a1 --noint --cpltp 202145 --cpled 202215 --loadcoef cscoefmask
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatynvmi --model lr --cpl a1 --noint --cpltp 202145 --cpled 202215 --targetname csmask50ifirststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region csib3nvmi --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate csmask50ifirststage --loadcoef cscoef
python script/calculate_plot_statistics.py --lag 52 --region csib3nvmi --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csmask50i
python script/auxiliary_gen_excel_data.py --sourcecsv csmask50i --targetexcel result/combinenpi/cs --targetsheetname mask50i
# southern china
# make data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatymvni --model lr --cpl a1 --noint --cpltp 202145 --cpled 202215 --loadcoef cscoefmask
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatymvni --model lr --cpl a1 --noint --cpltp 202145 --cpled 202215 --targetname csmask50vfirststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region csib3mvni --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate csmask50vfirststage --loadcoef cscoef
python script/calculate_plot_statistics.py --lag 52 --region csib3mvni --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csmask50v
python script/auxiliary_gen_excel_data.py --sourcecsv csmask50v --targetexcel result/combinenpi/cs --targetsheetname mask50v
# southern china
# prepare data
python script/estimation_forecast.py --lag 52 --region csimvmi --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cscoef --loadpositiverate csihatym
python script/auxiliary_name_file.py --lag 52 --region csimvmi --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatymvmi
# mitigate domestic mitigate international
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatymvmi --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cscoefmask
python script/calculate_plot_statistics.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatymvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname csmvmi
python script/auxiliary_gen_excel_data.py --sourcecsv csmvmi --targetexcel result/combinenpi/cs --targetsheetname mvmi
# england
# data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatynvmi --model lr --cpl a1 --noint --cpltp 202150 --cpled 202213 --loadcoef ukcoefmask
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatynvmi --model lr --cpl a1 --noint --cpltp 202150 --cpled 202213 --targetname ukmask50ifirststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region uknvmi --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05  --loadpositiverate ukmask50ifirststage --loadcoef ukcoef
python script/calculate_plot_statistics.py --lag 52 --region uknvmi --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname ukmask50i
python script/auxiliary_gen_excel_data.py --sourcecsv ukmask50i --targetexcel result/combinenpi/uk --targetsheetname mask50i
# england
# data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatymvni --model lr --cpl a1 --noint --cpltp 202150 --cpled 202213 --loadcoef ukcoefmask
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatymvni --model lr --cpl a1 --noint --cpltp 202150 --cpled 202213 --targetname ukmask50vfirststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region ukmvni --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05  --loadpositiverate ukmask50vfirststage --loadcoef ukcoef
python script/calculate_plot_statistics.py --lag 52 --region ukmvni --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname ukmask50v
python script/auxiliary_gen_excel_data.py --sourcecsv ukmask50v --targetexcel result/combinenpi/uk --targetsheetname mask50v
# england
# prepare data
python script/estimation_forecast.py --lag 52 --region ukmvmi --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef --loadpositiverate uk3hatym
python script/auxiliary_name_file.py --lag 52 --region ukmvmi --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatymvmi
# mitigate domestic mitigate international
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatymvmi --model lr --cpl a0 --noint --cpltp 202140 --loadcoef ukcoefmask
python script/calculate_plot_statistics.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatymvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname rukmvmi
python script/auxiliary_gen_excel_data.py --sourcecsv rukmvmi --targetexcel result/combinenpi/uk --targetsheetname mvmi
# usa
# make data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatynvmi --model lr --cpl a1 --noint --cpltp 202148 --cpled 202215 --loadcoef usacoefmask
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatynvmi --model lr --cpl a1 --noint --cpltp 202148 --cpled 202215 --targetname usamask50ifirststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region usanvmi --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate usamask50ifirststage --loadcoef usacoef
python script/calculate_plot_statistics.py --lag 52 --region usanvmi --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usamask50i
python script/auxiliary_gen_excel_data.py --sourcecsv usamask50i --targetexcel result/combinenpi/usa --targetsheetname mask50i
# usa
# make data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatymvni --model lr --cpl a1 --noint --cpltp 202148 --cpled 202215 --loadcoef usacoefmask
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatymvni --model lr --cpl a1 --noint --cpltp 202148 --cpled 202215 --targetname usamask50vfirststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region usamvni --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate usamask50vfirststage --loadcoef usacoef
python script/calculate_plot_statistics.py --lag 52 --region usamvni --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usamask50v
python script/auxiliary_gen_excel_data.py --sourcecsv usamask50v --targetexcel result/combinenpi/usa --targetsheetname mask50v
# usa
# prepare data
python script/estimation_forecast.py --lag 52 --region usamvmi --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef usacoef --loadpositiverate usa3hatym
python script/auxiliary_name_file.py --lag 52 --region usamvmi --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatymvmi
# mitigate domestic mitigate international
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatymvmi --model lr --cpl a0 --noint --cpltp 202140  --loadcoef usacoefmask
python script/calculate_plot_statistics.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatymvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname rusamvmi
python script/auxiliary_gen_excel_data.py --sourcecsv rusamvmi --targetexcel result/combinenpi/usa --targetsheetname mvmi