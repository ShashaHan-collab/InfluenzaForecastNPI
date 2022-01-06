# InfluenzaForecastNPI
Time-series Influenza Activity Forecast Model
This model estimates the individuals effects of nonpharmaceutical interventions (mask-wearing intervention and mobility-related nonpharmaceutical interventions) as well as the effects of SARS-CoV2 interference, and forecast the influenza activity under varying scenarios, including the scenarios with different assumptions on nonpharmaceutical interventions. It was used in two recent papers: 

Han, S., Zhang, T., Lyu, Y. et al. The Incoming Influenza Season — China, the United Kingdom, and the United States, 2021–2022. China CDC Weekly 3(39):10.39-1045. (2021). http://weekly.chinacdc.cn/en/article/doi/10.46234/ccdcw2021.253.

Han, S., Zhang, T., Lyu, Y. et al. Influenza’s plummeting during the COVID-19 pandemic: the roles of mask-wearing, mobility change, and SARS-CoV-2 interference. Engineering (2022). Forthcoming.

For an example run of estimation of individual effects of mask-wearing intervention, mobility change, and SARS-CoV2 interference in the four regions that we studied in the paper, including nother China, southern China, England and the United States, please see "XXX.sh", which uses the processed intermediate dataset "XXX.csv". For an example run of forecast the influenza activity in the four regions in the 2021-2022 influenza season, please see " XXX.sh", which uses the processed intermediate dataset "XXX.csv". For an example run of pre-processing the raw data from the four regions, please see "XXX.sh", which generates the intermediate dataset "XXX.csv".
# Overall model
This model first estimates the individual effects of NPIs. It consists of two self-correcting regularized multiple regression models, both of which are dynamically trained and regularized using the LASSO method. Estimated effects were then used to predict the influenza activity in the future.
# Prerequisites
## Prerequisite software
•	Python version 3.6.13.

•	R version 4.0.3.

## Prerequisite for third-party packages
•	scikit-learn 0.24.2 (Python)

•	tidyverse(R)

•	glue(R)

•	xlsx(R)

•	cowplot(R)

•	scales(R)
# Descriptions of the files
•	preprocessing.py Python script for the pre-processing operation. The script process with the raw data and generates the intermediate data.

•	utils.py Python script for the main operation. The script optimize allocation over the full period using the intermediate data generated from the pre-process. The script generates the XX with respect to the study region. 

•	calavgpercent.py: Python script to XXX.

•	calculateCI_v3.py: Python script to XXX.

•	choosel_V2.py: Python script to XXX.

•	imputation_reglike.py: Python script to XXX.

•	moveandrename.py: Python script to XXX.

•	movetoexcel.py: Python script to XXX.


•	Example estimation: The folder contains the input, intermediary and output data for an example of running the estimation model. The demo uses the data from the four regions we studied in the paper.

•	Example forecast: The folder contains the input, intermediary and output data for an example of running the forecast model.The demo uses the data from the four regions we studied in the paper.

•	Source data effect: The folder contains all the generated data for reproducing the figures in the paper : Han, S., Zhang, T., Lyu, Y. et al. Influenza’s plummeting during the COVID-19 pandemic: the roles of mask-wearing, mobility change, and SARS-CoV-2 interference. Engineering (2022). Forthcoming.

•	Source plot effect: The folder contains the plotting code for reproducing the figures in the paper : Han, S., Zhang, T., Lyu, Y. et al. Influenza’s plummeting during the COVID-19 pandemic: the roles of mask-wearing, mobility change, and SARS-CoV-2 interference. Engineering (2022). Forthcoming.

•	Source data forecast: The folder contains all the generated data for reproducing the figures in the paper : Han, S., Zhang, T., Lyu, Y. et al. The Incoming Influenza Season — China, the United Kingdom, and the United States, 2021–2022. China CDC Weekly 3(39):10.39-1045. (2021). http://weekly.chinacdc.cn/en/article/doi/10.46234/ccdcw2021.253.

•	Source plot forecast: The folder contains the plotting code for reproducing the figures in the paper : Han, S., Zhang, T., Lyu, Y. et al. The Incoming Influenza Season — China, the United Kingdom, and the United States, 2021–2022. China CDC Weekly 3(39):10.39-1045. (2021). http://weekly.chinacdc.cn/en/article/doi/10.46234/ccdcw2021.253.


