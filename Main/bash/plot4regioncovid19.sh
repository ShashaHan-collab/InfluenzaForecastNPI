# # china north
# with covid19
python script/imputation_reglike.py --lag 52 --region cniv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/moveandrename.py --lag 52 --region cniv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnnocovid --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region cniv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnnocovid
python script/movetoexcel.py --sourcecsv cnnocovid --targetexcel data/covid19/cn --targetsheetname nocovid19
# without covid19
python script/imputation_reglike.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05  --loadcoef cncoef
python script/moveandrename.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cncovid --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region cniv2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cncovid
python script/movetoexcel.py --sourcecsv cncovid --targetexcel data/covid19/cn --targetsheetname covid19
# china south
# with covid19
python script/imputation_reglike.py --lag 52 --region csiv2b3 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/moveandrename.py --lag 52 --region csiv2b3 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csnocovid --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region csiv2b3 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csnocovid
python script/movetoexcel.py --sourcecsv csnocovid --targetexcel data/covid19/cs --targetsheetname nocovid19
# without covid19
python script/imputation_reglike.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef cscoef
python script/moveandrename.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cscovid --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region csiv2b3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cscovid
python script/movetoexcel.py --sourcecsv cscovid --targetexcel data/covid19/cs --targetsheetname covid19
# uk
# with covid19
python script/imputation_reglike.py --lag 52 --region ukv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/moveandrename.py --lag 52 --region ukv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname uknocovid --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region ukv2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname uknocovid
python script/movetoexcel.py --sourcecsv uknocovid --targetexcel data/covid19/uk --targetsheetname nocovid19
# without covid19
python script/imputation_reglike.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef
python script/moveandrename.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukcovid --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region ukv2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukcovid
python script/movetoexcel.py --sourcecsv ukcovid --targetexcel data/covid19/uk --targetsheetname covid19
#usa
# with covid19
python script/imputation_reglike.py --lag 52 --region usav2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05
python script/moveandrename.py --lag 52 --region usav2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usanocovid --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region usav2 --tstart 201140 --tend 201952 --pstart 202001 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usanocovid
python script/movetoexcel.py --sourcecsv usanocovid --targetexcel data/covid19/usa --targetsheetname nocovid19
# without covid19
python script/imputation_reglike.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef usacoef
python script/moveandrename.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05  --targetname usacovid --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region usav2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usacovid
python script/movetoexcel.py --sourcecsv usacovid --targetexcel data/covid19/usa --targetsheetname covid19
