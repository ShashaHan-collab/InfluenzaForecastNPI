# china north
# flu level with mitigate domestic travel volume and normal international travel volume
python script/imputation_reglike.py --lag 52 --region cnd1i2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef cncoef
python script/name_data.py --lag 52 --region cnd1i2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnd1i2 --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region cnd1i2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnd1i2
python script/gen_data_plot.py --sourcecsv cnd1i2 --targetexcel data/colleterialeffects/cn --targetsheetname d1i2
# flu level with normal domestic travel volume and mitigate international travel volume
python script/imputation_reglike.py --lag 52 --region cnd2i1 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef cncoef
python script/name_data.py --lag 52 --region cnd2i1 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnd2i1 --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region cnd2i1 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname cnd2i1
python script/gen_data_plot.py --sourcecsv cnd2i1 --targetexcel data/colleterialeffects/cn --targetsheetname d2i1
# china south
# flu level with mitigate domestic travel volume and normal international travel volume
python script/imputation_reglike.py --lag 52 --region csd1i2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef cscoef
python script/name_data.py --lag 52 --region csd1i2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csd1i2 --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region csd1i2 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csd1i2
python script/gen_data_plot.py --sourcecsv csd1i2 --targetexcel data/colleterialeffects/cs --targetsheetname d1i2
# flu level with normal domestic travel volume and mitigate international travel volume
python script/imputation_reglike.py --lag 52 --region csd2i1 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef cscoef
python script/name_data.py --lag 52 --region csd2i1 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csd2i1 --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region csd2i1 --tstart 201140 --tend 202003 --pstart 202004 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname csd2i1
python script/gen_data_plot.py --sourcecsv csd2i1 --targetexcel data/colleterialeffects/cs --targetsheetname d2i1
#usa
# flu level with mitigate domestic travel volume and normal international travel volume
python script/imputation_reglike.py --lag 52 --region usad1i2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef usacoef
python script/name_data.py --lag 52 --region usad1i2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usad1i2 --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region usad1i2 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usad1i2
python script/gen_data_plot.py --sourcecsv usad1i2 --targetexcel data/colleterialeffects/usa --targetsheetname d1i2
# flu level with normal domestic travel volume and mitigate international travel volume
python script/imputation_reglike.py --lag 52 --region usad2i1 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef usacoef
python script/name_data.py --lag 52 --region usad2i1 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usad2i1 --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region usad2i1 --tstart 201140 --tend 202011 --pstart 202012 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname usad2i1
python script/gen_data_plot.py --sourcecsv usad2i1 --targetexcel data/colleterialeffects/usa --targetsheetname d2i1
#uk
# flu level with mitigate domestic travel volume and normal international travel volume
python script/imputation_reglike.py --lag 52 --region ukd1i2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef
python script/name_data.py --lag 52 --region ukd1i2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukd1i2 --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region ukd1i2 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukd1i2
python script/gen_data_plot.py --sourcecsv ukd1i2 --targetexcel data/colleterialeffects/uk --targetsheetname d1i2
# flu level with normal domestic travel volume and mitigate international travel volume
python script/imputation_reglike.py --lag 52 --region ukd2i1 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --loadcoef ukcoef
python script/name_data.py --lag 52 --region ukd2i1 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukd2i1 --targetfolder data/ci
python script/calavgpercent.py --lag 52 --region ukd2i1 --tstart 201140 --tend 202010 --pstart 202011 --pend 202139 --cov volume,vw --lsa 1e-05 --targetname ukd2i1
python script/gen_data_plot.py --sourcecsv ukd2i1 --targetexcel data/colleterialeffects/uk --targetsheetname d2i1