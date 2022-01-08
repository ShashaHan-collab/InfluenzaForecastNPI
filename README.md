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

# Descriptions of the files [Yan, pls note, the decsriptions inlcude ALL files and the folders that will be displayed under "main". If you think other structure is more appropriate. We need to discuss and reformulate the structure and rewirte the descriptions accordingly.]

•	scripts, raw data, preprocessed data, example estimation, example forecast

example estimation/ Run/.,Source data/,Source plot/.
example forecast/ Run/.,Source data/,Source plot/.

•	scripts/preprocessing.py Python script for the pre-processing operation. The script process with the raw data and generates the intermediate data.

•	scripts/imputation_reglike.py[TODO: change the name to "estimation_forecast.py" ]: Python script for the main operation.[Is my interpretation here correct?] The script estimates the effect of one-week increase in NPIs and forecast seasonal influenza activities using the intermediate data generated from the pre-process. The script generates the XX with respect to the study regions. 

•	scripts/calavgpercent[TODO: change the name to "calculate_plot_statistics.py" ]: Python script to calculate mean, upper and lower bound of XXX[??I am not clear here]. 

•	scripts/calculateCI_v3.py[TODO: change the name to "calculate_report_statistics.py"]: Python script to XXX.

•	scripts/choosel_V2.py[TODO: change the name to "param_mask_reg.py"]: Python script to select the parameters for the second muliple regression model that are used to estimate the effect of a 1-week increase of mask-wearing interventions.


•	scripts/moveandrename.py[TODO: change the name to "auxiliary_name_file.py"?]: Python script to name intermediate data on estimates?? . [I didnot understand. ]

•	scripts/movetoexcel.py[TODO: change the name to "auxiliary_gen_excel_data.py"]: Python script to generate data as csv format for plotting in R.

•	raw data: This folder contains the raw data.

•	proprecessed data: This folder contains the intermediate data after pre-processing. 


•	Example estimation: The folder contains the input, intermediary and output data for an example of running the estimation model. The demo uses the data from the four regions we studied in the paper.

•	Example forecast[Ideally, the two examples need to be separated. But you may combine the two if your time is tight]: The folder contains the input, intermediary and output data for an example of running the forecast model.The demo uses the data from the four regions we studied in the paper.

•	Source data effect: The folder contains all the generated data for reproducing the figures in the paper : Han, S., Zhang, T., Lyu, Y. et al. Influenza’s plummeting during the COVID-19 pandemic: the roles of mask-wearing, mobility change, and SARS-CoV-2 interference. Engineering (2022). Forthcoming.

•	Source plot effect: The folder contains the plotting code for reproducing the figures in the paper : Han, S., Zhang, T., Lyu, Y. et al. Influenza’s plummeting during the COVID-19 pandemic: the roles of mask-wearing, mobility change, and SARS-CoV-2 interference. Engineering (2022). Forthcoming.

•	Source data forecast: The folder contains all the generated data for reproducing the figures in the paper : Han, S., Zhang, T., Lyu, Y. et al. The Incoming Influenza Season — China, the United Kingdom, and the United States, 2021–2022. China CDC Weekly 3(39):10.39-1045. (2021). http://weekly.chinacdc.cn/en/article/doi/10.46234/ccdcw2021.253.

•	Source plot forecast: The folder contains the plotting code for reproducing the figures in the paper : Han, S., Zhang, T., Lyu, Y. et al. The Incoming Influenza Season — China, the United Kingdom, and the United States, 2021–2022. China CDC Weekly 3(39):10.39-1045. (2021). http://weekly.chinacdc.cn/en/article/doi/10.46234/ccdcw2021.253.


