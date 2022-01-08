# mask plot
# northern china
# make data
# flu level with novaccine and mask level at 30%
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a3 --noint --cpltp 202149 --cpled 202214 --newclag --newclagtp 202149 --newclagnum 3 --loadcoef cncoefmask
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a3 --noint --cpltp 202149 --cpled 202214 --newclag --newclagtp 202149 --newclagnum 3 --targetname cnnovaccine_30_first --targetfolder result
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate cnnovaccine_30_first  --loadcoef cncoef
python script/calculate_plot_statistics.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnnovaccine_30
python script/auxiliary_gen_excel_data.py --sourcecsv cnnovaccine_30 --targetexcel result/future/cn --targetsheetname novaccine_30
# make flu level with vaccination under mitigate travel volume
python script/estimation_forecast.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88
python script/auxiliary_name_file.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname cnihatymvaccine --targetfolder preprocessed_data --movetype mean
python script/auxiliary_name_file.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname cnihatymvaccine --targetfolder result --movetype mean
# make flu level with vaccination under normal travel volume after 2021 week 40
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --loadcoef cncoef --loadpositiverate cnihatymvaccine
python script/auxiliary_name_file.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname cnihatyv2vaccine --targetfolder preprocessed_data
python script/auxiliary_name_file.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname cnihatyv2vaccine --targetfolder result
# # flu level with vaccination and without mask wearing
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 13 --yam cnihatyv2vaccine --model lr --cpl a0 --noint --cpltp 202140  --loadcoef cncoefmask
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 13 --yam cnihatyv2vaccine --model lr --cpl a0 --noint --cpltp 202140 --targetname cnvaccine --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 13 --yam cnihatyv2vaccine --model lr --cpl a0 --noint --cpltp 202140 --targetname cnvaccine
python script/auxiliary_gen_excel_data.py --sourcecsv cnvaccine --targetexcel result/future/cn --targetsheetname vaccine
# flu level with vaccination and with mask wearing at 30%
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyv2vaccine --model lr --cpl a3 --noint --cpltp 202149 --cpled 202214 --newclag --newclagtp 202149 --newclagnum 3 --loadcoef cncoefmask
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 13 --yam cnihatyv2vaccine --model lr --cpl a3 --noint --cpltp 202149 --cpled 202214 --newclag --newclagtp 202149 --newclagnum 3 --targetname cnvaccine_30_first --targetfolder result
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --loadpositiverate cnvaccine_30_first  --loadcoef cncoef
python script/calculate_plot_statistics.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202215 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname cnvaccine_30
python script/auxiliary_gen_excel_data.py --sourcecsv cnvaccine_30 --targetexcel result/future/cn --targetsheetname vaccine_30
# southern china
# make data
# flu level with novaccine and mask level at 30%
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a3 --noint --cpltp 202145 --cpled 202215 --newclag --newclagtp 202145 --newclagnum 3 --loadcoef cscoefmask
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a3 --noint --cpltp 202145 --cpled 202215 --targetname csnovaccine_30_first --targetfolder result
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate csnovaccine_30_first --loadcoef cscoef
python script/calculate_plot_statistics.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csnovaccine_30
python script/auxiliary_gen_excel_data.py --sourcecsv csnovaccine_30 --targetexcel result/future/cs --targetsheetname novaccine_30
# make flu level with vaccination under mitigate travel volume
python script/estimation_forecast.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88
python script/auxiliary_name_file.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname csihatymvaccine --targetfolder preprocessed_data --movetype mean
python script/auxiliary_name_file.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname csihatymvaccine --targetfolder result --movetype mean
# make csihatyv2vaccine
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --loadcoef cscoef --loadpositiverate csihatymvaccine
python script/auxiliary_name_file.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname csihatyv2vaccine --targetfolder preprocessed_data
python script/auxiliary_name_file.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname csihatyv2vaccine --targetfolder result
# # flu level with vaccination and without mask wearing
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 11 --yam csihatyv2vaccine --model lr --cpl a0 --noint --cpltp 202140  --loadcoef cscoefmask
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 11 --yam csihatyv2vaccine --model lr --cpl a0 --noint --cpltp 202140 --targetname csvaccine --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 11 --yam csihatyv2vaccine --model lr --cpl a0 --noint --cpltp 202140 --targetname csvaccine
python script/auxiliary_gen_excel_data.py --sourcecsv csvaccine --targetexcel result/future/cs --targetsheetname vaccine
# flu level with vaccination and with mask wearing at 30%
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyv2vaccine --model lr --cpl a3 --noint --cpltp 202145 --cpled 202215 --newclag --newclagtp 202145 --newclagnum 3 --loadcoef cscoefmask
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202252 --ctype new --clag 11 --yam csihatyv2vaccine --model lr --cpl a3 --noint --cpltp 202145 --cpled 202215 --targetname csvaccine_30_first --targetfolder result
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --loadpositiverate csvaccine_30_first --loadcoef cscoef
python script/calculate_plot_statistics.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname csvaccine_30
python script/auxiliary_gen_excel_data.py --sourcecsv csvaccine_30 --targetexcel result/future/cs --targetsheetname vaccine_30
# uk
# data
# flu level with novaccine and mask level at 30%
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a3 --noint --cpltp 202150 --cpled 202213 --newclag --newclagtp 202150 --newclagnum 3 --loadcoef ukcoefmask
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a3 --noint --cpltp 202150 --cpled 202213 --targetname ukmask4550firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05  --loadpositiverate ukmask4550firststage_fwd --loadcoef ukcoef
python script/calculate_plot_statistics.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uknovaccine_30
python script/auxiliary_gen_excel_data.py --sourcecsv uknovaccine_30 --targetexcel result/future/uk --targetsheetname novaccine_30
# make flu level with vaccination under mitigate travel volume
python script/estimation_forecast.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88
python script/auxiliary_name_file.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname uk3hatymvaccine --targetfolder preprocessed_data --movetype mean
python script/auxiliary_name_file.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname uk3hatymvaccine --targetfolder result --movetype mean
# make flu level with vaccination under normal travel volume after 2021 week 40
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --loadcoef ukcoef --loadpositiverate uk3hatymvaccine
python script/auxiliary_name_file.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname uk3hatyv2vaccine --targetfolder preprocessed_data
python script/auxiliary_name_file.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname uk3hatyv2vaccine --targetfolder result
# # flu level with vaccination and without mask wearing
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 24 --yam uk3hatyv2vaccine --model lr --cpl a0 --noint --cpltp 202140  --loadcoef ukcoefmask
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 24 --yam uk3hatyv2vaccine --model lr --cpl a0 --noint --cpltp 202140 --targetname ukvaccine --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 24 --yam uk3hatyv2vaccine --model lr --cpl a0 --noint --cpltp 202140 --targetname ukvaccine
python script/auxiliary_gen_excel_data.py --sourcecsv ukvaccine --targetexcel result/future/uk --targetsheetname vaccine
# flu level with vaccination and with mask wearing at 30%
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyv2vaccine --model lr --cpl a3 --noint --cpltp 202150 --cpled 202213 --newclag --newclagtp 202150 --newclagnum 3 --loadcoef ukcoefmask
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202252 --ctype new --clag 24 --yam uk3hatyv2vaccine --model lr --cpl a3 --noint --cpltp 202150 --cpled 202213 --targetname ukvaccine_30_first --targetfolder result
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --loadpositiverate ukvaccine_30_first --loadcoef ukcoef
python script/calculate_plot_statistics.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202214 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname ukvaccine_30
python script/auxiliary_gen_excel_data.py --sourcecsv ukvaccine_30 --targetexcel result/future/uk --targetsheetname vaccine_30
# usa
# make data
# flu level with novaccine and mask level at 30%
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a3 --noint --cpltp 202148 --cpled 202215 --newclag --newclagtp 202148 --newclagnum 3 --loadcoef usacoefmask
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a3 --noint --cpltp 202148 --cpled 202215 --targetname usamask4550firststage_fwd --targetfolder result
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --loadpositiverate usamask4550firststage_fwd --loadcoef usacoef
python script/calculate_plot_statistics.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usanovaccine_30
python script/auxiliary_gen_excel_data.py --sourcecsv usanovaccine_30 --targetexcel result/future/usa --targetsheetname novaccine_30
# make flu level with vaccination under mitigate travel volume
python script/estimation_forecast.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname usa3hatymvaccine --targetfolder preprocessed_data --movetype mean
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname usa3hatymvaccine --targetfolder result --movetype mean
# make flu level with vaccination under normal travel volume after 2021 week 40
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --loadcoef usacoef --loadpositiverate usa3hatymvaccine
python script/auxiliary_name_file.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname usa3hatyv2vaccine --targetfolder preprocessed_data
python script/auxiliary_name_file.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname usa3hatyv2vaccine --targetfolder result
# # flu level with vaccination and without mask wearing
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 35 --yam usa3hatyv2vaccine --model lr --cpl a0 --noint --cpltp 202140  --loadcoef usacoefmask
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 35 --yam usa3hatyv2vaccine --model lr --cpl a0 --noint --cpltp 202140  --targetname usavaccine --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 35 --yam usa3hatyv2vaccine --model lr --cpl a0 --noint --cpltp 202140  --targetname usavaccine
python script/auxiliary_gen_excel_data.py --sourcecsv usavaccine --targetexcel result/future/usa --targetsheetname vaccine
# flu level with vaccination and with mask wearing at 30%
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyv2vaccine --model lr --cpl a3 --noint --cpltp 202148 --cpled 202215 --newclag --newclagtp 202148 --newclagnum 3 --loadcoef usacoefmask
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202252 --ctype new --clag 35 --yam usa3hatyv2vaccine --model lr --cpl a3 --noint --cpltp 202148 --cpled 202215 --targetname usavaccine_30_first --targetfolder result
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --loadpositiverate usavaccine_30_first --loadcoef usacoef
python script/calculate_plot_statistics.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202216 --pend 202252 --cov volume,vw --lsa 1e-05 --vaccine 0.88 --targetname usavaccine_30
python script/auxiliary_gen_excel_data.py --sourcecsv usavaccine_30 --targetexcel result/future/usa --targetsheetname vaccine_30
