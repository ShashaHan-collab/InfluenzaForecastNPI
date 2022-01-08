# northern china
# the estimated average flu level under mitigated travel volume
python script/estimation_forecast.py --lag 52 --region cni --tstart 201140 --tend 201752 --vstart 201801 --vend 201852 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI
# coefficients for seasonal model
python script/auxiliary_name_file.py --lag 52 --region cni --tstart 201140 --tend 201752 --vstart 201801 --vend 201852 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname cncoefval --targetfolder result --sourcetype coef
python script/calculate_plot_statistics.py --lag 52 --region cni --tstart 201140 --tend 201752 --vstart 201801 --vend 201852 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname cnval18
python script/auxiliary_gen_excel_data.py --sourcecsv cnval18 --targetexcel preprocessed_data/colleterialeffects/cn --targetsheetname val18
# southern china
python script/estimation_forecast.py --lag 52 --region csib3 --tstart 201140 --tend 201752 --vstart 201801 --vend 201852 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI
python script/auxiliary_name_file.py --lag 52 --region csib3 --tstart 201140 --tend 201752 --vstart 201801 --vend 201852 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname cscoefval --targetfolder result --sourcetype coef
python script/calculate_plot_statistics.py --lag 52 --region csib3 --tstart 201140 --tend 201752 --vstart 201801 --vend 201852 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname csval18
python script/auxiliary_gen_excel_data.py --sourcecsv csval18 --targetexcel preprocessed_data/colleterialeffects/cs --targetsheetname val18
# uk
python script/estimation_forecast.py --lag 52 --region uk --tstart 201140 --tend 201752 --vstart 201801 --vend 201852 --pstart 202011 --pend 202011 --cov volume,vw --lsa 1e-05 --CI
python script/auxiliary_name_file.py --lag 52 --region uk --tstart 201140 --tend 201752 --vstart 201801 --vend 201852 --pstart 202011 --pend 202011 --cov volume,vw --lsa 1e-05 --CI --targetname ukcoefval --targetfolder result --sourcetype coef
python script/calculate_plot_statistics.py --lag 52 --region uk --tstart 201140 --tend 201752 --vstart 201801 --vend 201852 --pstart 202011 --pend 202011 --cov volume,vw --lsa 1e-05 --CI --targetname ukval18
python script/auxiliary_gen_excel_data.py --sourcecsv ukval18 --targetexcel preprocessed_data/colleterialeffects/uk --targetsheetname val18
# usa
python script/estimation_forecast.py --lag 52 --region usa --tstart 201140 --tend 201752 --vstart 201801 --vend 201852 --pstart 202012 --pend 202012 --cov volume,vw --lsa 1e-05 --CI
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 201140 --tend 201752 --vstart 201801 --vend 201852 --pstart 202012 --pend 202012 --cov volume,vw --lsa 1e-05 --CI --targetname usacoefval --targetfolder result --sourcetype coef
python script/calculate_plot_statistics.py --lag 52 --region usa --tstart 201140 --tend 201752 --vstart 201801 --vend 201852 --pstart 202012 --pend 202012 --cov volume,vw --lsa 1e-05 --CI --targetname usaval18
python script/auxiliary_gen_excel_data.py --sourcecsv usaval18 --targetexcel preprocessed_data/colleterialeffects/usa --targetsheetname val18