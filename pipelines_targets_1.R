# Load libraries
library(sbtools)
library(tidyverse)
library(whisker)

# Read in functions
source("1_fetch/src/fetch_data.R")
source("2_process/src/process_data.R")
source("3_visualize/src/plot_data.R")

# Fetch data
fetch_data(sb_id = '5d925066e4b0c4f70d0d0599', item_name = 'me_RMSE.csv', 
           out_dir = "1_fetch/out/", out_file = "mendota_data.csv")
