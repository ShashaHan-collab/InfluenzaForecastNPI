# northern china
# the estimated average flu level under mitigated travel volume
python script/estimation_forecast.py --lag 52 --region cni --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI
# coefficients for seasonal model
python script/auxiliary_name_file.py --lag 52 --region cni --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname cncoefval --targetfolder result --sourcetype coef
python script/calculate_plot_statistics.py --lag 52 --region cni --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname cnval
python script/auxiliary_gen_excel_data.py --sourcecsv cnval --targetexcel result/colleterialeffects/cn --targetsheetname val
# southern china
python script/estimation_forecast.py --lag 52 --region csib3 --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI
python script/auxiliary_name_file.py --lag 52 --region csib3 --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname cscoefval --targetfolder result --sourcetype coef
python script/calculate_plot_statistics.py --lag 52 --region csib3 --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname csval
python script/auxiliary_gen_excel_data.py --sourcecsv csval --targetexcel result/colleterialeffects/cs --targetsheetname val
# england
python script/estimation_forecast.py --lag 52 --region uk --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202011 --pend 202011 --cov volume,vw --lsa 1e-05 --CI
python script/auxiliary_name_file.py --lag 52 --region uk --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202011 --pend 202011 --cov volume,vw --lsa 1e-05 --CI --targetname ukcoefval --targetfolder result --sourcetype coef
python script/calculate_plot_statistics.py --lag 52 --region uk --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202011 --pend 202011 --cov volume,vw --lsa 1e-05 --CI --targetname ukval
python script/auxiliary_gen_excel_data.py --sourcecsv ukval --targetexcel result/colleterialeffects/uk --targetsheetname val
# usa
python script/estimation_forecast.py --lag 52 --region usa --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202012 --pend 202012 --cov volume,vw --lsa 1e-05 --CI
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202012 --pend 202012 --cov volume,vw --lsa 1e-05 --CI --targetname usacoefval --targetfolder result --sourcetype coef
python script/calculate_plot_statistics.py --lag 52 --region usa --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202012 --pend 202012 --cov volume,vw --lsa 1e-05 --CI --targetname usaval
python script/auxiliary_gen_excel_data.py --sourcecsv usaval --targetexcel result/colleterialeffects/usa --targetsheetname val