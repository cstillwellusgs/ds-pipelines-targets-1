# Function to plot data --------------------------------------------------------
plot_data <- function(data_plot, plot_out_dir, plot_out_fig, plot_out_data, 
                      plot_model_order, plot_model_names, plot_colors, 
                      plot_pt_size, plot_pt_shape, plot_pt_dodge, 
                      plot_path_type, plot_range_thick, 
                      plot_x_title, plot_y_title, 
                      plot_width_in, plot_height_in, plot_res) {
  dest_plot <- file.path(plot_out_dir, plot_out_fig)
  dest_data <- file.path(plot_out_dir, plot_out_data)
  data_plot$model_type <- factor(data_plot$model_type, 
                                 levels = plot_model_order, 
                                 labels = plot_model_names)
  figure <- ggplot(data = data_plot) +
    geom_point(aes(x = n_prof, y = mean_rmse, 
                   color = model_type, shape = model_type), 
               size = plot_pt_size, 
               position = position_dodge(width = plot_pt_dodge)) +
    geom_path(aes(x = n_prof, y = mean_rmse, color = model_type), 
              linetype = plot_path_type, show.legend = FALSE) +
    geom_linerange(aes(x = n_prof, ymin = min_rmse, ymax = max_rmse, 
                       color = model_type), 
                   position = position_dodge(width = plot_pt_dodge), 
                   size = plot_range_thick, show.legend = FALSE) +
    scale_x_log10(breaks = unique(data_plot$n_prof)) +
    scale_y_reverse() +
    labs(x = plot_x_title, y = plot_y_title, color = "", shape = "") +
    scale_shape_manual(values = plot_pt_shape) +
    scale_color_manual(values = plot_colors) +
    theme_classic() +
    theme(axis.text = element_text(size = 18, color = 'black'), 
          axis.title = element_text(size = 18, color = 'black'), 
          axis.title.x = element_text(vjust = -1), 
          axis.title.y = element_text(vjust = 3), 
          axis.ticks.length = unit(0.1, "in"),
          legend.position = c(0.33, 0.95),
          legend.text = element_text(size = 18, color = 'black'),
          legend.background = element_blank(),
          plot.margin = margin(l = 10, b = 10, r = 10, t = 10), 
          panel.grid = element_blank())
  assign(plot_out_fig, figure, envir = .GlobalEnv)
  ggsave(filename = dest_plot, plot = figure, units = "in", 
         width = plot_width_in, height = plot_height_in, dpi = plot_res)
  print("Data plotted")
  write_csv(data_plot, file = dest_data)
  print("Data saved")
}