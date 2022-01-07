# # china north
# movement restriction
python script/imputation_reglike.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05
python script/name_data.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnmobility --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnmobility
python script/gen_data_plot.py --sourcecsv cnmobility --targetexcel data/colleterialeffects/cn --targetsheetname movementrestriction
# mask
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202139 --ctype new --clag 13 --yam cnihatyv2 --model lr --noint --loadcoef cncoefmask --loadpositiverate cnihatyv2
python script/name_data.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202139 --ctype new --clag 13 --yam cnihatyv2 --model lr --noint --targetname cnmask --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202004 --pend 202139 --ctype new --clag 13 --yam cnihatyv2 --model lr --noint --targetname cnmaskwearing
python script/gen_data_plot.py --sourcecsv cnmaskwearing --targetexcel data/colleterialeffects/cn --targetsheetname maskwearingorder
# nonpi
python script/imputation_reglike.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05  --loadcoef cncoef
python script/name_data.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnnonpi --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnnonpi
python script/gen_data_plot.py --sourcecsv cnnonpi --targetexcel data/colleterialeffects/cn --targetsheetname neithertwonpis
# china south
# movement restriction
python script/imputation_reglike.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05
python script/name_data.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csmobility --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csmobility
python script/gen_data_plot.py --sourcecsv csmobility --targetexcel data/colleterialeffects/cs --targetsheetname movementrestriction
# mask
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202139 --ctype new --clag 11 --yam csihatyv2 --model lr --noint --loadcoef cscoefmask --loadpositiverate csihatyv2
python script/name_data.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202139 --ctype new --clag 11 --yam csihatyv2 --model lr --noint --targetname csmask --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202004 --pend 202139 --ctype new --clag 11 --yam csihatyv2 --model lr --noint --targetname csmaskwearing
python script/gen_data_plot.py --sourcecsv csmaskwearing --targetexcel data/colleterialeffects/cs --targetsheetname maskwearingorder
# nonpi
python script/imputation_reglike.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef cscoef
python script/name_data.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csnonpi --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csnonpi
python script/gen_data_plot.py --sourcecsv csnonpi --targetexcel data/colleterialeffects/cs --targetsheetname neithertwonpis
#usa
# movement restriction
python script/imputation_reglike.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05
python script/name_data.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usamobility --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usamobility
python script/gen_data_plot.py --sourcecsv usamobility --targetexcel data/colleterialeffects/usa --targetsheetname movementrestriction
# mask
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202139 --ctype new --clag 35 --yam usa3hatyv2 --model lr --noint --loadcoef usacoefmask --loadpositiverate usa3hatyv2
python script/name_data.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202139 --ctype new --clag 35 --yam usa3hatyv2 --model lr --noint --targetname usamask --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202014 --pend 202139 --ctype new --clag 35 --yam usa3hatyv2 --model lr --noint --targetname usamaskwearing
python script/gen_data_plot.py --sourcecsv usamaskwearing --targetexcel data/colleterialeffects/usa --targetsheetname maskwearingorder
# nonpi
python script/imputation_reglike.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef usacoef
python script/name_data.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usanonpi --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usanonpi
python script/gen_data_plot.py --sourcecsv usanonpi --targetexcel data/colleterialeffects/usa --targetsheetname neithertwonpis
# uk
# movement restriction
python script/imputation_reglike.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05
python script/name_data.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukmobility --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukmobility
python script/gen_data_plot.py --sourcecsv ukmobility --targetexcel data/colleterialeffects/uk --targetsheetname movementrestriction
# mask
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202139 --ctype new --clag 24 --yam uk3hatyv2 --model lr --noint --loadcoef ukcoefmask --loadpositiverate uk3hatyv2
python script/name_data.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202139 --ctype new --clag 24 --yam uk3hatyv2 --model lr --noint --targetname ukmask --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202030 --pend 202139 --ctype new --clag 24 --yam uk3hatyv2 --model lr --noint --targetname ukmaskwearing
python script/gen_data_plot.py --sourcecsv ukmaskwearing --targetexcel data/colleterialeffects/uk --targetsheetname maskwearingorder
# nonpi
python script/imputation_reglike.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef
python script/name_data.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname uknonpi --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname uknonpi
python script/gen_data_plot.py --sourcecsv uknonpi --targetexcel data/colleterialeffects/uk --targetsheetname neithertwonpis