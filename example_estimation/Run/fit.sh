# plot seasonal model fit
# northern china
python script/imputation_reglike.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --CI
python script/calavgpercent.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --CI --targetname cnhatyci
python script/gen_data_plot.py --sourcecsv cnhatyci --targetexcel preprocessed_data/colleterialeffects/cn --targetsheetname hatyci
# southern china
python script/imputation_reglike.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --CI
python script/calavgpercent.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --CI --targetname cshatyci
python script/gen_data_plot.py --sourcecsv cshatyci --targetexcel preprocessed_data/colleterialeffects/cs --targetsheetname hatyci
# uk
python script/imputation_reglike.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --CI
python script/calavgpercent.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --CI --targetname ukhatyci
python script/gen_data_plot.py --sourcecsv ukhatyci --targetexcel preprocessed_data/colleterialeffects/uk --targetsheetname hatyci
# usa
python script/imputation_reglike.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --CI
python script/calavgpercent.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --CI --targetname usahatyci
python script/gen_data_plot.py --sourcecsv usahatyci --targetexcel preprocessed_data/colleterialeffects/usa --targetsheetname hatyci
# plot mask model fit
# northern china
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 13 --yam cnihatym --model lr --CI
python script/calavgpercent.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 13 --yam cnihatym --model lr --CI --targetname cnlrci
python script/gen_data_plot.py --sourcecsv cnlrci --targetexcel preprocessed_data/colleterialeffects/cn --targetsheetname lrci
# southern china
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 11 --yam csihatym --model lr --CI
python script/calavgpercent.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 11 --yam csihatym --model lr --CI --targetname cslrci
python script/gen_data_plot.py --sourcecsv cslrci --targetexcel preprocessed_data/colleterialeffects/cs --targetsheetname lrci
# uk
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 24 --yam uk3hatym --model lr --CI
python script/calavgpercent.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 24 --yam uk3hatym --model lr --CI --targetname uklrci
python script/gen_data_plot.py --sourcecsv uklrci --targetexcel preprocessed_data/colleterialeffects/uk --targetsheetname lrci
# usa
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 35 --yam usa3hatym --model lr --CI
python script/calavgpercent.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 35 --yam usa3hatym --model lr --CI --targetname usalrci
python script/gen_data_plot.py --sourcecsv usalrci --targetexcel preprocessed_data/colleterialeffects/usa --targetsheetname lrci
