# plot seasonal model fit
# northern china
python script/estimation_forecast.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --CI
python script/calculate_plot_statistics.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --CI --targetname cnhatyci
python script/auxiliary_gen_excel_data.py --sourcecsv cnhatyci --targetexcel result/colleterialeffects/cn --targetsheetname hatyci
# southern china
python script/estimation_forecast.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --CI
python script/calculate_plot_statistics.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --CI --targetname cshatyci
python script/auxiliary_gen_excel_data.py --sourcecsv cshatyci --targetexcel result/colleterialeffects/cs --targetsheetname hatyci
# uk
python script/estimation_forecast.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --CI
python script/calculate_plot_statistics.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --CI --targetname ukhatyci
python script/auxiliary_gen_excel_data.py --sourcecsv ukhatyci --targetexcel result/colleterialeffects/uk --targetsheetname hatyci
# usa
python script/estimation_forecast.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --CI
python script/calculate_plot_statistics.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --CI --targetname usahatyci
python script/auxiliary_gen_excel_data.py --sourcecsv usahatyci --targetexcel result/colleterialeffects/usa --targetsheetname hatyci
# plot mask model fit
# northern china
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 13 --yam cnihatym --model lr --CI
python script/calculate_plot_statistics.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 13 --yam cnihatym --model lr --CI --targetname cnlrci
python script/auxiliary_gen_excel_data.py --sourcecsv cnlrci --targetexcel result/colleterialeffects/cn --targetsheetname lrci
# southern china
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 11 --yam csihatym --model lr --CI
python script/calculate_plot_statistics.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 11 --yam csihatym --model lr --CI --targetname cslrci
python script/auxiliary_gen_excel_data.py --sourcecsv cslrci --targetexcel result/colleterialeffects/cs --targetsheetname lrci
# uk
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 24 --yam uk3hatym --model lr --CI
python script/calculate_plot_statistics.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 24 --yam uk3hatym --model lr --CI --targetname uklrci
python script/auxiliary_gen_excel_data.py --sourcecsv uklrci --targetexcel result/colleterialeffects/uk --targetsheetname lrci
# usa
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 35 --yam usa3hatym --model lr --CI
python script/calculate_plot_statistics.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202128 --pend 202130 --ctype new --clag 35 --yam usa3hatym --model lr --CI --targetname usalrci
python script/auxiliary_gen_excel_data.py --sourcecsv usalrci --targetexcel result/colleterialeffects/usa --targetsheetname lrci
