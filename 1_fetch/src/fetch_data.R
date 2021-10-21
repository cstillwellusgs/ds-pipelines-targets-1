# Function to fetch data -------------------------------------------------------
fetch_data <- function(fetch_sb_id, fetch_item_name, 
                       fetch_out_dir, fetch_out_file) {
  dest <- file.path(fetch_out_dir, fetch_out_file)
  item_file_download(fetch_sb_id, names = fetch_item_name, 
                     destinations = dest, overwrite_file = TRUE)
  data <- read_csv(dest, col_types = 'iccd')
  assign("data_raw", data, envir = .GlobalEnv)
  print("Data fetched from ScienceBase")
}
