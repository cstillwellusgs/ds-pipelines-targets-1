library(targets)
source("1_fetch/src/fetch_data.R")
source("2_prep/src/prep_data.R")
source("3_plot/src/plot_data.R")
source("4_summary/src/summarise_data.R")
tar_option_set(packages = c("tidyverse", "sbtools"))

list(
  # Get the data from ScienceBase
  tar_target(
    new_data_raw,
    fetch_data(out_filepath = "1_fetch/out/new_mendota_data.csv"),
    format = "file"
  ),
  # Prepare the data for plotting
  tar_target(
    new_data_plot,
    prep_data(in_filepath = new_data_raw),
  ),
  # Create a plot
  tar_target(
    new_figure_1,
    plot_data(out_filepath = "3_plot/out/new_figure_1.png",
              data = new_data_plot),
    format = "file"
  ),
  # Save the processed data
  tar_target(
    new_model_results,
    write_csv(new_data_plot,
              file = "3_plot/out/new_data_plot.csv"),
    format = "file"
  ),
  # Save the model diagnostics
  tar_target(
    new_model_summary,
    summarise_data(out_filepath = "4_summary/out/new_summary.txt",
                   data = new_data_plot),
    format = "file"
  )
)

tar_make()
