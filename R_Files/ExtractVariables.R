###################################
###Extracting Variables Function###
###################################

convert_begin_date_to_decimal <- function(begin_date_values) {
  # Convert begin_date (YYYYMMDD format) to decimal date
  begin_date_str <- as.character(begin_date_values)
  
  # Extract year, month, day
  years <- as.numeric(substr(begin_date_str, 1, 4))
  months <- as.numeric(substr(begin_date_str, 5, 6))
  days <- as.numeric(substr(begin_date_str, 7, 8))
  
  # Create date objects
  actual_dates <- as.Date(paste(years, months, days, sep = "-"))
  
  # Calculate decimal date (year + fraction of year)
  # Get days in each year to handle leap years
  days_in_year <- ifelse(((years %% 4 == 0) & (years %% 100 != 0)) | (years %% 400 == 0), 366, 365)
  
  # Calculate day of year
  day_of_year <- as.numeric(format(actual_dates, "%j"))
  
  # Calculate decimal date
  decimal_date <- years + (day_of_year - 1) / days_in_year
  
  return(decimal_date)
}

extract_netcdf_timeseries <- function(file_list, var_name) {
  library(ncdf4)
  library(dplyr) 
  library(lubridate) 
  
  # Initialize variables
  all_data <- list()
  all_begin_dates <- c()
  lon <- NULL
  lat <- NULL
  
  file_list <- sort(file_list)
  
  cat("Processing", length(file_list), "NetCDF files...\n")
  
  #Step 1:  Loop through each file
  for (i in seq_along(file_list)) {
    filename <- file_list[i]
    
    # Check if file exists
    if (!file.exists(filename)) {
      warning(paste("File does not exist:", filename))
      next
    }
    
    cat("Processing file", i, "of", length(file_list), ":", basename(filename), "\n")
    
    #Step 2: Try to open and process the file
    tryCatch({
      # Open NetCDF file
      nc_file <- nc_open(filename)
      cat("Successfully opened file\n")
      
      # Print all available variables 
      if (i == 1) {
        cat("Available variables in file:", paste(names(nc_file$var), collapse = ", "), "\n")
        cat("Looking for variable:", var_name, "\n")
      }
      
      # Extract lat and lon (only from first file, assuming all files have same grid)
      if (is.null(lon)) {
        lon <- ncvar_get(nc_file, "lon")
        lat <- ncvar_get(nc_file, "lat")
        cat("Grid dimensions: lon =", length(lon), ", lat =", length(lat), "\n")
      }
      
      # Check if variable exists in file
      if (!(var_name %in% names(nc_file$var))) {
        warning(paste("Variable", var_name, "not found in file:", filename))
        warning(paste("Available variables are:", paste(names(nc_file$var), collapse = ", ")))
        nc_close(nc_file)
        next
      }
      
      cat("Variable", var_name, "found in file\n")
      
      # Extract time variable and its attributes
      time_var <- nc_file$var[["time"]]
      var_data <- ncvar_get(nc_file, varid = var_name)
      cat("Successfully extracted variable data, dimensions:", dim(var_data), "\n")
      
      # Extract begin_date attribute from time variable
      begin_date_att <- ncatt_get(nc_file, "time", "begin_date")
      if (begin_date_att$hasatt) {
        begin_date <- begin_date_att$value
        cat("Found begin_date:", begin_date, "\n")
      } else {
        warning(paste("No begin_date attribute found in file:", filename))
        nc_close(nc_file)
        next
      }
      
      # Store data
      all_data[[length(all_data) + 1]] <- var_data
      all_begin_dates <- c(all_begin_dates, begin_date)
      cat("Data stored successfully. Total files processed so far:", length(all_data), "\n")
      
      # Close file
      nc_close(nc_file)
      
    }, error = function(e) {
      warning(paste("Error processing file", filename, ":", e$message))
      cat("Full error details:", conditionMessage(e), "\n")
    })
  }
  
  # Check if any data was successfully loaded
  if (length(all_data) == 0) {
    stop("No data was successfully loaded from any files. Check file paths and variable name.")
  }
  
  # Combine all data
  # Assuming data structure is [lon, lat, time] for each file
  if (length(dim(all_data[[1]])) == 3) {
    # If each file has multiple time steps
    combined_data <- abind::abind(all_data, along = 3)
  } else if (length(dim(all_data[[1]])) == 2) {
    # If each file has single time step
    combined_data <- array(NA, dim = c(length(lon), length(lat), length(file_list)))
    for (i in seq_along(all_data)) {
      combined_data[,,i] <- all_data[[i]]
    }
  } else {
    stop("Unexpected data dimensions in NetCDF files")
  }
  
  # Convert begin_date to decimal date format
  decimal_times <- convert_begin_date_to_decimal(all_begin_dates)
  
  cat("Successfully combined data from", length(file_list), "files\n")
  cat("Final dimensions:", dim(combined_data), "\n")
  cat("Time series length:", length(decimal_times), "\n")
  cat("Time range:", round(min(decimal_times), 3), "to", round(max(decimal_times), 3), "\n")
  cat("Begin dates:", head(all_begin_dates, 3), "...", tail(all_begin_dates, 3), "\n")
  
  # Return list with named variable
  result <- list(
    lon = lon,
    lat = lat,
    time = decimal_times,
    n_files = length(file_list),
    time_info = list(
      begin_dates = all_begin_dates,
      decimal_times = decimal_times
    )
  )
  
  # Add the variable data with its actual name
  result[[var_name]] <- combined_data
  
  return(result)
}

#How to use:
#Call folder that contains all of the MERRA-2 downloaded data
#Call function
#Save Result

file_list <- list.files("/Users/nicochavez/Desktop/Senior_Thesis/Raw_Datasets", pattern = ".nc4", full.names = TRUE)
result <- extract_netcdf_timeseries(file_list, "CLDMID")
save(result, 
     file = "/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Extracted_Data/CLDMID.RData")
