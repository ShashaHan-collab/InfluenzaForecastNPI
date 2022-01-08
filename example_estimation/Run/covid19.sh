# # china north
# with covid19
python script/imputation_reglike.py --lag 52 --region cniv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/name_data.py --lag 52 --region cniv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnnocovid --targetfolder preprocessed_data/ci
python script/calavgpercent.py --lag 52 --region cniv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnnocovid
python script/gen_data_plot.py --sourcecsv cnnocovid --targetexcel preprocessed_data/covid19/cn --targetsheetname nocovid19
# without covid19
python script/imputation_reglike.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05  --loadcoef cncoef
python script/name_data.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cncovid --targetfolder preprocessed_data/ci
python script/calavgpercent.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cncovid
python script/gen_data_plot.py --sourcecsv cncovid --targetexcel preprocessed_data/covid19/cn --targetsheetname covid19
# china south
# with covid19
python script/imputation_reglike.py --lag 52 --region csiv2b3 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/name_data.py --lag 52 --region csiv2b3 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csnocovid --targetfolder preprocessed_data/ci
python script/calavgpercent.py --lag 52 --region csiv2b3 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csnocovid
python script/gen_data_plot.py --sourcecsv csnocovid --targetexcel preprocessed_data/covid19/cs --targetsheetname nocovid19
# without covid19
python script/imputation_reglike.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef cscoef
python script/name_data.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cscovid --targetfolder preprocessed_data/ci
python script/calavgpercent.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cscovid
python script/gen_data_plot.py --sourcecsv cscovid --targetexcel preprocessed_data/covid19/cs --targetsheetname covid19
# uk
# with covid19
python script/imputation_reglike.py --lag 52 --region ukv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/name_data.py --lag 52 --region ukv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname uknocovid --targetfolder preprocessed_data/ci
python script/calavgpercent.py --lag 52 --region ukv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname uknocovid
python script/gen_data_plot.py --sourcecsv uknocovid --targetexcel preprocessed_data/covid19/uk --targetsheetname nocovid19
# without covid19
python script/imputation_reglike.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef
python script/name_data.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukcovid --targetfolder preprocessed_data/ci
python script/calavgpercent.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukcovid
python script/gen_data_plot.py --sourcecsv ukcovid --targetexcel preprocessed_data/covid19/uk --targetsheetname covid19
#usa
# with covid19
python script/imputation_reglike.py --lag 52 --region usav2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/name_data.py --lag 52 --region usav2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usanocovid --targetfolder preprocessed_data/ci
python script/calavgpercent.py --lag 52 --region usav2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usanocovid
python script/gen_data_plot.py --sourcecsv usanocovid --targetexcel preprocessed_data/covid19/usa --targetsheetname nocovid19
# without covid19
python script/imputation_reglike.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef usacoef
python script/name_data.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05  --targetname usacovid --targetfolder preprocessed_data/ci
python script/calavgpercent.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usacovid
python script/gen_data_plot.py --sourcecsv usacovid --targetexcel preprocessed_data/covid19/usa --targetsheetname covid19
