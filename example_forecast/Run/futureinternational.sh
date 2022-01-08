# international plot
# northern china
# prepare rawdata under different volume, 3i means 30% of normal volume, mi means 50% of normal volume and 7i means 70% of normal volume
python script/estimation_forecast.py --lag 52 --region cninv3i --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05  --loadcoef cncoef --loadpositiverate cnihatym
python script/auxiliary_name_file.py --lag 52 --region cninv3i --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatynv3i
python script/estimation_forecast.py --lag 52 --region cninv7i --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05  --loadcoef cncoef --loadpositiverate cnihatym
python script/auxiliary_name_file.py --lag 52 --region cninv7i --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatynv7i
python script/estimation_forecast.py --lag 52 --region cninvmi --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05  --loadcoef cncoef --loadpositiverate cnihatym
python script/auxiliary_name_file.py --lag 52 --region cninvmi --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatynvmi
# normal domestic mitigate international flu level with the effect of previous mask wearing
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatynv3i --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cncoefmask
python script/calculate_plot_statistics.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatynv3i --model lr --cpl a0 --noint --cpltp 202140 --targetname cnnv3i
python script/auxiliary_gen_excel_data.py --sourcecsv cnnv3i --targetexcel result/future/cn --targetsheetname nv3i
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatynv7i --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cncoefmask
python script/calculate_plot_statistics.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatynv7i --model lr --cpl a0 --noint --cpltp 202140 --targetname cnnv7i
python script/auxiliary_gen_excel_data.py --sourcecsv cnnv7i --targetexcel result/future/cn --targetsheetname nv7i
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatynvmi --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cncoefmask
python script/calculate_plot_statistics.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatynvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname cnnvmi
python script/auxiliary_gen_excel_data.py --sourcecsv cnnvmi --targetexcel result/future/cn --targetsheetname nvmi
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatynvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname cn21mi --targetfolder result/ci
# southern china
# prepare data
python script/estimation_forecast.py --lag 52 --region csinv3i --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cscoef --loadpositiverate csihatym
python script/auxiliary_name_file.py --lag 52 --region csinv3i --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatynv3i
python script/estimation_forecast.py --lag 52 --region csinv7i --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cscoef --loadpositiverate csihatym
python script/auxiliary_name_file.py --lag 52 --region csinv7i --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatynv7i
python script/estimation_forecast.py --lag 52 --region csib3nvmi --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cscoef --loadpositiverate csihatym
python script/auxiliary_name_file.py --lag 52 --region csib3nvmi --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatynvmi
# normal domestic mitigate international
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatynv3i --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cscoefmask
python script/calculate_plot_statistics.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatynv3i --model lr --cpl a0 --noint --cpltp 202140 --targetname csnv3i
python script/auxiliary_gen_excel_data.py --sourcecsv csnv3i --targetexcel result/future/cs --targetsheetname nv3i
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatynv7i --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cscoefmask
python script/calculate_plot_statistics.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatynv7i --model lr --cpl a0 --noint --cpltp 202140 --targetname csnv7i
python script/auxiliary_gen_excel_data.py --sourcecsv csnv7i --targetexcel result/future/cs --targetsheetname nv7i
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatynvmi --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cscoefmask
python script/calculate_plot_statistics.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatynvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname csnvmi
python script/auxiliary_gen_excel_data.py --sourcecsv csnvmi --targetexcel result/future/cs --targetsheetname nvmi
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatynvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname cs21mi --targetfolder result/ci
# uk
# prepare data
python script/estimation_forecast.py --lag 52 --region uknv3i --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef --loadpositiverate uk3hatym 
python script/auxiliary_name_file.py --lag 52 --region uknv3i --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatynv3i
python script/estimation_forecast.py --lag 52 --region uknv7i --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef --loadpositiverate uk3hatym
python script/auxiliary_name_file.py --lag 52 --region uknv7i --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatynv7i
python script/estimation_forecast.py --lag 52 --region uknvmi --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef --loadpositiverate uk3hatym
python script/auxiliary_name_file.py --lag 52 --region uknvmi --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatynvmi
# normal domestic mitigate international
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatynv3i --model lr --cpl a0 --noint --cpltp 202140 --loadcoef ukcoefmask
python script/calculate_plot_statistics.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatynv3i --model lr --cpl a0 --noint --cpltp 202140 --targetname ruknv3i
python script/auxiliary_gen_excel_data.py --sourcecsv ruknv3i --targetexcel result/future/uk --targetsheetname nv3i
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatynv7i --model lr --cpl a0 --noint --cpltp 202140 --loadcoef ukcoefmask
python script/calculate_plot_statistics.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatynv7i --model lr --cpl a0 --noint --cpltp 202140 --targetname ruknv7i
python script/auxiliary_gen_excel_data.py --sourcecsv ruknv7i --targetexcel result/future/uk --targetsheetname nv7i
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatynvmi --model lr --cpl a0 --noint --cpltp 202140 --loadcoef ukcoefmask
python script/calculate_plot_statistics.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatynvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname ruknvmi
python script/auxiliary_gen_excel_data.py --sourcecsv ruknvmi --targetexcel result/future/uk --targetsheetname nvmi
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatynvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname uk21mi --targetfolder result/ci
# usa
# prepare data
python script/estimation_forecast.py --lag 52 --region usanv3i --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef usacoef --loadpositiverate usa3hatym
python script/auxiliary_name_file.py --lag 52 --region usanv3i --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatynv3i
python script/estimation_forecast.py --lag 52 --region usanv7i --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef usacoef --loadpositiverate usa3hatym
python script/auxiliary_name_file.py --lag 52 --region usanv7i --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatynv7i
python script/estimation_forecast.py --lag 52 --region usanvmi --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef usacoef --loadpositiverate usa3hatym
python script/auxiliary_name_file.py --lag 52 --region usanvmi --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatynvmi
# normal domestic mitigate international
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatynv3i --model lr --cpl a0 --noint --cpltp 202140  --loadcoef usacoefmask
python script/calculate_plot_statistics.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatynv3i --model lr --cpl a0 --noint --cpltp 202140 --targetname rusanv3i
python script/auxiliary_gen_excel_data.py --sourcecsv rusanv3i --targetexcel result/future/usa --targetsheetname nv3i
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatynv7i --model lr --cpl a0 --noint --cpltp 202140  --loadcoef usacoefmask
python script/calculate_plot_statistics.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatynv7i --model lr --cpl a0 --noint --cpltp 202140 --targetname rusanv7i
python script/auxiliary_gen_excel_data.py --sourcecsv rusanv7i --targetexcel result/future/usa --targetsheetname nv7i
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatynvmi --model lr --cpl a0 --noint --cpltp 202140  --loadcoef usacoefmask
python script/calculate_plot_statistics.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatynvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname rusanvmi
python script/auxiliary_gen_excel_data.py --sourcecsv rusanvmi --targetexcel result/future/usa --targetsheetname nvmi
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatynvmi --model lr --cpl a0 --noint --cpltp 202140 --targetname usa21mi --targetfolder result/ci