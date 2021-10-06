# Read in data
data_raw <- read_csv("1_fetch/out/mendota_raw.csv", col_types = 'iccd')
  
# Prepare data for plotting
data_for_plot <- data_raw %>%
  filter(str_detect(exper_id, 'similar_[0-9]+')) %>%
  mutate(col = case_when(
    model_type == 'pb' ~ '#1b9e77',
    model_type == 'dl' ~'#d95f02',
    model_type == 'pgdl' ~ '#7570b3'
  ), pch = case_when(
    model_type == 'pb' ~ 21,
    model_type == 'dl' ~ 22,
    model_type == 'pgdl' ~ 23
  ), n_prof = as.numeric(str_extract(exper_id, '[0-9]+')))

# Save new data
write_csv(data_for_plot, file = "2_process/out/data_for_plot.csv")
