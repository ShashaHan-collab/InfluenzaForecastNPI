# northern china
# # no
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a0 --noint --cpltp 202140  --loadcoef cncoefmask
python script/name_data.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a0 --noint --cpltp 202140 --targetname cn21nomask --targetfolder preprocessed_data/ci
python script/calavgpercent.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 13 --yam cnihatyfmsn --model lr --cpl a0 --noint --cpltp 202140 --targetname cn21nomask
python script/gen_data_plot.py --sourcecsv cn21nomask --targetexcel preprocessed_data/future/cn --targetsheetname no
# southern china
# # no
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a0 --noint --cpltp 202140  --loadcoef cscoefmask
python script/name_data.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a0 --noint --cpltp 202140 --targetname cs21nomask --targetfolder preprocessed_data/ci
python script/calavgpercent.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 11 --yam csihatyfmsn --model lr --cpl a0 --noint --cpltp 202140 --targetname cs21nomask
python script/gen_data_plot.py --sourcecsv cs21nomask --targetexcel preprocessed_data/future/cs --targetsheetname no
# uk
# no
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a0 --noint --cpltp 202140  --loadcoef ukcoefmask
python script/name_data.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a0 --noint --cpltp 202140 --targetname uk21nomask --targetfolder preprocessed_data/ci
python script/calavgpercent.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 24 --yam uk3hatyfmsn --model lr --cpl a0 --noint --cpltp 202140 --targetname uk21nomask
python script/gen_data_plot.py --sourcecsv uk21nomask --targetexcel preprocessed_data/future/uk --targetsheetname no
# usa
# no
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a0 --noint --cpltp 202140  --loadcoef usacoefmask
python script/name_data.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a0 --noint --cpltp 202140  --targetname usa21nomask --targetfolder preprocessed_data/ci
python script/calavgpercent.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202128 --pend 202252 --ctype new --clag 35 --yam usa3hatyfmsn --model lr --cpl a0 --noint --cpltp 202140  --targetname usa21nomask
python script/gen_data_plot.py --sourcecsv usa21nomask --targetexcel preprocessed_data/future/usa --targetsheetname no