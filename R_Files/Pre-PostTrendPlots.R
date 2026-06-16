library(dplyr)
library(ggplot2)
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)
library(ggpubr)

#Plotting function
two_maps <- function (df_map, 
                         pre_trend = "trend_pre",
                         post_trend = "trend_post",
                         title_pre = "(a) Pre-2010 Warming",
                         title_post = "(b) Post-2010 Warming",
                         unit_val = "(°C/yr)",
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

# Add significance flag (same p-values for BOTH maps)
df_map <- df_map %>%
  mutate(significant = .data[[pval]] <= 0.05)

#Create range of values for shared legend
full_range <- range(c(df_map[[pre_trend]], df_map[[post_trend]]), na.rm = T)

min_val <- full_range[1]
max_val <- full_range[2]

#Apply Color Scaling Depending on Range of Values
if (min_val >= 0) {
  #Yellow Red Scheme for only Positive values
  fill_scale <- scale_fill_gradient(
    low = "yellow",
    high = "red",
    na.value = "white",
    name = unit_val,
    limits = full_range,
    breaks = pretty(full_range,
                    n = 5),
    guide = guide_colorbar(barwidth = 12,
                           barheight = 0.8)
  )
  
} else {
  #Diverging blue to white to red, centered at 0
  fill_scale <- scale_fill_gradient2(
    low = "blue",
    mid = "white",
    high = "red",
    midpoint = 0,
    na.value = "white",
    name = unit_val,
    limits = full_range,
    guide = guide_colorbar(barwidth = 12,
                          barheight = 0.8)
  )
}

#Mexico Limits 
lon_min <- -120; lon_max <- -85
lat_min <- 14;   lat_max <- 33

# Pre-2010 Plot
plot_pre <- ggplot() + 
  geom_tile(data = df_map, aes(lon, lat, fill = .data[[pre_trend]])) +
  # Gray overlay for non-significant cells
  geom_tile(
    data = df_map %>% filter(!significant),
    aes(lon, lat),
    fill = "gray70",
    alpha = 0.4
  ) +
  
  # "+" symbols for non-significant cells (with legend)
  geom_point(
    data = df_map %>% filter(!significant),
    aes(lon, lat, shape = "Not significant"),
    size = 1,
    stroke = 1,
    color = "black"
  ) +
  geom_sf(data = world, fill = NA, color = "gray", linewidth = 0.6) +
  geom_sf(data = mexico, fill = NA, color = "black", linewidth = 0.6) +
  # Significance legend FIRST
  scale_shape_manual(
    name = "Significance",
    values = c("Not significant" = 3),
    labels = c("Not significant" = "p > 0.05")
  ) +
  # Trend colorbar SECOND
  fill_scale +
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
  labs(title = title_pre, x = "Longitude (°)", y = "Latitude (°)") +
  theme_pubclean(base_size = 12) + 
  labs(
    title = NULL,
    caption = title_pre
  ) +
  theme(
    legend.key.size = unit(1.5, "cm"),   # size of legend boxes
    legend.text = element_text(size = 10),  # tick label size
    legend.title = element_text(size = 12),  # title size
    legend.margin = margin(b = -50),
    plot.caption = element_text(
      size = 14,
      hjust = 0.5,
      face = "bold",
      margin = margin(t = 10)
    )
  )

# Post-2010 Plot
plot_post <- ggplot() +
  geom_tile(data = df_map, aes(lon, lat, fill = .data[[post_trend]])) +
  geom_tile(
    data = df_map %>% filter(!significant),
    aes(lon, lat),
    fill = "gray70",
    alpha = 0.4
  ) +
  
  # "+" symbols for non-significant cells (with legend)
  geom_point(
    data = df_map %>% filter(!significant),
    aes(lon, lat, shape = "Not significant"),
    size = 0.6,
    stroke = 0.4,
    color = "black"
  ) +
  geom_sf(data = world, fill = NA, color = "gray", linewidth = 0.6) + 
  geom_sf(data = mexico, fill = NA, color = "black", linewidth = 0.6) +
  scale_shape_manual(
    name = "Significance",
    values = c("Not significant" = 3),
    labels = c("Not significant" = "p > 0.05")
  ) +
  # Trend colorbar SECOND
  fill_scale +
  guides(
    shape = guide_legend(order = 1),
    fill  = guide_colorbar(order = 2)
  ) +
  coord_sf(
    xlim = c(lon_min, lon_max),
    ylim = c(lat_min, lat_max),
    expand = FALSE,
    clip = "on",
    crs = st_crs(4326)
  ) +
  labs(title = title_post, x = "Longitude (°)", y = "Latitude (°)") +
  theme_pubclean(base_size = 12) + 
  labs(
    title = NULL,
    caption = title_post   
  ) +
  theme(
    legend.key.size = unit(1.5, "cm"),   # size of legend boxes
    legend.text = element_text(size = 10),  # tick label size
    legend.title = element_text(size = 12),  # title size
    plot.caption = element_text(
      size = 14,
      hjust = 0.5,
      face = "bold",
      margin = margin(t = 10)
    )
  )

# Combine with shared legend 
ggarrange(
  plot_pre, plot_post, 
  ncol = 2, 
  common.legend = TRUE
)
}