# domestic plot
# northern china
# prepare rawdata under different volume, 3v means 30% of normal volume, mv means 50% of normal volume and 7v means 70% of normal volume
python script/imputation_reglike.py --lag 52 --region cni3vni --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05  --loadcoef cncoef --loadpositiverate cnihatym
python script/moveandrename.py --lag 52 --region cni3vni --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihaty3vni
python script/imputation_reglike.py --lag 52 --region cni7vni --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05  --loadcoef cncoef --loadpositiverate cnihatym
python script/moveandrename.py --lag 52 --region cni7vni --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihaty7vni
python script/imputation_reglike.py --lag 52 --region cnimvni --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05  --loadcoef cncoef --loadpositiverate cnihatym
python script/moveandrename.py --lag 52 --region cnimvni --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname cnihatymvni
# normal international mitigate domestic flu level with the effect of previous mask wearing
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihaty3vni --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cncoefmask
python script/calavgpercent.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihaty3vni --model lr --cpl a0 --noint --cpltp 202140 --targetname cn3vni
python script/movetoexcel.py --sourcecsv cn3vni --targetexcel data/future/cn --targetsheetname 3vni
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihaty7vni --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cncoefmask
python script/calavgpercent.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihaty7vni --model lr --cpl a0 --noint --cpltp 202140 --targetname cn7vni
python script/movetoexcel.py --sourcecsv cn7vni --targetexcel data/future/cn --targetsheetname 7vni
python script/imputation_reglike.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatymvni --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cncoefmask
python script/calavgpercent.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatymvni --model lr --cpl a0 --noint --cpltp 202140 --targetname cnmvni
python script/movetoexcel.py --sourcecsv cnmvni --targetexcel data/future/cn --targetsheetname mvni
python script/moveandrename.py --lag 52 --region cnlog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 13 --yam cnihatymvni --model lr --cpl a0 --noint --cpltp 202140 --targetname cn21mv --targetfolder data/ci
# southern china
# prepare data
python script/imputation_reglike.py --lag 52 --region csi3vni --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cscoef --loadpositiverate csihatym
python script/moveandrename.py --lag 52 --region csi3vni --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihaty3vni
python script/imputation_reglike.py --lag 52 --region csi7vni --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cscoef --loadpositiverate csihatym
python script/moveandrename.py --lag 52 --region csi7vni --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihaty7vni
python script/imputation_reglike.py --lag 52 --region csib3mvni --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef cscoef --loadpositiverate csihatym
python script/moveandrename.py --lag 52 --region csib3mvni --tstart 201140 --tend 202003 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname csihatymvni
# normal international mitigate domestic 
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihaty3vni --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cscoefmask
python script/calavgpercent.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihaty3vni --model lr --cpl a0 --noint --cpltp 202140 --targetname cs3vni
python script/movetoexcel.py --sourcecsv cs3vni --targetexcel data/future/cs --targetsheetname 3vni
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihaty7vni --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cscoefmask
python script/calavgpercent.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihaty7vni --model lr --cpl a0 --noint --cpltp 202140 --targetname cs7vni
python script/movetoexcel.py --sourcecsv cs7vni --targetexcel data/future/cs --targetsheetname 7vni
python script/imputation_reglike.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatymvni --model lr --cpl a0 --noint --cpltp 202140 --loadcoef cscoefmask
python script/calavgpercent.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatymvni --model lr --cpl a0 --noint --cpltp 202140 --targetname csmvni
python script/movetoexcel.py --sourcecsv csmvni --targetexcel data/future/cs --targetsheetname mvni
python script/moveandrename.py --lag 52 --region cslog --tstart 202004 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 11 --yam csihatymvni --model lr --cpl a0 --noint --cpltp 202140 --targetname cs21mv --targetfolder data/ci
# uk
# prepare data
python script/imputation_reglike.py --lag 52 --region uk3vni --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef --loadpositiverate uk3hatym
python script/moveandrename.py --lag 52 --region uk3vni --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3haty3vni
python script/imputation_reglike.py --lag 52 --region uk7vni --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef --loadpositiverate uk3hatym
python script/moveandrename.py --lag 52 --region uk7vni --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3haty7vni
python script/imputation_reglike.py --lag 52 --region ukmvni --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef --loadpositiverate uk3hatym
python script/moveandrename.py --lag 52 --region ukmvni --tstart 201140 --tend 202010 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname uk3hatymvni
# normal international mitigate domestic 
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3haty3vni --model lr --cpl a0 --noint --cpltp 202140 --loadcoef ukcoefmask
python script/calavgpercent.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3haty3vni --model lr --cpl a0 --noint --cpltp 202140 --targetname ruk3vni
python script/movetoexcel.py --sourcecsv ruk3vni --targetexcel data/future/uk --targetsheetname 3vni
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3haty7vni --model lr --cpl a0 --noint --cpltp 202140 --loadcoef ukcoefmask
python script/calavgpercent.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3haty7vni --model lr --cpl a0 --noint --cpltp 202140 --targetname ruk7vni
python script/movetoexcel.py --sourcecsv ruk7vni --targetexcel data/future/uk --targetsheetname 7vni
python script/imputation_reglike.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatymvni --model lr --cpl a0 --noint --cpltp 202140  --loadcoef ukcoefmask
python script/calavgpercent.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatymvni --model lr --cpl a0 --noint --cpltp 202140  --targetname rukmvni
python script/movetoexcel.py --sourcecsv rukmvni --targetexcel data/future/uk --targetsheetname mvni
python script/moveandrename.py --lag 52 --region uklog --tstart 202030 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 24 --yam uk3hatymvni --model lr --cpl a0 --noint --cpltp 202140 --targetname uk21mv --targetfolder data/ci
# usa
# prepare data
python script/imputation_reglike.py --lag 52 --region usa3vni --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef usacoef --loadpositiverate usa3hatym
python script/moveandrename.py --lag 52 --region usa3vni --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3haty3vni
python script/imputation_reglike.py --lag 52 --region usa7vni --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef usacoef --loadpositiverate usa3hatym
python script/moveandrename.py --lag 52 --region usa7vni --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3haty7vni
python script/imputation_reglike.py --lag 52 --region usamvni --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --loadcoef usacoef --loadpositiverate usa3hatym
python script/moveandrename.py --lag 52 --region usamvni --tstart 201140 --tend 202011 --pstart 202140 --pend 202252 --cov volume,vw --lsa 1e-05 --targetname usa3hatymvni
# normal international mitigate domestic 
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3haty3vni --model lr --cpl a0 --noint --cpltp 202140  --loadcoef usacoefmask
python script/calavgpercent.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3haty3vni --model lr --cpl a0 --noint --cpltp 202140 --targetname rusa3vni
python script/movetoexcel.py --sourcecsv rusa3vni --targetexcel data/future/usa --targetsheetname 3vni
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3haty7vni --model lr --cpl a0 --noint --cpltp 202140  --loadcoef usacoefmask
python script/calavgpercent.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3haty7vni --model lr --cpl a0 --noint --cpltp 202140 --targetname rusa7vni
python script/movetoexcel.py --sourcecsv rusa7vni --targetexcel data/future/usa --targetsheetname 7vni
python script/imputation_reglike.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatymvni --model lr --cpl a0 --noint --cpltp 202140  --loadcoef usacoefmask
python script/calavgpercent.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatymvni --model lr --cpl a0 --noint --cpltp 202140 --targetname rusamvni
python script/movetoexcel.py --sourcecsv rusamvni --targetexcel data/future/usa --targetsheetname mvni
python script/moveandrename.py --lag 52 --region usa --tstart 202014 --tend 202128 --pstart 202129 --pend 202252 --ctype new --clag 35 --yam usa3hatymvni --model lr --cpl a0 --noint --cpltp 202140 --targetname usa21mv --targetfolder data/ci