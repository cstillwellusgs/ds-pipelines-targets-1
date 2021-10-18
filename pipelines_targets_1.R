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
           out_dir = "1_fetch/out", out_file = "mendota_data.csv")

# Read data
data_raw <- read_csv("1_fetch/out/mendota_data.csv", col_types = 'iccd')

# Prepare data for plotting
data_to_plot <- 
  data_4plot(data_raw, colors = c('#1b9e77', '#d95f02', '#7570b3'), 
             symbols = c(21, 22, 23))
