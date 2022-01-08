# china north
python script/estimation_forecast.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 13 --yam cnihatym --model lr
python script/auxiliary_name_file.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 13 --yam cnihatym --model lr --targetname cntau --targetfolder result/ci --sourcetype coef
# china south
python script/estimation_forecast.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 11 --yam csihatym --model lr
python script/auxiliary_name_file.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 11 --yam csihatym --model lr --targetname cstau --targetfolder result/ci --sourcetype coef
# england
python script/estimation_forecast.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 24 --yam uk3hatym --model lr
python script/auxiliary_name_file.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 24 --yam uk3hatym --model lr --targetname uktau --targetfolder result/ci --sourcetype coef
# usa
python script/estimation_forecast.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 35 --yam usa3hatym --model lr
python script/auxiliary_name_file.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202130 --ctype new --clag 35 --yam usa3hatym --model lr --targetname usatau --targetfolder result/ci --sourcetype coef