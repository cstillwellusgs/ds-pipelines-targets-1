# Function to prepare data for plotting ----------------------------------------
prep_data <- function(data_raw, prep_exper) {
  data_clean <- data_raw %>%
    filter(grepl(paste(prep_exper), exper_id)) %>%
    mutate(n_prof = as.integer(str_remove(exper_id, "similar_")))
  assign("data_clean", data_clean, envir = .GlobalEnv)
  data_plot <- data_clean %>%
    group_by(n_prof, model_type) %>%
    summarise(mean_rmse = mean(rmse),
              min_rmse = min(rmse), 
              max_rmse = max(rmse), 
              .groups = "drop")
  assign("data_plot", data_plot, envir = .GlobalEnv)
  print("Data reformatted for plotting")
}