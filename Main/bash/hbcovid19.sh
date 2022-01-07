python script/imputation_reglike.py --lag 52 --region hb --tstart 201140 --tend 202003 --pstart 202004 --pend 202012 --cov volume,vw --lsa 1e-05
python script/name_data.py --lag 52 --region hb --tstart 201140 --tend 202003 --pstart 202004 --pend 202012 --cov volume,vw --lsa 1e-05 --targetname hbcoef --targetfolder result --sourcetype coef
# china hubei
python script/imputation_reglike.py --lag 52 --region hbv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/calavgpercent.py --lag 52 --region hbv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname hbnocovid
python script/gen_data_plot.py --sourcecsv hbnocovid --targetexcel data/covid19/hb --targetsheetname nocovid19
python script/name_data.py --lag 52 --region hbv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname hbnocovid --targetfolder data/ci
python script/imputation_reglike.py --lag 52 --region hbv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef hbcoef
python script/calavgpercent.py --lag 52 --region hbv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname hbcovid
python script/gen_data_plot.py --sourcecsv hbcovid --targetexcel data/covid19/hb --targetsheetname covid19
python script/name_data.py --lag 52 --region hbv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname hbcovid --targetfolder data/ci