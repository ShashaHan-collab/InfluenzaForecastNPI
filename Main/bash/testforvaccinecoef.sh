# this scrpit choose the best L, mu, delta
# first estimate the flu level under mitigate travel volume
python script/imputation_reglike.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05
python script/name_data.py --lag 52 --region cni --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatym --targetfolder data --movetype mean
python script/imputation_reglike.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05
python script/name_data.py --lag 52 --region csib3 --tstart 201140 --tend 202003 --pstart 202004 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatym --targetfolder data --movetype mean
python script/imputation_reglike.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05
python script/name_data.py --lag 52 --region uk --tstart 201140 --tend 202010 --pstart 202011 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatym --targetfolder data --movetype mean
python script/imputation_reglike.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05
python script/name_data.py --lag 52 --region usa --tstart 201140 --tend 202011 --pstart 202012 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatym --targetfolder data --movetype mean
# choose best parameters
python script/choosel_V2.py --ymask cnlog --haty cnihatym --start 202004 --end 202128 --fitintercept --vaccine china --vaccinestart 202051 --model 2 
python script/choosel_V2.py --ymask cslog --haty csihatym --start 202004 --end 202128 --fitintercept --vaccine china --vaccinestart 202051 --model 2 
python script/choosel_V2.py --ymask uklog --haty uk3hatym --start 202030 --end 202128 --fitintercept --vaccine uk --vaccinestart 202050 --model 2 
python script/choosel_V2.py --ymask usa --haty usa3hatym --start 202014 --end 202128 --fitintercept --vaccine usa --vaccinestart 202052 --model 2 

