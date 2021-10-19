# Load libraries
library(sbtools)
library(tidyverse)
library(whisker)

# Read in functions
source("1_fetch/src/fetch_data.R")
source("2_process/src/process_data.R")
source("3_visualize/src/plot_data.R")

# Create sub-directories for outputs
dir.create("1_fetch/out", showWarnings = FALSE)
dir.create("2_process/out", showWarnings = FALSE)
dir.create("3_visualize/out", showWarnings = FALSE)

# Fetch data
fetch_data(sb_id = '5d925066e4b0c4f70d0d0599', item_name = 'me_RMSE.csv', 
           out_dir = "1_fetch/out", out_file = "mendota_data.csv")

# Read data
data_raw <- read_csv("1_fetch/out/mendota_data.csv", col_types = 'iccd')

# Prepare data for plotting
data_to_plot <- 
  data_4plot(data_raw, colors = c('#1b9e77', '#d95f02', '#7570b3'), 
             symbols = c(21, 22, 23))

# Create and save plot
plot_prep(width = 8, height = 10, res = 200, units = 'in', 
          omi = c(0, 0, 0.05, 0.05), mai = c(1, 1, 0, 0), 
          las = 1, mgp = c(2, 0.5, 0), cex = 1.5, 
          out_dir = "3_visualize/out", out_file = "figure_1.png")
n_profs <- sort(unique(data_to_plot$n_prof))
offsets <- data.frame(pgdl = c(0.15, 0.5, 3, 7, 20, 30)) %>%
  mutate(dl = -pgdl, pb = 0, n_prof = n_profs)
axes_prep(xlim = c(2, 1000), ylim = c(4.7, 0.75), 
          xlab = "Training temperature profiles (#)", ylab = "Test RMSE (°C)", 
          log = 'x', tck = -0.01)
plot_data(data = data_to_plot, model_types = c('pb','dl','pgdl'), 
           lwd = 2.5, lty = 'dashed', bg = 'white', cex = 1.5)
add_legend(x_pos_pt = c(2.2, 2.2, 2.2), y_pos_pt = c(0.79, 0.94, 1.09), 
           x_pos_txt = c(2.3, 2.3, 2.3), y_pos_txt = c(0.8, 0.95, 1.1), 
           labels = c("Process-Guided Deep Learning", 
                      "Deep Learning", "Process-Based"), 
           colors = c('#7570b3', '#d95f02', '#1b9e77'), symbols = c(23, 22, 21), 
           bg = 'white', lwd = 2.5, cex_pt = 1.5, pos_txt = 4, cex_txt = 1.1)
dev.off()
write_csv(data_to_plot, 
          file = file.path("3_visualize/out", 'model_summary_results.csv'))

# Calculate and save model diagnostics
model_diagnostics <- data_to_plot %>%
  group_by(model_type, exper_id) %>%
  summarise(rmse_mean = round(mean(rmse), 2))
write_csv(model_diagnostics, 
          file = file.path("3_visualize/out", 'model_diagnostics.csv'))

# Generate summary
summary <- 'resulted in mean RMSEs (means calculated as average of RMSEs from the five dataset iterations) of {{pgdl_980mean}}, {{dl_980mean}}, and {{pb_980mean}}°C for the PGDL, DL, and PB models, respectively.
  The relative performance of DL vs PB depended on the amount of training data. The accuracy of Lake Mendota temperature predictions from the DL was better than PB when trained on 500 profiles 
  ({{dl_500mean}} and {{pb_500mean}}°C, respectively) or more, but worse than PB when training was reduced to 100 profiles ({{dl_100mean}} and {{pb_100mean}}°C respectively) or fewer.
  The PGDL prediction accuracy was more robust compared to PB when only two profiles were provided for training ({{pgdl_2mean}} and {{pb_2mean}}°C, respectively). '

whisker.render(summary %>% 
                 str_remove_all('\n') %>% 
                 str_replace_all('  ', ' '), summary ) %>% 
  cat(file = file.path("3_visualize/out", 'model_summary.txt'))
