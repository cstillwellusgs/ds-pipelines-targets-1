# Function to prepare data for plotting

data_4plot <- function(data, colors, symbols) {
  filter(data, str_detect(exper_id, 'similar_[0-9]+')) %>%
    mutate(col = case_when(
      model_type == 'pb' ~ colors[1], 
      model_type == 'dl' ~ colors[2],
      model_type == 'pgdl' ~ colors[3]
    ), pch = case_when(
      model_type == 'pb' ~ symbols[1], 
      model_type == 'dl' ~ symbols[2],
      model_type == 'pgdl' ~ symbols[3]
    ), n_prof = as.numeric(str_extract(exper_id, '[0-9]+')))
}