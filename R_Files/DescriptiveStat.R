#Function for Descriptive Statistics
desc_stat <- function(var_trend){
  
  full <- unlist(var_trend$full_trend$trend)
  pre <- unlist(var_trend$trend_before$trend)
  post <- unlist(var_trend$trend_after$trend)
  
  #Find and Output Locations of Max and Min 
  max_idx <- which.max(post)
  min_idx <- which.min(post)
  
  #Extract Lon/Lat for specific Indices 
  max_lon <- var_trend$trend_after$lon[[max_idx]]
  max_lat <- var_trend$trend_after$lat[[max_idx]]
  
  min_lon <- var_trend$trend_after$lon[[min_idx]]
  min_lat <- var_trend$trend_after$lat[[min_idx]]
  
  #Store Results in List
  list(
    max_trend      = max(full, na.rm = TRUE),
    min_trend      = min(full, na.rm = TRUE),
    max_pre_trend  = max(pre, na.rm = TRUE),
    min_pre_trend  = min(pre, na.rm = TRUE),
    max_post_trend = max(post, na.rm = TRUE),
    min_post_trend = min(post, na.rm = TRUE),
    max_lon        = max_lon,
    max_lat        = max_lat,
    min_lon        = min_lon,
    min_lat        = min_lat
  )
}
