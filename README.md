# InfluenzaForecastNPI
Time-series Influenza Activity Forecast Model
This model estimates the individuals effects of nonpharmaceutical interventions (mask-wearing intervention and mobility-related nonpharmaceutical interventions) as well as the effects of SARS-CoV2 interference, and forecast the influenza activity under varying scenarios, including the scenarios with different assumptions on nonpharmaceutical interventions. It was used in two recent papers: 

Han, S., Zhang, T., Lyu, Y. et al. The Incoming Influenza Season — China, the United Kingdom, and the United States, 2021–2022. China CDC Weekly 3(39):10.39-1045. (2021). http://weekly.chinacdc.cn/en/article/doi/10.46234/ccdcw2021.253.

Han, S., Zhang, T., Lyu, Y. et al. Influenza’s plummeting during the COVID-19 pandemic: the roles of mask-wearing, mobility change, and SARS-CoV-2 interference. Engineering (2022). Forthcoming.

For an example run of estimation of individual effects of mask-wearing intervention, mobility change, and SARS-CoV2 interference in Northern China, please see "XXX.sh", which uses the processed intermediate dataset "XXX.csv". For an example run of forecast the influenza activity in Northern China in the 2021-2022 influenza season, please see " XXX.sh", which uses the processed intermediate dataset "XXX.csv". For an example run of pre-processing the raw data from Northern China, please see "XXX.sh", which generates the intermediate dataset "XXX.csv".
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
•	Source data forecast: The folder contains all the generated data for reproducing the figures in the paper : Han, S., Zhang, T., Lyu, Y. et al. The Incoming Influenza Season — China, the United Kingdom, and the United States, 2021–2022. China CDC Weekly 3(39):10.39-1045. (2021). http://weekly.chinacdc.cn/en/article/doi/10.46234/ccdcw2021.253.
•	Source plot forecast: The folder contains the plotting code for reproducing the figures in the paper : Han, S., Zhang, T., Lyu, Y. et al. The Incoming Influenza Season — China, the United Kingdom, and the United States, 2021–2022. China CDC Weekly 3(39):10.39-1045. (2021). http://weekly.chinacdc.cn/en/article/doi/10.46234/ccdcw2021.253.


