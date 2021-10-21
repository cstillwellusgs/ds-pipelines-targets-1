# pipelines-targets-1
# Charles Stillwell
# Practice writing and implementing user-defined functions

# Define variables -------------------------------------------------------------

################################################################################
################################################################################
fetch_sb_id <- '5d925066e4b0c4f70d0d0599'                 # ScienceBase ID
fetch_item_name <- 'me_RMSE.csv'                          # Item identifier
fetch_out_dir <- "1_fetch/out"                            # Output directory
fetch_out_file <- "mendota_data.csv"                      # Output file name

prep_exper <- "similar"                                   # Experiment type: 
                                                          # similar/season/year

plot_out_dir <- "3_plot/out"                              # Output directory
plot_out_fig <- "figure_1.png"                            # Output file name
plot_out_data <- "data_plot.csv"                          # Output file name
plot_model_order <- c('pgdl', 'dl', 'pb')                 # Order in legend
plot_model_names <- c("Process-Guided Deep Learning",     # Names in legend
                      "Deep Learning",
                      "Process Based")
plot_colors <- c('#7570b3', '#d95f02', '#1b9e77')         # Group colors (order)
plot_pt_size <- 6                                         # Point size
plot_pt_shape <- c(18, 15, 16)                            # Point shapes (order)
plot_pt_dodge <- 0.075                                    # Point dodge width
plot_path_type <- "dashed"                                # Path linetype
plot_range_thick <- 1                                     # Range line thickness
plot_x_title <- "Training Temperature Profiles (#)"       # X axis title
plot_y_title <- "Test RMSE (°C)"                          # Y axis title
plot_width_in <- 8                                        # Plot width (inches)
plot_height_in <- 10                                      # Plot height (inches)
plot_res <- 200                                           # Plot resolution

summary_out_dir <- "4_summary/out"                        # Output directory
summary_out_file <- "summary.txt"                         # Output text file
################################################################################
################################################################################

# Load libraries ---------------------------------------------------------------
library(sbtools)
library(tidyverse)
library(whisker)

# Read in functions ------------------------------------------------------------
source("1_fetch/src/fetch_data.R")
source("2_prep/src/prep_data.R")
source("3_plot/src/plot_data.R")
source("4_summary/src/summarise_data.R")

# Create sub-directories for outputs -------------------------------------------
dir.create("1_fetch/out", showWarnings = FALSE)
dir.create("2_prep/out", showWarnings = FALSE)
dir.create("3_plot/out", showWarnings = FALSE)
dir.create("4_summary/out", showWarnings = FALSE)

# Fetch data -------------------------------------------------------------------
fetch_data(fetch_sb_id, fetch_item_name, fetch_out_dir, fetch_out_file)

# Prepare data for plotting ----------------------------------------------------
prep_data(data_raw, prep_exper)

# Plot and save data -----------------------------------------------------------
plot_data(data_plot, plot_out_dir, plot_out_fig, plot_out_data,
          plot_model_order, plot_model_names, plot_colors, 
          plot_pt_size, plot_pt_shape, plot_pt_dodge, 
          plot_path_type, plot_range_thick, 
          plot_x_title, plot_y_title, 
          plot_width_in, plot_height_in, plot_res)

# Summarize findings -----------------------------------------------------------
summarise_data(data_plot, summary_out_dir, summary_out_file)