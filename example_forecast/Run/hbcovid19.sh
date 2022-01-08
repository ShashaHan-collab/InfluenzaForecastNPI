python script/estimation_forecast.py --lag 52 --region hb --tstart 201140 --tend 202003 --pstart 202004 --pend 202012 --cov volume,vw --lsa 1e-05
python script/auxiliary_name_file.py --lag 52 --region hb --tstart 201140 --tend 202003 --pstart 202004 --pend 202012 --cov volume,vw --lsa 1e-05 --targetname hbcoef --targetfolder result --sourcetype coef
# china hubei
python script/estimation_forecast.py --lag 52 --region hbv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/calculate_plot_statistics.py --lag 52 --region hbv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname hbnocovid
python script/auxiliary_gen_excel_data.py --sourcecsv hbnocovid --targetexcel preprocessed_data/covid19/hb --targetsheetname nocovid19
python script/auxiliary_name_file.py --lag 52 --region hbv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname hbnocovid --targetfolder preprocessed_data/ci
python script/estimation_forecast.py --lag 52 --region hbv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef hbcoef
python script/calculate_plot_statistics.py --lag 52 --region hbv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname hbcovid
python script/auxiliary_gen_excel_data.py --sourcecsv hbcovid --targetexcel preprocessed_data/covid19/hb --targetsheetname covid19
python script/auxiliary_name_file.py --lag 52 --region hbv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname hbcovid --targetfolder preprocessed_data/ci