# china north
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 13 --yam cnihatym --model lr
python script/moveandrename.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 13 --yam cnihatym --model lr --targetname cntau --targetfolder data/ci --sourcetype coef
# china south
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 11 --yam csihatym --model lr
python script/moveandrename.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 11 --yam csihatym --model lr --targetname cstau --targetfolder data/ci --sourcetype coef
# uk
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 24 --yam uk3hatym --model lr
python script/moveandrename.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 24 --yam uk3hatym --model lr --targetname uktau --targetfolder data/ci --sourcetype coef
# usa
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 35 --yam usa3hatym --model lr
python script/moveandrename.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 35 --yam usa3hatym --model lr --targetname usatau --targetfolder data/ci --sourcetype coef