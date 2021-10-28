# Function to prepare data for plotting ----------------------------------------
# prep_data <- function(data_raw, prep_exper) {
#   data_clean <- data_raw %>%
#     filter(grepl(paste(prep_exper), exper_id)) %>%
#     mutate(n_prof = as.integer(str_remove(exper_id, "similar_")))
#   assign("data_clean", data_clean, envir = .GlobalEnv)
#   data_plot <- data_clean %>%
#     group_by(n_prof, model_type) %>%
#     summarise(mean_rmse = mean(rmse),
#               min_rmse = min(rmse), 
#               max_rmse = max(rmse), 
#               .groups = "drop")
#   assign("data_plot", data_plot, envir = .GlobalEnv)
#   print("Data reformatted for plotting")
# }

prep_data <- function(prep_data, prep_out_dir, prep_out_file, prep_exper) {
  dest <- file.path(prep_out_dir, prep_out_file)
  data_clean <- read_csv(prep_data, col_types = "iccd") %>%
    filter(grepl(paste(prep_exper), exper_id)) %>%
    mutate(n_prof = as.integer(str_remove(exper_id, "similar_"))) %>%
    group_by(n_prof, model_type) %>%
    summarise(mean_rmse = mean(rmse),
              min_rmse = min(rmse), 
              max_rmse = max(rmse), 
              .groups = "drop") %>%
    write_csv(file = dest)
  return(dest)
}