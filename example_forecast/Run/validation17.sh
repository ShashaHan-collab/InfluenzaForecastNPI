# northern china
# the estimated average flu level under mitigated travel volume
python script/estimation_forecast.py --lag 52 --region cni --tstart 201140 --tend 201652 --vstart 201701 --vend 201752 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI
# coefficients for seasonal model
python script/auxiliary_name_file.py --lag 52 --region cni --tstart 201140 --tend 201652 --vstart 201701 --vend 201752 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname cncoefval --targetfolder result --sourcetype coef
python script/calculate_plot_statistics.py --lag 52 --region cni --tstart 201140 --tend 201652 --vstart 201701 --vend 201752 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname cnval17
python script/auxiliary_gen_excel_data.py --sourcecsv cnval17 --targetexcel preprocessed_data/colleterialeffects/cn --targetsheetname val17
# southern china
python script/estimation_forecast.py --lag 52 --region csib3 --tstart 201140 --tend 201652 --vstart 201701 --vend 201752 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI
python script/auxiliary_name_file.py --lag 52 --region csib3 --tstart 201140 --tend 201652 --vstart 201701 --vend 201752 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname cscoefval --targetfolder result --sourcetype coef
python script/calculate_plot_statistics.py --lag 52 --region csib3 --tstart 201140 --tend 201652 --vstart 201701 --vend 201752 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname csval17
python script/auxiliary_gen_excel_data.py --sourcecsv csval17 --targetexcel preprocessed_data/colleterialeffects/cs --targetsheetname val17
# uk
python script/estimation_forecast.py --lag 52 --region uk --tstart 201140 --tend 201652 --vstart 201701 --vend 201752 --pstart 202011 --pend 202011 --cov volume,vw --lsa 1e-05 --CI
python script/auxiliary_name_file.py --lag 52 --region uk --tstart 201140 --tend 201652 --vstart 201701 --vend 201752 --pstart 202011 --pend 202011 --cov volume,vw --lsa 1e-05 --CI --targetname ukcoefval --targetfolder result --sourcetype coef
python script/calculate_plot_statistics.py --lag 52 --region uk --tstart 201140 --tend 201652 --vstart 201701 --vend 201752 --pstart 202011 --pend 202011 --cov volume,vw --lsa 1e-05 --CI --targetname ukval17
python script/auxiliary_gen_excel_data.py --sourcecsv ukval17 --targetexcel preprocessed_data/colleterialeffects/uk --targetsheetname val17
# usa
python script/estimation_forecast.py --lag 52 --region usa --tstart 201140 --tend 201652 --vstart 201701 --vend 201752 --pstart 202012 --pend 202012 --cov volume,vw --lsa 1e-05 --CI
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 201140 --tend 201652 --vstart 201701 --vend 201752 --pstart 202012 --pend 202012 --cov volume,vw --lsa 1e-05 --CI --targetname usacoefval --targetfolder result --sourcetype coef
python script/calculate_plot_statistics.py --lag 52 --region usa --tstart 201140 --tend 201652 --vstart 201701 --vend 201752 --pstart 202012 --pend 202012 --cov volume,vw --lsa 1e-05 --CI --targetname usaval17
python script/auxiliary_gen_excel_data.py --sourcecsv usaval17 --targetexcel preprocessed_data/colleterialeffects/usa --targetsheetname val17