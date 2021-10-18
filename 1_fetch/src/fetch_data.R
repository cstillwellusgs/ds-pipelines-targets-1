# Function to fetch data
fetch_data <- function(sb_id, item_name, out_dir, out_file) {
  destination <- file.path(out_dir, out_file)
  item_file_download(sb_id, names = item_name, destinations = destination, 
                     overwrite_file = TRUE) 
}
