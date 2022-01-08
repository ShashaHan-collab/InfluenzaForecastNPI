# mask plot
# northern china
# make data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a3 --noint --cpltp 202149 --cpled 202214 --newclag --newclagtp 202149 --newclagnum 3 --loadcoef cncoefmask
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a3 --noint --cpltp 202149 --cpled 202214 --newclag --newclagtp 202149 --newclagnum 3 --targetname cnmask4550firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate cnmask4550firststage_fwd  --loadcoef cncoef
python script/calculate_plot_statistics.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnmask45-50_fwd
python script/auxiliary_gen_excel_data.py --sourcecsv cnmask45-50_fwd --targetexcel result/future/cn --targetsheetname mask45-50_fwd
# mask wearing order for the first half season
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a7 --noint --cpltp 202149 --cpled 202214 --newclag --newclagtp 202149 --newclagnum 7 --loadcoef cncoefmask
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a7 --noint --cpltp 202149 --cpled 202214 --targetname cnmask5104firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate cnmask5104firststage_fwd  --loadcoef cncoef
python script/calculate_plot_statistics.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnmask51-4_fwd
python script/auxiliary_gen_excel_data.py --sourcecsv cnmask51-4_fwd --targetexcel result/future/cn --targetsheetname mask51-4_fwd
# mask wearing order for the second half season
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a5 --noint --cpltp 202149 --cpled 202214 --newclag --newclagtp 202149 --newclagnum 5 --loadcoef cncoefmask
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a5 --noint --cpltp 202149 --cpled 202214 --targetname cnmask4504firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate cnmask4504firststage_fwd  --loadcoef cncoef
python script/calculate_plot_statistics.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnmask_fwd
python script/auxiliary_gen_excel_data.py --sourcecsv cnmask_fwd --targetexcel result/future/cn --targetsheetname mask_fwd
# southern china
# make data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a3 --noint --cpltp 202145 --cpled 202215 --newclag --newclagtp 202145 --newclagnum 3 --loadcoef cscoefmask
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a3 --noint --cpltp 202145 --cpled 202215 --targetname csmask4550firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate csmask4550firststage_fwd --loadcoef cscoef
python script/calculate_plot_statistics.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csmask45-50_fwd
python script/auxiliary_gen_excel_data.py --sourcecsv csmask45-50_fwd --targetexcel result/future/cs --targetsheetname mask45-50_fwd
# mask wearing order for the first half season
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a7 --noint --cpltp 202145 --cpled 202215 --newclag --newclagtp 202145 --newclagnum 7 --loadcoef cscoefmask
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a7 --noint --cpltp 202145 --cpled 202215 --targetname csmask5104firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate csmask5104firststage_fwd --loadcoef cscoef
python script/calculate_plot_statistics.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csmask51-4_fwd
python script/auxiliary_gen_excel_data.py --sourcecsv csmask51-4_fwd --targetexcel result/future/cs --targetsheetname mask51-4_fwd
# mask wearing order for the second half season
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a5 --noint --cpltp 202145 --cpled 202215 --newclag --newclagtp 202145 --newclagnum 5 --loadcoef cscoefmask
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a5 --noint --cpltp 202145 --cpled 202215 --targetname csmask4504firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate csmask4504firststage_fwd --loadcoef cscoef
python script/calculate_plot_statistics.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csmask_fwd
python script/auxiliary_gen_excel_data.py --sourcecsv csmask_fwd --targetexcel result/future/cs --targetsheetname mask_fwd
# england
# data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a3 --noint --cpltp 202150 --cpled 202213 --newclag --newclagtp 202150 --newclagnum 3 --loadcoef ukcoefmask
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a3 --noint --cpltp 202150 --cpled 202213 --targetname ukmask4550firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05  --loadpositiverate ukmask4550firststage_fwd --loadcoef ukcoef
python script/calculate_plot_statistics.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname ukmask45-50_fwd
python script/auxiliary_gen_excel_data.py --sourcecsv ukmask45-50_fwd --targetexcel result/future/uk --targetsheetname mask45-50_fwd
# mask wearing order for the first half season
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a7 --noint --cpltp 202150 --cpled 202213 --newclag --newclagtp 202150 --newclagnum 7 --loadcoef ukcoefmask
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a7 --noint --cpltp 202150 --cpled 202213 --targetname ukmask5104firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05  --loadpositiverate ukmask5104firststage_fwd --loadcoef ukcoef
python script/calculate_plot_statistics.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname ukmask51-4_fwd
python script/auxiliary_gen_excel_data.py --sourcecsv ukmask51-4_fwd --targetexcel result/future/uk --targetsheetname mask51-4_fwd
# mask wearing order for the second half season
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a5 --noint --cpltp 202150 --cpled 202213 --newclag --newclagtp 202150 --newclagnum 5 --loadcoef ukcoefmask
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a5 --noint --cpltp 202150 --cpled 202213 --targetname ukmask4504firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05  --loadpositiverate ukmask4504firststage_fwd --loadcoef ukcoef
python script/calculate_plot_statistics.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname ukmask_fwd
python script/auxiliary_gen_excel_data.py --sourcecsv ukmask_fwd --targetexcel result/future/uk --targetsheetname mask_fwd
# usa
# make data
# mask wearing order for the full season
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a3 --noint --cpltp 202148 --cpled 202215 --newclag --newclagtp 202148 --newclagnum 3 --loadcoef usacoefmask
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a3 --noint --cpltp 202148 --cpled 202215 --targetname usamask4550firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate usamask4550firststage_fwd --loadcoef usacoef
python script/calculate_plot_statistics.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usamask45-50_fwd
python script/auxiliary_gen_excel_data.py --sourcecsv usamask45-50_fwd --targetexcel result/future/usa --targetsheetname mask45-50_fwd
# mask wearing order for the first half season
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a7 --noint --cpltp 202148 --cpled 202215 --newclag --newclagtp 202148 --newclagnum 7 --loadcoef usacoefmask
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a7 --noint --cpltp 202148 --cpled 202215 --targetname usamask5104firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate usamask5104firststage_fwd --loadcoef usacoef
python script/calculate_plot_statistics.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usamask51-4_fwd
python script/auxiliary_gen_excel_data.py --sourcecsv usamask51-4_fwd --targetexcel result/future/usa --targetsheetname mask51-4_fwd
# mask wearing order for the second half season
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a5 --noint --cpltp 202148 --cpled 202215 --newclag --newclagtp 202148 --newclagnum 5 --loadcoef usacoefmask
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a5 --noint --cpltp 202148 --cpled 202215 --targetname usamask4504firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate usamask4504firststage_fwd --loadcoef usacoef
python script/calculate_plot_statistics.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usamask_fwd
python script/auxiliary_gen_excel_data.py --sourcecsv usamask_fwd --targetexcel result/future/usa --targetsheetname mask_fwd
