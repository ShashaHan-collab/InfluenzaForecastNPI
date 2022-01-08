# # china north
# with covid19
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/auxiliary_name_file.py --lag 52 --region cniv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnnocovid --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region cniv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnnocovid
python script/auxiliary_gen_excel_data.py --sourcecsv cnnocovid --targetexcel result/covid19/cn --targetsheetname nocovid19
# without covid19
python script/estimation_forecast.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05  --loadcoef cncoef
python script/auxiliary_name_file.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cncovid --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cncovid
python script/auxiliary_gen_excel_data.py --sourcecsv cncovid --targetexcel result/covid19/cn --targetsheetname covid19
# china south
# with covid19
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/auxiliary_name_file.py --lag 52 --region csiv2b3 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csnocovid --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region csiv2b3 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csnocovid
python script/auxiliary_gen_excel_data.py --sourcecsv csnocovid --targetexcel result/covid19/cs --targetsheetname nocovid19
# without covid19
python script/estimation_forecast.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef cscoef
python script/auxiliary_name_file.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cscovid --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cscovid
python script/auxiliary_gen_excel_data.py --sourcecsv cscovid --targetexcel result/covid19/cs --targetsheetname covid19
# uk
# with covid19
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/auxiliary_name_file.py --lag 52 --region ukv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname uknocovid --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region ukv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname uknocovid
python script/auxiliary_gen_excel_data.py --sourcecsv uknocovid --targetexcel result/covid19/uk --targetsheetname nocovid19
# without covid19
python script/estimation_forecast.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef
python script/auxiliary_name_file.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukcovid --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukcovid
python script/auxiliary_gen_excel_data.py --sourcecsv ukcovid --targetexcel result/covid19/uk --targetsheetname covid19
#usa
# with covid19
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/auxiliary_name_file.py --lag 52 --region usav2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usanocovid --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region usav2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usanocovid
python script/auxiliary_gen_excel_data.py --sourcecsv usanocovid --targetexcel result/covid19/usa --targetsheetname nocovid19
# without covid19
python script/estimation_forecast.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef usacoef
python script/auxiliary_name_file.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05  --targetname usacovid --targetfolder result/ci
python script/calculate_plot_statistics.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usacovid
python script/auxiliary_gen_excel_data.py --sourcecsv usacovid --targetexcel result/covid19/usa --targetsheetname covid19
