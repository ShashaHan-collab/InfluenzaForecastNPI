# northern china
# the estimated average flu level under mitigated travel volume
python script/imputation_reglike.py --lag 52 --region cni --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI
# coefficients for seasonal model
python script/name_data.py --lag 52 --region cni --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname cncoefval --targetfolder result --sourcetype coef
python script/calavgpercent.py --lag 52 --region cni --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname cnval
python script/gen_data_plot.py --sourcecsv cnval --targetexcel preprocessed_data/colleterialeffects/cn --targetsheetname val
# southern china
python script/imputation_reglike.py --lag 52 --region csib3 --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI
python script/name_data.py --lag 52 --region csib3 --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname cscoefval --targetfolder result --sourcetype coef
python script/calavgpercent.py --lag 52 --region csib3 --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202004 --pend 202004 --cov volume,vw --lsa 1e-05 --CI --targetname csval
python script/gen_data_plot.py --sourcecsv csval --targetexcel preprocessed_data/colleterialeffects/cs --targetsheetname val
# uk
python script/imputation_reglike.py --lag 52 --region uk --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202011 --pend 202011 --cov volume,vw --lsa 1e-05 --CI
python script/name_data.py --lag 52 --region uk --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202011 --pend 202011 --cov volume,vw --lsa 1e-05 --CI --targetname ukcoefval --targetfolder result --sourcetype coef
python script/calavgpercent.py --lag 52 --region uk --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202011 --pend 202011 --cov volume,vw --lsa 1e-05 --CI --targetname ukval
python script/gen_data_plot.py --sourcecsv ukval --targetexcel preprocessed_data/colleterialeffects/uk --targetsheetname val
# usa
python script/imputation_reglike.py --lag 52 --region usa --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202012 --pend 202012 --cov volume,vw --lsa 1e-05 --CI
python script/name_data.py --lag 52 --region usa --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202012 --pend 202012 --cov volume,vw --lsa 1e-05 --CI --targetname usacoefval --targetfolder result --sourcetype coef
python script/calavgpercent.py --lag 52 --region usa --tstart 201140 --tend 201852 --vstart 201901 --vend 201952 --pstart 202012 --pend 202012 --cov volume,vw --lsa 1e-05 --CI --targetname usaval
python script/gen_data_plot.py --sourcecsv usaval --targetexcel preprocessed_data/colleterialeffects/usa --targetsheetname val