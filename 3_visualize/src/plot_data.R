# Function to prepare plot area
plot_prep <- function(width, height, res, units, 
                      omi, mai, las, mgp, cex, 
                      out_dir, out_file) {
  destination <- file.path(out_dir, out_file)
  png(file = destination, 
      width = width, height = height, res = res, units = units)
  par(omi = omi, mai = mai, las = las, mgp = mgp, cex = cex)
}


# Function to prepare plot axes
axes_prep <- function(xlim, ylim, xlab, ylab, log, tck) {
  plot(NA, NA, xlim = xlim, ylim = ylim, 
       xlab = xlab, ylab = ylab, log = log, axes = FALSE)
  axis(1, at = c(-100, n_profs, 1e10), labels = c("", n_profs, ""), tck = tck)
  axis(2, at = seq(0, 10), las = 1, tck = tck)
}


# Function to calculate plotting statistics
plot_data <- function(data, model_types, lwd, lty, bg, cex) {
  for (mod in model_types){
    mod_data <- filter(data, model_type == mod)
    mod_profiles <- unique(mod_data$n_prof)
    for (mod_profile in mod_profiles){
      d <- filter(mod_data, n_prof == mod_profile) %>% 
        summarize(y0 = min(rmse), y1 = max(rmse), col = unique(col))
      x_pos <- offsets %>% 
        filter(n_prof == mod_profile) %>% 
        pull(!!mod) + mod_profile
      lines(c(x_pos, x_pos), c(d$y0, d$y1), col = d$col, lwd = lwd)
    }
    d <- group_by(mod_data, n_prof) %>% 
      summarize(y = mean(rmse), col = unique(col), pch = unique(pch)) %>%
      rename(x = n_prof) %>% 
      arrange(x)
    
    lines(d$x + tail(offsets[[mod]], nrow(d)), d$y, 
          col = d$col[1], lty = 'dashed')
    points(d$x + tail(offsets[[mod]], nrow(d)), d$y, 
           pch = d$pch[1], col = d$col[1], bg = 'white', lwd = 2.5, cex = 1.5)
  }
}


# Function to add legend
add_legend <- function(x_pos_pt, y_pos_pt, x_pos_txt, y_pos_txt, labels, 
                       colors, symbols, bg, lwd, cex_pt, pos_txt, cex_txt) {
  points(x_pos_pt, y_pos_pt, col = colors, pch = symbols, 
         bg = bg, lwd = lwd, cex = cex_pt)
  text(x_pos_txt, y_pos_txt, labels, pos = pos_txt, cex = cex_txt)
}