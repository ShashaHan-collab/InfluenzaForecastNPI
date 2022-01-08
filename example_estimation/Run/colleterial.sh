# # china north
# movement restriction
python script/estimation_forecast.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05
python script/auxiliary_name_file.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnmobility --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnmobility
python script/auxiliary_gen_excel_data.py --sourcecsv cnmobility --targetexcel result/colleterialeffects/cn --targetsheetname movementrestriction
# mask
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202139 --ctype new --clag 13 --yam cnihatyv2 --model lr --noint --loadcoef cncoefmask --loadpositiverate cnihatyv2
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202139 --ctype new --clag 13 --yam cnihatyv2 --model lr --noint --targetname cnmask --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202139 --ctype new --clag 13 --yam cnihatyv2 --model lr --noint --targetname cnmaskwearing
python script/auxiliary_gen_excel_data.py --sourcecsv cnmaskwearing --targetexcel result/colleterialeffects/cn --targetsheetname maskwearingorder
# nonpi
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05  --loadcoef cncoef
python script/auxiliary_name_file.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnnonpi --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnnonpi
python script/auxiliary_gen_excel_data.py --sourcecsv cnnonpi --targetexcel result/colleterialeffects/cn --targetsheetname neithertwonpis
# china south
# movement restriction
python script/estimation_forecast.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05
python script/auxiliary_name_file.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csmobility --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csmobility
python script/auxiliary_gen_excel_data.py --sourcecsv csmobility --targetexcel result/colleterialeffects/cs --targetsheetname movementrestriction
# mask
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202139 --ctype new --clag 11 --yam csihatyv2 --model lr --noint --loadcoef cscoefmask --loadpositiverate csihatyv2
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202139 --ctype new --clag 11 --yam csihatyv2 --model lr --noint --targetname csmask --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202139 --ctype new --clag 11 --yam csihatyv2 --model lr --noint --targetname csmaskwearing
python script/auxiliary_gen_excel_data.py --sourcecsv csmaskwearing --targetexcel result/colleterialeffects/cs --targetsheetname maskwearingorder
# nonpi
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef cscoef
python script/auxiliary_name_file.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csnonpi --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csnonpi
python script/auxiliary_gen_excel_data.py --sourcecsv csnonpi --targetexcel result/colleterialeffects/cs --targetsheetname neithertwonpis
#usa
# movement restriction
python script/estimation_forecast.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usamobility --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usamobility
python script/auxiliary_gen_excel_data.py --sourcecsv usamobility --targetexcel result/colleterialeffects/usa --targetsheetname movementrestriction
# mask
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202139 --ctype new --clag 35 --yam usa3hatyv2 --model lr --noint --loadcoef usacoefmask --loadpositiverate usa3hatyv2
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202139 --ctype new --clag 35 --yam usa3hatyv2 --model lr --noint --targetname usamask --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202139 --ctype new --clag 35 --yam usa3hatyv2 --model lr --noint --targetname usamaskwearing
python script/auxiliary_gen_excel_data.py --sourcecsv usamaskwearing --targetexcel result/colleterialeffects/usa --targetsheetname maskwearingorder
# nonpi
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef usacoef
python script/auxiliary_name_file.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usanonpi --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usanonpi
python script/auxiliary_gen_excel_data.py --sourcecsv usanonpi --targetexcel result/colleterialeffects/usa --targetsheetname neithertwonpis
# england
# movement restriction
python script/estimation_forecast.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05
python script/auxiliary_name_file.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukmobility --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukmobility
python script/auxiliary_gen_excel_data.py --sourcecsv ukmobility --targetexcel result/colleterialeffects/uk --targetsheetname movementrestriction
# mask
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202139 --ctype new --clag 24 --yam uk3hatyv2 --model lr --noint --loadcoef ukcoefmask --loadpositiverate uk3hatyv2
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202139 --ctype new --clag 24 --yam uk3hatyv2 --model lr --noint --targetname ukmask --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202139 --ctype new --clag 24 --yam uk3hatyv2 --model lr --noint --targetname ukmaskwearing
python script/auxiliary_gen_excel_data.py --sourcecsv ukmaskwearing --targetexcel result/colleterialeffects/uk --targetsheetname maskwearingorder
# nonpi
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef
python script/auxiliary_name_file.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname uknonpi --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname uknonpi
python script/auxiliary_gen_excel_data.py --sourcecsv uknonpi --targetexcel result/colleterialeffects/uk --targetsheetname neithertwonpis