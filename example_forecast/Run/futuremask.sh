# mask plot
# northern china
# make data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a1 --noint --cpltp 202149 --cpled 202205 --loadcoef cncoefmask
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a1 --noint --cpltp 202149 --cpled 202205 --targetname cnmask4550firststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202206 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate cnmask4550firststage  --loadcoef cncoef
python script/calculate_plot_statistics.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202206 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnmask45-50
python script/auxiliary_gen_excel_data.py --sourcecsv cnmask45-50 --targetexcel preprocessed_data/future/cn --targetsheetname mask45-50
# mask wearing order for the first half season
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a1 --noint --cpltp 202206 --cpled 202214 --loadcoef cncoefmask
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a1 --noint --cpltp 202206 --cpled 202214 --targetname cnmask5104firststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate cnmask5104firststage  --loadcoef cncoef
python script/calculate_plot_statistics.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnmask51-4
python script/auxiliary_gen_excel_data.py --sourcecsv cnmask51-4 --targetexcel preprocessed_data/future/cn --targetsheetname mask51-4
# mask wearing order for the second half season
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a1 --noint --cpltp 202149 --cpled 202214 --loadcoef cncoefmask
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a1 --noint --cpltp 202149 --cpled 202214 --targetname cnmask4504firststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate cnmask4504firststage  --loadcoef cncoef
python script/calculate_plot_statistics.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnmask
python script/auxiliary_gen_excel_data.py --sourcecsv cnmask --targetexcel preprocessed_data/future/cn --targetsheetname mask
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a1 --noint --cpltp 202149 --cpled 202214 --targetname cn21mask --targetfolder preprocessed_data/ci
# southern china
# make data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a1 --noint --cpltp 202145 --cpled 202204 --loadcoef cscoefmask
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a1 --noint --cpltp 202145 --cpled 202204 --targetname csmask4550firststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202205 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate csmask4550firststage --loadcoef cscoef
python script/calculate_plot_statistics.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202205 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csmask45-50
python script/auxiliary_gen_excel_data.py --sourcecsv csmask45-50 --targetexcel preprocessed_data/future/cs --targetsheetname mask45-50
# mask wearing order for the first half season
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a1 --noint --cpltp 202204 --cpled 202215 --loadcoef cscoefmask
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a1 --noint --cpltp 202204 --cpled 202215 --targetname csmask5104firststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate csmask5104firststage --loadcoef cscoef
python script/calculate_plot_statistics.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csmask51-4
python script/auxiliary_gen_excel_data.py --sourcecsv csmask51-4 --targetexcel preprocessed_data/future/cs --targetsheetname mask51-4
# mask wearing order for the second half season
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a1 --noint --cpltp 202145 --cpled 202215 --loadcoef cscoefmask
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a1 --noint --cpltp 202145 --cpled 202215 --targetname csmask4504firststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate csmask4504firststage --loadcoef cscoef
python script/calculate_plot_statistics.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csmask
python script/auxiliary_gen_excel_data.py --sourcecsv csmask --targetexcel preprocessed_data/future/cs --targetsheetname mask
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a1 --noint --cpltp 202145 --cpled 202215 --targetname cs21mask --targetfolder preprocessed_data/ci
# uk
# data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a1 --noint --cpltp 202150 --cpled 202205 --loadcoef ukcoefmask
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a1 --noint --cpltp 202150 --cpled 202205 --targetname ukmask4550firststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202206 --pend 202252 --cov volume,vw --lsa 1e-05  --loadpositiverate ukmask4550firststage --loadcoef ukcoef
python script/calculate_plot_statistics.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202206 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname ukmask45-50
python script/auxiliary_gen_excel_data.py --sourcecsv ukmask45-50 --targetexcel preprocessed_data/future/uk --targetsheetname mask45-50
# mask wearing order for the first half season
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a1 --noint --cpltp 202206 --cpled 202213 --loadcoef ukcoefmask
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a1 --noint --cpltp 202206 --cpled 202213 --targetname ukmask5104firststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05  --loadpositiverate ukmask5104firststage --loadcoef ukcoef
python script/calculate_plot_statistics.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname ukmask51-4
python script/auxiliary_gen_excel_data.py --sourcecsv ukmask51-4 --targetexcel preprocessed_data/future/uk --targetsheetname mask51-4
# mask wearing order for the second half season
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a1 --noint --cpltp 202150 --cpled 202213 --loadcoef ukcoefmask
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a1 --noint --cpltp 202150 --cpled 202213 --targetname ukmask4504firststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05  --loadpositiverate ukmask4504firststage --loadcoef ukcoef
python script/calculate_plot_statistics.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname ukmask
python script/auxiliary_gen_excel_data.py --sourcecsv ukmask --targetexcel preprocessed_data/future/uk --targetsheetname mask
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a1 --noint --cpltp 202150 --cpled 202213 --targetname uk21mask --targetfolder preprocessed_data/ci
# usa
# make data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a1 --noint --cpltp 202148 --cpled 202205 --loadcoef usacoefmask
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a1 --noint --cpltp 202148 --cpled 202205 --targetname usamask4550firststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202206 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate usamask4550firststage --loadcoef usacoef
python script/calculate_plot_statistics.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202206 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usamask45-50
python script/auxiliary_gen_excel_data.py --sourcecsv usamask45-50 --targetexcel preprocessed_data/future/usa --targetsheetname mask45-50
# mask wearing order for the first half season
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a1 --noint --cpltp 202206 --cpled 202215 --loadcoef usacoefmask
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a1 --noint --cpltp 202206 --cpled 202215 --targetname usamask5104firststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate usamask5104firststage --loadcoef usacoef
python script/calculate_plot_statistics.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usamask51-4
python script/auxiliary_gen_excel_data.py --sourcecsv usamask51-4 --targetexcel preprocessed_data/future/usa --targetsheetname mask51-4
# mask wearing order for the second half season
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a1 --noint --cpltp 202148 --cpled 202215 --loadcoef usacoefmask
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a1 --noint --cpltp 202148 --cpled 202215 --targetname usamask4504firststage --targetfolder result
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate usamask4504firststage --loadcoef usacoef
python script/calculate_plot_statistics.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usamask
python script/auxiliary_gen_excel_data.py --sourcecsv usamask --targetexcel preprocessed_data/future/usa --targetsheetname mask
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a1 --noint --cpltp 202148 --cpled 202215 --targetname usa21mask --targetfolder preprocessed_data/ci
