#Function for computing all of the trends for the maps
compute_all_trends <- function(var, split_year = 2010, varname = "Variable", region = c(-119, -86, 14, 33), make_plots = FALSE) {
  
  lon  <- var$lon
  lat  <- var$lat
  data <- var$annual
  time <- var$years

  nlon <- length(lon)
  nlat <- length(lat)

  
  ############################################################################
  # 1. FULL TREND (1980–Present)
  ############################################################################
  full_trend <- matrix(NA, nlon, nlat)
  full_pval <- matrix(NA, nlon, nlat)
  
  for (i in 1:nlon) {
    for (j in 1:nlat) {
      ts <- data[i, j, ]
      if (sum(!is.na(ts)) > 1) {
        model <- lm(ts ~ time)
        sm <- summary(model)
        
        full_trend[i, j] <- coef(model)[2]
        full_pval[i, j] <- sm$coefficients[2, 4] 
      }
    }
  }
  
  full_df <- expand.grid(lon = lon, lat = lat)
  pval_df <- expand.grid(lon = lon, lat = lat)
  full_df$trend <- as.vector(full_trend)
  pval_df$pvalues <- as.vector(full_pval)
  
  ############################################################################
  # 2. SPLIT TRENDS (before and after split year)
  ############################################################################
  idx_before <- which(time < split_year)
  idx_after  <- which(time >= split_year)
  
  trend_before <- matrix(NA, nlon, nlat)
  trend_after  <- matrix(NA, nlon, nlat)
  
  for (i in 1:nlon) {
    for (j in 1:nlat) {
      
      ts_before <- data[i, j, idx_before]
      ts_after  <- data[i, j, idx_after]
      
      if (sum(!is.na(ts_before)) > 1) {
        model_b <- lm(ts_before ~ time[idx_before])
        trend_before[i, j] <- coef(model_b)[2]
      }
      
      if (sum(!is.na(ts_after)) > 1) {
        model_a <- lm(ts_after ~ time[idx_after])
        trend_after[i, j] <- coef(model_a)[2]
      }
    }
  }
  
  before_df <- expand.grid(lon = lon, lat = lat)
  before_df$trend <- as.vector(trend_before)
  
  after_df <- expand.grid(lon = lon, lat = lat)
  after_df$trend <- as.vector(trend_after)
  
  ############################################################################
  # 3. TREND DIFFERENCE (after − before)
  ############################################################################
  trend_diff <- trend_after - trend_before
  
  diff_df <- expand.grid(lon = lon, lat = lat)
  diff_df$trend <- as.vector(trend_diff)
  
  ############################################################################
  # 4. PLOTTING (all 4 maps) (Unused)
  ############################################################################
  if (make_plots) {
    library(ggplot2)
    library(maps)
    
    plot_map <- function(df, title) {
      print(
        ggplot(df, aes(lon, lat, fill = trend)) +
          geom_tile() +
          scale_fill_gradient2(low="blue", mid="white", high="red", midpoint=0) +
          borders("world", colour="black") +
          coord_fixed(xlim = region[1:2], ylim = region[3:4]) +
          labs(title = title, fill = "Trend") +
          theme_minimal()
      )
    }
    
    plot_map(full_df,   paste(varname, "Full Trend (1980–2025)"))
    plot_map(before_df, paste(varname, "Trend Before", split_year))
    plot_map(after_df,  paste(varname, "Trend After",  split_year))
    plot_map(diff_df,   paste(varname, "Trend Difference (After − Before)"))
  }
  
  ############################################################################
  # 5. RETURN EVERYTHING AND FILTER TO JUST MEXICO Gridcells
  ############################################################################

  #Bounding box
  lon_min <- -120
  lon_max <- -85
  lat_min <- 14
  lat_max <- 33
  
  #Filtering
  inside_mexico <- with(full_df,
                        lon >= lon_min & lon <= lon_max &
                          lat >= lat_min & lat <= lat_max
  )
  
  full_df      <- full_df[inside_mexico, ]
  before_df    <- before_df[inside_mexico, ]
  after_df     <- after_df[inside_mexico, ]
  diff_df      <- diff_df[inside_mexico, ]
  pval_df      <- pval_df[inside_mexico, ]
  
  #Return Final Values
  return(list(
    full_trend   = full_df,
    trend_before = before_df,
    trend_after  = after_df,
    trend_diff   = diff_df,
    pvalues      = pval_df
  ))
}

