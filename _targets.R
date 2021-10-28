library(targets)
source("1_fetch/src/fetch_data.R")
source("2_prep/src/prep_data.R")
source("3_plot/src/plot_data.R")
source("4_summary/src/summarise_data.R")
dir.create("1_fetch/out/", showWarnings = FALSE)
dir.create("2_prep/out/", showWarnings = FALSE)
dir.create("3_plot/out/", showWarnings = FALSE)
dir.create("4_summary/out/", showWarnings = FALSE)
tar_option_set(packages = c("tidyverse", "sbtools"))

list(
  # Get the data from ScienceBase
  tar_target(
    data_raw_csv,
    fetch_data(fetch_sb_id = '5d925066e4b0c4f70d0d0599' , 
               fetch_item_name = 'me_RMSE.csv', 
               fetch_out_dir = "1_fetch/out",
               fetch_out_file = "data_raw.csv"), 
    format = "file"
  ), 
  # Prepare the data for plotting
  tar_target(
    data_clean_csv,
    prep_data(prep_data = data_raw_csv,
              prep_out_dir = "2_prep/out", 
              prep_out_file = "data_clean.csv",
              prep_exper = "similar"), 
    format = "file"
  ),
  # Create a plot
  tar_target(
    figure_png,
    plot_data(plot_data = data_clean_csv,
              plot_out_dir = "3_plot/out",
              plot_out_file = "figure.png",
              plot_model_order = c('pgdl', 'dl', 'pb'),
              plot_model_names = c("Process-Guided Deep Learning",
                                   "Deep Learning",
                                   "Process Based"),
              plot_colors = c('#7570b3', '#d95f02', '#1b9e77'),
              plot_pt_size = 6,
              plot_pt_shape = c(18, 15, 16),
              plot_pt_dodge = 0.075,
              plot_path_type = "dashed",
              plot_range_thick = 1,
              plot_x_title = "Training Temperature Profiles (#)",
              plot_y_title = "Test RMSE (°C)",
              plot_width_in = 8,
              plot_height_in = 10,
              plot_res = 200),
    format = "file"
  ),
  # Save the model diagnostics
  tar_target(
    model_summary_txt,
    summarise_data(summary_data = data_clean_csv,
                   summary_out_dir = "4_summary/out",
                   summary_out_file = "summary.txt"),
    format = "file"
  )
)
