#######################################
#Changing Data Resolution + Annual Averaging Function
#######################################

library(raster)
library(terra)

RegridData <- function(lat, lon, time, chosen_dataset, 
                       mode = "global",
                       lat_min = NULL, lat_max = NULL,
                       lon_min = NULL, lon_max = NULL, 
                       save = TRUE, 
                       filename = NULL) {
  #' Regrid spatial data to 1x1 degree resolution
  #'
  #' @param lat Vector of latitude values
  #' @param lon Vector of longitude values
  #' @param time Vector of time values
  #' @param chosen_dataset 3D array (lon x lat x time)
  #' @param lat_min, lat_max, lon_min, lon_max Boundary for regional mode
  #'
  #' @return List with regridded data array (360 x 180 x time) and coordinate vectors
  
  ntime <- dim(chosen_dataset)[3]
  
  cat("Input dimensions:", dim(chosen_dataset)[1], "x", dim(chosen_dataset)[2], "x", ntime, "\n")
  
  ##########################################
  # 1. Build multilayer raster from input
  ##########################################

  raster_list <- list()
  
  
  lat_res <- abs(lat[2] - lat[1])
  lon_res <- abs(lon[2] - lon[1])
  
  lat_min_edge <- min(lat) - lat_res/2
  lat_max_edge <- max(lat) + lat_res/2
  lon_min_edge <- min(lon) - lon_res/2
  lon_max_edge <- max(lon) + lon_res/2
  
  cat("Creating raster stack...\n")
  for (t in 1:ntime) {
    slice_2d <- chosen_dataset[, , t]
    slice_correct <- t(slice_2d)[ncol(slice_2d):1, ]
    if (lat[1] > lat[length(lat)]) {
      slice_correct <- slice_correct[nrow(slice_correct):1, ]
    }
    # terra uses (row, col) = (lat, lon), so transpose
    r <- rast(slice_correct,
              extent = ext(lon_min_edge, lon_max_edge, lat_min_edge, lat_max_edge),
              crs = "epsg:4326")
    raster_list[[t]] <- r
    
    if (t %% 10 == 0) {
      cat("  Layer", t, "/", ntime, "\n")
    }
  }
  
  # Stack all layers
  r_stack <- rast(raster_list)
  
  ##########################################
  # 2. Build target grid (global or regional)
  ##########################################

  if (mode == "global"){
    
    cat("Mode: GLOBAL (360 x 180 grid)\n")
    
    target_lon <- seq(-179.5, 179.5, by = 1)
    target_lat <- seq(-89.5, 89.5, by = 1)
    
    target_raster <- rast(nrow = length(target_lat),
                          ncol = length(target_lon),
                          extent = ext(-180, 180, -90, 90),
                          crs = "epsg:4326",
                          nlyr = ntime)
  } else if (mode == "regional"){
    
    cat("Mode: REGIONAL\n")
    
    if (any(sapply(list(lat_min, lat_max, lon_min, lon_max), is.null))) {
      stop("Regional mode requires lat_min, lat_max, lon_min, lon_max")
    }
      target_raster <- rast(extent = ext(lon_min,
                                         lon_max,
                                         lat_min,
                                         lat_max),
                            resolution = 1, 
                            crs = "epsg:4326",
                            nlyr = ntime)
      
      target_lon <- xFromCol(target_raster)
      target_lat <- yFromRow(target_raster)
  } else {
    stop("mode must be 'global' or 'regional'")
  }
  
  ##########################################
  # 3. Resampling 
  ##########################################
  
  regridded_raster <- resample(r_stack, target_raster, method = "average")
  
  ##########################################
  # 4. Convert back to Array Format
  ##########################################
  regridded_array <- array(NA, dim = c(length(target_lon),
                                 length(target_lat),
                                 ntime))
  
  for (t in 1:ntime) {
    regridded_matrix <- as.matrix(regridded_raster[[t]], wide = TRUE)
    # Transpose to get (lon x lat)
    regridded_array[, , t] <- t(regridded_matrix)
  }
  
  ##########################################
  # 5. Compute Annual Averages
  ##########################################
  
  years <- floor(time)                     # extract year from timestamps
  unique_years <- sort(unique(years))      # list of years present
  
  nyear <- length(unique_years)
  nlon  <- dim(regridded_array)[1]
  nlat  <- dim(regridded_array)[2]
  
  annual_array <- array(NA, dim = c(nlon, nlat, nyear))
  
  for (k in seq_along(unique_years)) {
    yr <- unique_years[k]
    idx <- which(years == yr)              # all monthly slices for that year
    annual_array[,,k] <- apply(regridded_array[,,idx], c(1,2), mean, na.rm = TRUE)
  }
  
  cat("Annual output dimensions:", dim(annual_array), "\n") 
  
  ##########################################
  # 6. Save Regridded Annually Averaged File
  ##########################################
  if (save) {
    expression <- substitute(chosen_dataset)
    
    if (is.call(expression) && expression[[1]] == "$") {
      # Extract the part after the $
      varname <- as.character(expression[[3]])
    } else {
      varname <- deparse(expression)
    }
  #Setup Output Directory
  parent_dir <- "/Users/nicochavez/Senior_Thesis/R_Datasets"
  output_dir <- file.path(parent_dir, "Regridded_Annual_Data")
    
  if (!dir.exists(output_dir)) {
      dir.create(output_dir, recursive = TRUE)
  }
 #Create Full Save File Path
  file_path <- file.path(output_dir, paste0(varname, ".rds"))
  }
#Save File
  saveRDS(
    list(
      annual  = annual_array,
      lon     = target_lon,
      lat     = target_lat,
      years   = unique_years
    ),
    file = file_path
  )
  
  cat("Saved file to:", normalizePath(file_path), "\n")
  
  return(list(
    data = annual_array,
    lon = target_lon,
    lat = target_lat,
    years = unique_years
  ))
  }

#How to use function...

#Import data, importing a variable called result...
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Extracted_Data/CLDHGH.RData") 
# Regrid + annual average + save
regrid_out <- RegridData(
  lat = result$lat,
  lon = result$lon,
  time = result$time,
  chosen_dataset = result$CLDHGH,
  mode = "regional",
  lat_min = min(result$lat), lat_max = max(result$lat),
  lon_min = min(result$lon), lon_max = max(result$lon), 
  save = TRUE
)

