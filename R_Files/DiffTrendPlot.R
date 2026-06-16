library(dplyr)
library(ggplot2)
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)
library(ggpubr)

#Ploting Single Map Function
one_map_diff <- function (df_map, 
                     trend = "trend_diff",
                     title = "Trend",
                     units = "(°C/yr)",
                     pval = "pval"){
  #World Boundary 
  world <- rnaturalearth::ne_countries(
    scale = "medium",
    returnclass = "sf"
  )
  #Mexico Boundary
  mexico <- ne_countries(
    scale = "medium", 
    country = "Mexico", 
    returnclass = "sf")
  
  #Significance Flag 
  df_map <- df_map %>%
    mutate(significant = .data[[pval]] <= 0.05)
  
  #Create legend range
  full_range <- range(c(df_map[[trend]]), na.rm = T)
  min_val <- full_range[1]
  max_val <- full_range[2]
  
  #Apply Color Scaling Depending on Range of Values
  if (min_val >= 0) {
    #Yellow Red Scheme for only Positive values
    fill_scale <- scale_fill_gradient(
      low = "yellow",
      high = "red",
      na.value = "white",
      name = units,
      limits = full_range,
      breaks = pretty(full_range,
                      n = 5),
      guide = guide_colorbar(barwidth = 1.2,   
                             barheight = 14)
    )
    
  } else {
    #Diverging blue to white to red, centered at 0
    fill_scale <- scale_fill_gradient2(
      low = "blue",
      mid = "white",
      high = "red",
      midpoint = 0,
      na.value = "white",
      name = units,
      limits = full_range,
      breaks = pretty(full_range,
                      n =5),
      guide = guide_colorbar(barwidth = 1.2,   
                             barheight = 14)
    )
  }
  #Mexico Limits 
  lon_min <- -119; lon_max <- -86
  lat_min <- 14;   lat_max <- 33
  
  #Make the plot
  plot_trend <- ggplot() + 
    geom_tile(data = df_map, aes(lon, lat, fill = .data[[trend]])) +
    geom_tile(
      data = df_map %>% filter(!significant),
      aes(lon, lat),
      fill = "gray70",
      alpha = 0.4
    ) + 
    # Non-significant gridcells ("+" symbols)
    geom_point(
      data = df_map %>% filter(!significant),
      aes(lon, lat, shape = "Not significant"),
      size = 1.0,
      stroke = 1,
      color = "black"
    ) +
    geom_sf(data = world, fill = NA, color = "gray", linewidth = 0.6) +
    geom_sf(data = mexico, fill = NA, color = "black", linewidth = 0.6) +
    fill_scale +
    scale_shape_manual(
      name = "Significance",
      values = c("Not significant" = 3),
      labels = c("Not significant" = "p > 0.05")
    ) +
    guides(
      shape = guide_legend(order = 1),
      fill  = guide_colorbar(order = 2)
    ) + 
    coord_sf(
      xlim = c(lon_min, lon_max),
      ylim = c(lat_min, lat_max),
      expand = FALSE,
      clip = "on",
      crs = st_crs(4326), 
    ) +
    labs(title = title, x = "Longitude (°)", y = "Latitude (°)") +
    theme_pubclean(base_size = 12) + 
    theme(
      plot.title = element_text(
        face = "bold"
      ),
      plot.caption = element_text(
        size = 14,
        hjust = 0.5,
        face = "bold",
        margin = margin(t = 10)
      )
    )
  ggarrange(
    plot_trend,
    ncol = 1,
    common.legend = TRUE,
    legend = "right"
  )
}
