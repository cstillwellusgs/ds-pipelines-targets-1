# Function to summarize findings -----------------------------------------------

summarise_data <- function(summary_data, summary_out_dir, summary_out_file) {
  dest <- file.path(summary_out_dir, summary_out_file)
  data <- read_csv(summary_data, col_types = "icddd")
  summary <- paste0("resulted in mean RMSEs (means calculated as average of RMSEs from the five dataset iterations) of ", 
                    round(data[[17,3]], 3), ", ", round(data[[15,3]], 3), ", and ", round(data[[16,3]], 3), 
                    "°C for the PGDL, DL, and PB models, respectively. The relative performance of DL vs PB depended on the amount of training data. The accuracy of Lake Mendota temperature predictions from the DL was better than PB when trained on 500 profiles (", 
                    round(data[[12,3]], 3), " and ", round(data[[13,3]], 3), "°C, respectively) or more, but worse than PB when training was reduced to 100 profiles (", 
                    round(data[[9,3]], 3), " and ", round(data[[10,3]], 3), "°C respectively) or fewer. The PGDL prediction accuracy was more robust compared to PB when only two profiles were provided for training (",
                    round(data[[2,3]], 3), " and ", round(data[[1,3]], 3), "°C, respectively).")
  cat(summary, file = dest)
  return(dest)
}