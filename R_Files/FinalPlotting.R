# Load BEST and MERRA-2 data (older method requiring manual data frames)
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/tas_yearly_from_nc.RData")
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/swland_regridded_yearly_from_nc.RData")
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/lhland_regridded_yearly_from_nc.RData")
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/aod_yearly_from_nc.RData")
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/CLOUD_yearly_from_nc.RData")
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/DUSCATFM_yearly_from_nc.RData")
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/DUEXTTFM_yearly_from_nc.RData")
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/gwettop_regridded_yearly_from_nc.RData")
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/lai_regridded_yearly_from_nc.RData")
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/DTDTLWR_yearly_from_nc.RData")
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/DTDTSWR_yearly_from_nc.RData")
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/DTDTLWRCLR_yearly_from_nc.RData")
load("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/DTDTSWRCLR_yearly_from_nc.RData")

#newer method using RDS files... 
#(NOTE: new file path is now /Users/nicochavez/Senior_Thesis/R_Datasets/Regridded_Annual_Data/MYDATA.rds)

df_LWL <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/LWLAND.rds")
df_LWGNT <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/LWGNT.rds")
df_LWGNTCLR <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/LWGNTCLR.rds")
df_LWGNTCLRCLN <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/LWGNTCLRCLN.rds")
df_SWGNT <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/SWGNT.rds")
df_SWGNTCLN <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/SWGNTCLN.rds")
df_SWGNTCLR <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/SWGNTCLR.rds")
df_SWGNTCLRCLN <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/SWGNTCLRCLN.rds")
df_CLDHGH <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/CLDHGH.rds")
df_CLDLOW <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/CLDLOW.rds")
df_CLDMID <- readRDS("/Users/nicochavez/Desktop/Data/Regridded_Annual_Avg_Output/CLDMID.rds")
df_TAUHGH <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/TAUHGH.rds")
#df_TAULOW <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/TAULOW.rds")
df_TAUMID <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/TAUMID.rds")
df_GRN <- readRDS("/Users/nicochavez/Desktop/Senior_Thesis/R_Datasets/Regridded_Annual_Data/GRN.rds")


# Load Plot and Helper Functions
source("/Users/nicochavez/Desktop/Senior_Thesis/R_Files/ComputeTrends.R")
source("/Users/nicochavez/Desktop/Senior_Thesis/R_Files/DescriptiveStat.R")
source("/Users/nicochavez/Desktop/Senior_Thesis/R_Files/Pre-PostTrendPlots.R")
source("/Users/nicochavez/Desktop/Senior_Thesis/R_Files/FullTrendPlots.R")
source("/Users/nicochavez/Desktop/Senior_Thesis/R_Files/DiffTrendPlot.R")
source("/Users/nicochavez/Desktop/Senior_Thesis/R_Files/ITS_Analysis.R")

# Turn data into valid list
df_TAS <- list(
  lon = lon,
  lat = lat,
  years = yr, 
  annual = yr_tas
)
df_AOD <- list(
  lon = lon,
  lat = lat,
  years = yr, 
  annual = yr_aod
)
df_SWL <- list(
  lon = lon,
  lat = lat,
  years = yr, 
  annual = yr_swland
)
df_LHL <- list(
  lon = lon,
  lat = lat,
  years = yr, 
  annual = yr_lhland
)
df_CLD <- list(
  lon = lon,
  lat = lat,
  years = yr, 
  annual = yr_CLOUD
)
df_DEX <- list(
  lon = lon,
  lat = lat,
  years = yr, 
  annual = yr_DustExt
)
df_DUSC <- list(
  lon = lon,
  lat = lat,
  years = yr, 
  annual = yr_DustScat
)
df_GWT <- list(
  lon = lon,
  lat = lat,
  years = yr, 
  annual = yr_gwettop
)
df_LAI <- list(
  lon = lon,
  lat = lat,
  years = yr, 
  annual = yr_lai
)
df_DTDTLWR <- list(
  lon = lon,
  lat = lat,
  years = yr, 
  annual = yr_DTDTLWR
)
df_DTDTSWR <- list(
  lon = lon,
  lat = lat,
  years = yr, 
  annual = yr_DTDTSWR
)
df_DTDTLWRCLR <- list(
  lon = lon,
  lat = lat,
  years = yr, 
  annual = yr_DTDTLWRCLR
)
df_DTDTSWRCLR <- list(
  lon = lon,
  lat = lat,
  years = yr, 
  annual = yr_DTDTSWRCLR
)


# Run Trend Analysis for Vars
TAS_Trend <- compute_all_trends(df_TAS, make_plots = F)
AOD_Trend <- compute_all_trends(df_AOD, make_plots = F)
SWL_Trend <- compute_all_trends(df_SWL, make_plots = F)
LWL_Trend <- compute_all_trends(df_LWL, make_plots = F)
LHL_Trend <- compute_all_trends(df_LHL, make_plots = F)
CLOUD_Trend <- compute_all_trends(df_CLD, make_plots = F)
DUSTEX_Trend <- compute_all_trends(df_DEX, make_plots = F)
DUSCAT_Trend <- compute_all_trends(df_DUSC, make_plots = F)
GWT_Trend <- compute_all_trends(df_GWT, make_plots = F)
LAI_Trend <- compute_all_trends(df_LAI, make_plots = F)
DTDTLWR_Trend <- compute_all_trends(df_DTDTLWR, make_plots = F)
DTDTSWR_Trend <- compute_all_trends(df_DTDTSWR, make_plots = F)
DTDTLWRCLR_Trend <- compute_all_trends(df_DTDTLWRCLR, make_plots = F)
DTDTSWRCLR_Trend <- compute_all_trends(df_DTDTSWRCLR, make_plots = F)
LWGNT_Trend <- compute_all_trends(df_LWGNT, make_plots = F)
LWGNTCLR_Trend <- compute_all_trends(df_LWGNTCLR, make_plots = F)
LWGNTCLRCLN_Trend <- compute_all_trends(df_LWGNTCLRCLN, make_plots = F)
SWGNT_Trend <- compute_all_trends(df_SWGNT, make_plots = F)
SWGNTCLN_Trend <- compute_all_trends(df_SWGNTCLN, make_plots = F)
SWGNTCLR_Trend <- compute_all_trends(df_SWGNTCLR, make_plots = F)
SWGNTCLRCLN_Trend <- compute_all_trends(df_SWGNTCLRCLN, make_plots = F)
CLDHGH_Trend <- compute_all_trends(df_CLDHGH, make_plots = F)
CLDMID_Trend <- compute_all_trends(df_CLDMID, make_plots = F)
CLDLOW_Trend <- compute_all_trends(df_CLDLOW, make_plots = F)
GRN_Trend <- compute_all_trends(df_GRN, make_plots = F)

# Calculate Descriptive Statistics
TAS_Stat <- desc_stat(TAS_Trend)
AOD_Stat <- desc_stat(AOD_Trend)
SWL_Stat <- desc_stat(SWL_Trend)
LWL_Stat <- desc_stat(LWL_Trend)
LHL_Stat <- desc_stat(LHL_Trend)
CLOUD_Stat <- desc_stat(CLOUD_Trend)
DUSTEX_Stat <- desc_stat(DUSTEX_Trend)
DUSCAT_Stat <- desc_stat(DUSCAT_Trend)
GWT_Stat <- desc_stat(GWT_Trend)
LAI_Stat <- desc_stat(LAI_Trend)
DTDTLWR_Stat <- desc_stat(DTDTLWR_Trend)
DTDTSWR_Stat <- desc_stat(DTDTSWR_Trend)
DTDTLWRCLR_Stat <- desc_stat(DTDTLWRCLR_Trend)
DTDTSWRCLR_Stat <- desc_stat(DTDTSWRCLR_Trend)
LWGNT_Stat <- desc_stat(LWGNT_Trend)
LWGNTCLR_Stat <- desc_stat(LWGNTCLR_Trend)
LWGNTCLRCLN_Stat <- desc_stat(LWGNTCLRCLN_Trend)
SWGNT_Stat <- desc_stat(SWGNT_Trend)
SWGNTCLN_Stat <- desc_stat(SWGNTCLN_Trend)
SWGNTCLR_Stat <- desc_stat(SWGNTCLR_Trend)
SWGNTCLRCLN_Stat <- desc_stat(SWGNTCLRCLN_Trend)
CLDHGH_Stat <- desc_stat(CLDHGH_Trend)
CLDMID_Stat <- desc_stat(CLDMID_Trend)
CLDLOW_Stat <- desc_stat(CLDLOW_Trend)
GRN_Stat <- desc_stat(GRN_Trend)


# Run ITS_Analysis for BEST DATA for Grid with Greatest Magnitude Difference
index <- which.max(TAS_Trend$trend_diff$trend)

lon_max <- TAS_Trend$trend_diff$lon[index]
lat_max <- TAS_Trend$trend_diff$lat[index]

ITS_lon_index <- which.min(abs(df_TAS$lon - lon_max))
ITS_lat_index <- which.min(abs(df_TAS$lat - lat_max))

ITS_analysis(ITS_lon_index,ITS_lat_index,df_TAS$years,df_TAS$annual)

# Re-format into a data frame

# TAS
df_two_maps_TAS <- data.frame(
  lon        = TAS_Trend$trend_before$lon,
  lat        = TAS_Trend$trend_before$lat,
  trend_pre  = TAS_Trend$trend_before$trend,
  trend_post = TAS_Trend$trend_after$trend,
  pval = TAS_Trend$pvalues$pval
)
df_one_map_TAS <- data.frame(
  lon = TAS_Trend$full_trend$lon,
  lat = TAS_Trend$full_trend$lat,
  full_trend = TAS_Trend$full_trend$trend,
  pval = TAS_Trend$pvalues$pval
)
df_one_map_diff_TAS <- data.frame(
  lon = TAS_Trend$trend_diff$lon,
  lat = TAS_Trend$trend_diff$lat,
  trend_diff = TAS_Trend$trend_diff$trend,
  pval = TAS_Trend$pvalues$pval
)
# AOD
df_two_maps_AOD <- data.frame(
  lon        = AOD_Trend$trend_before$lon,
  lat        = AOD_Trend$trend_before$lat,
  trend_pre  = AOD_Trend$trend_before$trend,
  trend_post = AOD_Trend$trend_after$trend,
  pval = AOD_Trend$pvalues$pval
)
df_one_map_AOD <- data.frame(
  lon = AOD_Trend$full_trend$lon,
  lat = AOD_Trend$full_trend$lat,
  full_trend = AOD_Trend$full_trend$trend,
  pval = AOD_Trend$pvalues$pval
)
# SWLAND
df_two_maps_SWL <- data.frame(
  lon        = SWL_Trend$trend_before$lon,
  lat        = SWL_Trend$trend_before$lat,
  trend_pre  = SWL_Trend$trend_before$trend,
  trend_post = SWL_Trend$trend_after$trend,
  pval = SWL_Trend$pvalues$pval
)
df_one_map_SWL <- data.frame(
  lon = SWL_Trend$full_trend$lon,
  lat = SWL_Trend$full_trend$lat,
  full_trend = SWL_Trend$full_trend$trend,
  pval = SWL_Trend$pvalues$pval
)
# LWLAND
df_two_maps_LWL <- data.frame(
  lon        = LWL_Trend$trend_before$lon,
  lat        = LWL_Trend$trend_before$lat,
  trend_pre  = LWL_Trend$trend_before$trend,
  trend_post = LWL_Trend$trend_after$trend,
  pval = LWL_Trend$pvalues$pval
)
df_one_map_LWL <- data.frame(
  lon = LWL_Trend$full_trend$lon,
  lat = LWL_Trend$full_trend$lat,
  full_trend = LWL_Trend$full_trend$trend,
  pval = LWL_Trend$pvalues$pval
)
# LHLAND
df_two_maps_LHL <- data.frame(
  lon        = LHL_Trend$trend_before$lon,
  lat        = LHL_Trend$trend_before$lat,
  trend_pre  = LHL_Trend$trend_before$trend,
  trend_post = LHL_Trend$trend_after$trend
)
df_one_map_LHL <- data.frame(
  lon = LHL_Trend$full_trend$lon,
  lat = LHL_Trend$full_trend$lat,
  full_trend = LHL_Trend$full_trend$trend
)
# CLOUD
df_two_maps_CLOUD <- data.frame(
  lon        = CLOUD_Trend$trend_before$lon,
  lat        = CLOUD_Trend$trend_before$lat,
  trend_pre  = CLOUD_Trend$trend_before$trend,
  trend_post = CLOUD_Trend$trend_after$trend,
  pval = CLOUD_Trend$pvalues$pval
)
df_one_map_CLOUD <- data.frame(
  lon = CLOUD_Trend$full_trend$lon,
  lat = CLOUD_Trend$full_trend$lat,
  full_trend = CLOUD_Trend$full_trend$trend,
  pval = CLOUD_Trend$pvalues$pval
)
# DUSTEX
df_two_maps_DUSTEX <- data.frame(
  lon        = DUSTEX_Trend$trend_before$lon,
  lat        = DUSTEX_Trend$trend_before$lat,
  trend_pre  = DUSTEX_Trend$trend_before$trend,
  trend_post = DUSTEX_Trend$trend_after$trend
)
df_one_map_DUSTEX <- data.frame(
  lon = DUSTEX_Trend$full_trend$lon,
  lat = DUSTEX_Trend$full_trend$lat,
  full_trend = DUSTEX_Trend$full_trend$trend
)
# DUSCAT
df_two_maps_DUSCAT <- data.frame(
  lon        = DUSCAT_Trend$trend_before$lon,
  lat        = DUSCAT_Trend$trend_before$lat,
  trend_pre  = DUSCAT_Trend$trend_before$trend,
  trend_post = DUSCAT_Trend$trend_after$trend
)
df_one_map_DUSCAT <- data.frame(
  lon = DUSCAT_Trend$full_trend$lon,
  lat = DUSCAT_Trend$full_trend$lat,
  full_trend = DUSCAT_Trend$full_trend$trend
)
# GWETTOP
df_two_maps_GWT <- data.frame(
  lon        = GWT_Trend$trend_before$lon,
  lat        = GWT_Trend$trend_before$lat,
  trend_pre  = GWT_Trend$trend_before$trend,
  trend_post = GWT_Trend$trend_after$trend,
  pval = GWT_Trend$pvalues$pval
)
df_one_map_GWT <- data.frame(
  lon = GWT_Trend$full_trend$lon,
  lat = GWT_Trend$full_trend$lat,
  full_trend = GWT_Trend$full_trend$trend,
  pval = GWT_Trend$pvalues$pval
)
df_one_map_diff_GWT <- data.frame(
  lon = GWT_Trend$trend_diff$lon,
  lat = GWT_Trend$trend_diff$lat,
  trend_diff = GWT_Trend$trend_diff$trend,
  pval = GWT_Trend$pvalues$pval
)
# LAI
df_two_maps_LAI <- data.frame(
  lon        = LAI_Trend$trend_before$lon,
  lat        = LAI_Trend$trend_before$lat,
  trend_pre  = LAI_Trend$trend_before$trend,
  trend_post = LAI_Trend$trend_after$trend,
  pval = LAI_Trend$pvalues$pval
)
df_one_map_LAI <- data.frame(
  lon = LAI_Trend$full_trend$lon,
  lat = LAI_Trend$full_trend$lat,
  full_trend = LAI_Trend$full_trend$trend,
  pval = LAI_Trend$pvalues$pval
)
df_one_map_diff_LAI <- data.frame(
  lon = LAI_Trend$trend_diff$lon,
  lat = LAI_Trend$trend_diff$lat,
  trend_diff = LAI_Trend$trend_diff$trend,
  pval = LAI_Trend$pvalues$pval
)
# DTDTLWR 
df_two_maps_DTDTLWR <- data.frame(
  lon        = DTDTLWR_Trend$trend_before$lon,
  lat        = DTDTLWR_Trend$trend_before$lat,
  trend_pre  = DTDTLWR_Trend$trend_before$trend,
  trend_post = DTDTLWR_Trend$trend_after$trend
)
df_one_map_DTDTLWR <- data.frame(
  lon = DTDTLWR_Trend$full_trend$lon,
  lat = DTDTLWR_Trend$full_trend$lat,
  full_trend = DTDTLWR_Trend$full_trend$trend
)
df_one_map_diff_DTDTLWR <- data.frame(
  lon = DTDTLWR_Trend$trend_diff$lon,
  lat = DTDTLWR_Trend$trend_diff$lat,
  trend_diff = DTDTLWR_Trend$trend_diff$trend
)
#DTDTSWR
df_two_maps_DTDTSWR <- data.frame(
  lon        = DTDTSWR_Trend$trend_before$lon,
  lat        = DTDTSWR_Trend$trend_before$lat,
  trend_pre  = DTDTSWR_Trend$trend_before$trend,
  trend_post = DTDTSWR_Trend$trend_after$trend
)
df_one_map_DTDTSWR <- data.frame(
  lon = DTDTSWR_Trend$full_trend$lon,
  lat = DTDTSWR_Trend$full_trend$lat,
  full_trend = DTDTSWR_Trend$full_trend$trend
)
df_one_map_diff_DTDTSWR <- data.frame(
  lon = DTDTSWR_Trend$trend_diff$lon,
  lat = DTDTSWR_Trend$trend_diff$lat,
  trend_diff = DTDTSWR_Trend$trend_diff$trend
)
# DTDTLWRCLR
df_two_maps_DTDTLWRCLR <- data.frame(
  lon        = DTDTLWRCLR_Trend$trend_before$lon,
  lat        = DTDTLWRCLR_Trend$trend_before$lat,
  trend_pre  = DTDTLWRCLR_Trend$trend_before$trend,
  trend_post = DTDTLWRCLR_Trend$trend_after$trend
)
df_one_map_DTDTLWRCLR <- data.frame(
  lon = DTDTLWRCLR_Trend$full_trend$lon,
  lat = DTDTLWRCLR_Trend$full_trend$lat,
  full_trend = DTDTLWRCLR_Trend$full_trend$trend
)
df_one_map_diff_DTDTLWRCLR <- data.frame(
  lon = DTDTLWRCLR_Trend$trend_diff$lon,
  lat = DTDTLWRCLR_Trend$trend_diff$lat,
  trend_diff = DTDTLWRCLR_Trend$trend_diff$trend
)
# DTDTSWRCLR
df_two_maps_DTDTSWRCLR <- data.frame(
  lon        = DTDTSWRCLR_Trend$trend_before$lon,
  lat        = DTDTSWRCLR_Trend$trend_before$lat,
  trend_pre  = DTDTSWRCLR_Trend$trend_before$trend,
  trend_post = DTDTSWRCLR_Trend$trend_after$trend
)
df_one_map_DTDTSWRCLR <- data.frame(
  lon = DTDTSWRCLR_Trend$full_trend$lon,
  lat = DTDTSWRCLR_Trend$full_trend$lat,
  full_trend = DTDTSWRCLR_Trend$full_trend$trend
)
df_one_map_diff_DTDTSWRCLR <- data.frame(
  lon = DTDTSWRCLR_Trend$trend_diff$lon,
  lat = DTDTSWRCLR_Trend$trend_diff$lat,
  trend_diff = DTDTSWRCLR_Trend$trend_diff$trend
)
# LWGNT
df_two_maps_LWGNT <- data.frame(
  lon        = LWGNT_Trend$trend_before$lon,
  lat        = LWGNT_Trend$trend_before$lat,
  trend_pre  = LWGNT_Trend$trend_before$trend,
  trend_post = LWGNT_Trend$trend_after$trend,
  pval = LWGNT_Trend$pvalues$pval
)
df_one_map_LWGNT <- data.frame(
  lon = LWGNT_Trend$full_trend$lon,
  lat = LWGNT_Trend$full_trend$lat,
  full_trend = LWGNT_Trend$full_trend$trend,
  pval = LWGNT_Trend$pvalues$pval
)
df_one_map_diff_LWGNT <- data.frame(
  lon = LWGNT_Trend$trend_diff$lon,
  lat = LWGNT_Trend$trend_diff$lat,
  trend_diff = LWGNT_Trend$trend_diff$trend,
  pval = LWGNT_Trend$pvalues$pval
)
# LWGNTCLR 
df_two_maps_LWGNTCLR <- data.frame(
  lon        = LWGNTCLR_Trend$trend_before$lon,
  lat        = LWGNTCLR_Trend$trend_before$lat,
  trend_pre  = LWGNTCLR_Trend$trend_before$trend,
  trend_post = LWGNTCLR_Trend$trend_after$trend,
  pval = LWGNTCLR_Trend$pvalues$pval
)
df_one_map_LWGNTCLR <- data.frame(
  lon = LWGNTCLR_Trend$full_trend$lon,
  lat = LWGNTCLR_Trend$full_trend$lat,
  full_trend = LWGNTCLR_Trend$full_trend$trend,
  pval = LWGNTCLR_Trend$pvalues$pval
)
df_one_map_diff_LWGNTCLR <- data.frame(
  lon = LWGNTCLR_Trend$trend_diff$lon,
  lat = LWGNTCLR_Trend$trend_diff$lat,
  trend_diff = LWGNTCLR_Trend$trend_diff$trend,
  pval = LWGNTCLR_Trend$pvalues$pval
)
# LWGNTCLRCLN
df_two_maps_LWGNTCLRCLN <- data.frame(
  lon        = LWGNTCLRCLN_Trend$trend_before$lon,
  lat        = LWGNTCLRCLN_Trend$trend_before$lat,
  trend_pre  = LWGNTCLRCLN_Trend$trend_before$trend,
  trend_post = LWGNTCLRCLN_Trend$trend_after$trend,
  pval = LWGNTCLRCLN_Trend$pvalues$pval
)
df_one_map_LWGNTCLRCLN <- data.frame(
  lon = LWGNTCLRCLN_Trend$full_trend$lon,
  lat = LWGNTCLRCLN_Trend$full_trend$lat,
  full_trend = LWGNTCLRCLN_Trend$full_trend$trend,
  pval = LWGNTCLRCLN_Trend$pvalues$pval
)
df_one_map_diff_LWGNTCLRCLN <- data.frame(
  lon = LWGNTCLRCLN_Trend$trend_diff$lon,
  lat = LWGNTCLRCLN_Trend$trend_diff$lat,
  trend_diff = LWGNTCLRCLN_Trend$trend_diff$trend,
  pval = LWGNTCLRCLN_Trend$pvalues$pval
)
# SWGNT
df_two_maps_SWGNT <- data.frame(
  lon        = SWGNT_Trend$trend_before$lon,
  lat        = SWGNT_Trend$trend_before$lat,
  trend_pre  = SWGNT_Trend$trend_before$trend,
  trend_post = SWGNT_Trend$trend_after$trend,
  pval = SWGNT_Trend$pvalues$pval
)
df_one_map_SWGNT <- data.frame(
  lon = SWGNT_Trend$full_trend$lon,
  lat = SWGNT_Trend$full_trend$lat,
  full_trend = SWGNT_Trend$full_trend$trend,
  pval = SWGNT_Trend$pvalues$pval
)
df_one_map_diff_SWGNT <- data.frame(
  lon = SWGNT_Trend$trend_diff$lon,
  lat = SWGNT_Trend$trend_diff$lat,
  trend_diff = SWGNT_Trend$trend_diff$trend,
  pval = SWGNT_Trend$pvalues$pval
)
# SWGNTCLN
df_two_maps_SWGNTCLN <- data.frame(
  lon        = SWGNTCLN_Trend$trend_before$lon,
  lat        = SWGNTCLN_Trend$trend_before$lat,
  trend_pre  = SWGNTCLN_Trend$trend_before$trend,
  trend_post = SWGNTCLN_Trend$trend_after$trend,
  pval = SWGNTCLN_Trend$pvalues$pval
)
df_one_map_SWGNTCLN <- data.frame(
  lon = SWGNTCLN_Trend$full_trend$lon,
  lat = SWGNTCLN_Trend$full_trend$lat,
  full_trend = SWGNTCLN_Trend$full_trend$trend,
  pval = SWGNTCLN_Trend$pvalues$pval
)
df_one_map_diff_SWGNTCLN <- data.frame(
  lon = SWGNTCLN_Trend$trend_diff$lon,
  lat = SWGNTCLN_Trend$trend_diff$lat,
  trend_diff = SWGNTCLN_Trend$trend_diff$trend,
  pval = SWGNTCLN_Trend$pvalues$pval
)
# SWGNTCLR 
df_two_maps_SWGNTCLR <- data.frame(
  lon        = SWGNTCLR_Trend$trend_before$lon,
  lat        = SWGNTCLR_Trend$trend_before$lat,
  trend_pre  = SWGNTCLR_Trend$trend_before$trend,
  trend_post = SWGNTCLR_Trend$trend_after$trend,
  pval = SWGNTCLR_Trend$pvalues$pval
)
df_one_map_SWGNTCLR <- data.frame(
  lon = SWGNTCLR_Trend$full_trend$lon,
  lat = SWGNTCLR_Trend$full_trend$lat,
  full_trend = SWGNTCLR_Trend$full_trend$trend,
  pval = SWGNTCLR_Trend$pvalues$pval
)
df_one_map_diff_SWGNTCLR <- data.frame(
  lon = SWGNTCLR_Trend$trend_diff$lon,
  lat = SWGNTCLR_Trend$trend_diff$lat,
  trend_diff = SWGNTCLR_Trend$trend_diff$trend,
  pval = SWGNTCLR_Trend$pvalues$pval
)
# SWGNTCLRCLN
df_two_maps_SWGNTCLRCLN <- data.frame(
  lon        = SWGNTCLRCLN_Trend$trend_before$lon,
  lat        = SWGNTCLRCLN_Trend$trend_before$lat,
  trend_pre  = SWGNTCLRCLN_Trend$trend_before$trend,
  trend_post = SWGNTCLRCLN_Trend$trend_after$trend,
  pval = SWGNTCLRCLN_Trend$pvalues$pval
)
df_one_map_SWGNTCLRCLN <- data.frame(
  lon = SWGNTCLRCLN_Trend$full_trend$lon,
  lat = SWGNTCLRCLN_Trend$full_trend$lat,
  full_trend = SWGNTCLRCLN_Trend$full_trend$trend,
  pval = SWGNTCLRCLN_Trend$pvalues$pval
)
df_one_map_diff_SWGNTCLRCLN <- data.frame(
  lon = SWGNTCLRCLN_Trend$trend_diff$lon,
  lat = SWGNTCLRCLN_Trend$trend_diff$lat,
  trend_diff = SWGNTCLRCLN_Trend$trend_diff$trend,
  pval = SWGNTCLRCLN_Trend$pvalues$pval
)
# CLDHGH 
df_two_maps_CLDHGH <- data.frame(
  lon        = CLDHGH_Trend$trend_before$lon,
  lat        = CLDHGH_Trend$trend_before$lat,
  trend_pre  = CLDHGH_Trend$trend_before$trend,
  trend_post = CLDHGH_Trend$trend_after$trend,
  pval = CLDHGH_Trend$pvalues$pval
)
df_one_map_CLDHGH <- data.frame(
  lon = CLDHGH_Trend$full_trend$lon,
  lat = CLDHGH_Trend$full_trend$lat,
  full_trend = CLDHGH_Trend$full_trend$trend,
  pval = CLDHGH_Trend$pvalues$pval
)
df_one_map_diff_CLDHGH <- data.frame(
  lon = CLDHGH_Trend$trend_diff$lon,
  lat = CLDHGH_Trend$trend_diff$lat,
  trend_diff = CLDHGH_Trend$trend_diff$trend,
  pval = CLDHGH_Trend$pvalues$pval
)
# CLDLOW 
df_two_maps_CLDLOW <- data.frame(
  lon        = CLDLOW_Trend$trend_before$lon,
  lat        = CLDLOW_Trend$trend_before$lat,
  trend_pre  = CLDLOW_Trend$trend_before$trend,
  trend_post = CLDLOW_Trend$trend_after$trend,
  pval = CLDLOW_Trend$pvalues$pval
)
df_one_map_CLDLOW <- data.frame(
  lon = CLDLOW_Trend$full_trend$lon,
  lat = CLDLOW_Trend$full_trend$lat,
  full_trend = CLDLOW_Trend$full_trend$trend,
  pval = CLDLOW_Trend$pvalues$pval
)
df_one_map_diff_CLDLOW <- data.frame(
  lon = CLDLOW_Trend$trend_diff$lon,
  lat = CLDLOW_Trend$trend_diff$lat,
  trend_diff = CLDLOW_Trend$trend_diff$trend,
  pval = CLDLOW_Trend$pvalues$pval
)
# CLDMID
df_two_maps_CLDMID <- data.frame(
  lon        = CLDMID_Trend$trend_before$lon,
  lat        = CLDMID_Trend$trend_before$lat,
  trend_pre  = CLDMID_Trend$trend_before$trend,
  trend_post = CLDMID_Trend$trend_after$trend,
  pval = CLDMID_Trend$pvalues$pval
)
df_one_map_CLDMID <- data.frame(
  lon = CLDMID_Trend$full_trend$lon,
  lat = CLDMID_Trend$full_trend$lat,
  full_trend = CLDMID_Trend$full_trend$trend,
  pval = CLDMID_Trend$pvalues$pval
)
df_one_map_diff_CLDMID <- data.frame(
  lon = CLDMID_Trend$trend_diff$lon,
  lat = CLDMID_Trend$trend_diff$lat,
  trend_diff = CLDMID_Trend$trend_diff$trend,
  pval = CLDMID_Trend$pvalues$pval
)
# TAUHGH 
df_two_maps_TAUHGH <- data.frame(
  lon        = TAUHGH_Trend$trend_before$lon,
  lat        = TAUHGH_Trend$trend_before$lat,
  trend_pre  = TAUHGH_Trend$trend_before$trend,
  trend_post = TAUHGH_Trend$trend_after$trend,
  pval = TAUHGH_Trend$pvalues$pval
)
df_one_map_TAUHGH <- data.frame(
  lon = TAUHGH_Trend$full_trend$lon,
  lat = TAUHGH_Trend$full_trend$lat,
  full_trend = TAUHGH_Trend$full_trend$trend,
  pval = TAUHGH_Trend$pvalues$pval
)
df_one_map_diff_TAUHGH <- data.frame(
  lon = TAUHGH_Trend$trend_diff$lon,
  lat = TAUHGH_Trend$trend_diff$lat,
  trend_diff = TAUHGH_Trend$trend_diff$trend,
  pval = TAUHGH_Trend$pvalues$pval
)
# TAULOW
# TAUMID 
# GRN 
df_two_maps_GRN <- data.frame(
  lon        = GRN_Trend$trend_before$lon,
  lat        = GRN_Trend$trend_before$lat,
  trend_pre  = GRN_Trend$trend_before$trend,
  trend_post = GRN_Trend$trend_after$trend,
  pval = GRN_Trend$pvalues$pval
)
df_one_map_GRN <- data.frame(
  lon = GRN_Trend$full_trend$lon,
  lat = GRN_Trend$full_trend$lat,
  full_trend = GRN_Trend$full_trend$trend,
  pval = GRN_Trend$pvalues$pval
)
df_one_map_diff_GRN <- data.frame(
  lon = GRN_Trend$trend_diff$lon,
  lat = GRN_Trend$trend_diff$lat,
  trend_diff = GRN_Trend$trend_diff$trend,
  pval = GRN_Trend$pvalues$pval
)


# Plot All Vars

# TAS
two_maps(df_two_maps_TAS)
one_map(df_one_map_TAS, title = "Mexico Warming (1980-2025)")
one_map_diff(df_one_map_diff_TAS, title = "Magnitude of the Difference in Mexico Warming Pre- and Post-2010")

# AOD
two_maps(df_two_maps_AOD, title_pre = "(a) Pre-2010 AOD", title_post = "(b) Post-2010 AOD", unit_val = expression(yr^{-1}))
one_map(df_one_map_AOD, title = "Aerosol Optical Depth (1980-2025)", units = expression(yr^{-1}))
# SWLAND
two_maps(df_two_maps_SWL, unit_val = "W/m²/yr", title_pre = "(a) Pre-2010 Radiation", title_post = "(b) Post-2010 Radiation")
one_map(df_one_map_SWL, title = "Net Shortwave Radiation (1980-2025)", units = "W/m²/yr")
# LWLAND
two_maps(df_two_maps_LWL, unit_val = "W/m²/yr", title_pre = "(a) Pre-2010 Radiation", title_post = "(b) Post-2010 Radiation")
one_map(df_one_map_LWL, title = "Net Longwave Radiation (1980-2025)", units = "W/m²/yr")
# LHLAND
two_maps(df_two_maps_LHL)
one_map(df_one_map_LHL, title = "Mexico Warming (1980-2025)")
# CLOUD
two_maps(df_two_maps_CLOUD, title_pre = "(a) Pre-2010 Cloud Fraction", title_post = "(b) Post-2010 Cloud Fraction", 
         unit_val = expression(yr^{-1}))
one_map(df_one_map_CLOUD, title = "Cloud Fraction (1980–2025)", units = expression(yr^{-1}))
# DUEXTFM
two_maps(df_two_maps_DUSTEX)
one_map(df_one_map_DUSTEX, title = "Mexico Warming (1980-2025)")
# DUSCATFM
two_maps(df_two_maps_DUSCAT, title_pre = "(a) Pre-2010 Scattering", title_post = "(b) Post-2010 Scattering",
         unit_val = expression(yr^{-1}))
one_map(df_one_map_DUSCAT, title = "Dust Scattering AOT (1980-2025)", units = expression(yr^{-1}))
# GWETTOP
two_maps(df_two_maps_GWT, title_pre = "(a) Pre-2010 Soil Wetness", title_post = "(b) Post-2010 Soil Wetness",
         unit_val = expression(yr^{-1}))
one_map(df_one_map_GWT, title = "Surface Soil Wetness (1980-2025)", units = expression(yr^{-1}))
one_map_diff(df_one_map_diff_GWT, title = "")
# LAI
two_maps(df_two_maps_LAI, title_pre = "(a) Pre-2010", title_post = "(b) Post-2010",
         unit_val = expression(yr^{-1}))
one_map(df_one_map_LAI, title = "(1980-2025)", units = expression(yr^{-1}))
one_map_diff(df_one_map_diff_LAI, title = "")
# DTDTLWR
two_maps(df_two_maps_DTDTLWR, title_pre = "(a) Pre-2010", title_post = "(b) Post-2010",
         unit_val = expression(yr^{-1}))
one_map(df_one_map_DTDTLWR, title = "(1980-2025)", units = expression(yr^{-1}))
one_map_diff(df_one_map_diff_DTDTLWR, title = "")
# DTDTSWR
two_maps(df_two_maps_DTDTSWR, title_pre = "(a) Pre-2010", title_post = "(b) Post-2010",
         unit_val = expression(yr^{-1}))
one_map(df_one_map_DTDTSWR, title = "(1980-2025)", units = expression(yr^{-1}))
one_map_diff(df_one_map_diff_DTDTSWR, title = "")
# DTDTLWRCLR
two_maps(df_two_maps_DTDTLWRCLR, title_pre = "(a) Pre-2010", title_post = "(b) Post-2010",
         unit_val = expression(yr^{-1}))
one_map(df_one_map_DTDTLWRCLR, title = "(1980-2025)", units = expression(yr^{-1}))
one_map_diff(df_one_map_diff_DTDTLWRCLR, title = "")
# DTDTSWRCLR
two_maps(df_two_maps_DTDTSWRCLR, title_pre = "(a) Pre-2010", title_post = "(b) Post-2010",
         unit_val = "W/m²/yr")
one_map(df_one_map_DTDTSWRCLR, title = "(1980-2025)", units = "W/m²/yr")
one_map_diff(df_one_map_diff_DTDTSWRCLR, title = "")
# LWGNT
two_maps(df_two_maps_LWGNT, title_pre = "(a) Pre-2010", title_post = "(b) Post-2010",
         unit_val = "W/m²/yr")
one_map(df_one_map_LWGNT, title = "(1980-2025)", units = "W/m²/yr")
one_map_diff(df_one_map_diff_LWGNT, title = "")
# LWGNTCLR
two_maps(df_two_maps_LWGNTCLR, title_pre = "(a) Pre-2010", title_post = "(b) Post-2010",
         unit_val = "W/m²/yr")
one_map(df_one_map_LWGNTCLR, title = "(1980-2025)", units = "W/m²/yr")
one_map_diff(df_one_map_diff_LWGNTCLR, title = "")
# LWGNTCLRCLN
two_maps(df_two_maps_LWGNTCLRCLN, title_pre = "(a) Pre-2010", title_post = "(b) Post-2010",
         unit_val = "W/m²/yr")
one_map(df_one_map_LWGNTCLRCLN, title = "(1980-2025)", units = "W/m²/yr")
one_map_diff(df_one_map_diff_LWGNTCLRCLN, title = "")
# SWGNT
two_maps(df_two_maps_SWGNT, title_pre = "(a) Pre-2010 Shortwave Radiation", title_post = "(b) Post-2010 Shortwave Radiation",
         unit_val = "W/m²/yr")
one_map(df_one_map_SWGNT, title = "(1980-2025)", units = "W/m²/yr")
one_map_diff(df_one_map_diff_SWGNT, title = "")
# SWGNTCLN
two_maps(df_two_maps_SWGNTCLN, title_pre = "(a) Pre-2010 Clean Sky (No Aerosols) Radiation", title_post = "(b) Post-2010 Clean Sky (No Aerosols) Radiation",
         unit_val = "W/m²/yr")
one_map(df_one_map_SWGNTCLN, title = "(1980-2025)", units = "W/m²/yr")
one_map_diff(df_one_map_diff_SWGNTCLN, title = "Difference in")
# SWGNTCLR
two_maps(df_two_maps_SWGNTCLR, title_pre = "(a) Pre-2010 Clear Sky (No Clouds) Radiation", title_post = "(b) Post-2010 Clear Sky (No Clouds) Radiation",
         unit_val = "W/m²/yr")
one_map(df_one_map_SWGNTCLR, title = "(1980-2025)", units = "W/m²/yr")
one_map_diff(df_one_map_diff_SWGNTCLR, title = "")
# SWGNTCLRCLN
two_maps(df_two_maps_SWGNTCLRCLN, title_pre = "(a) Pre-2010", title_post = "(b) Post-2010",
         unit_val = "W/m²/yr")
one_map(df_one_map_SWGNTCLRCLN, title = "(1980-2025)", units = "W/m²/yr")
one_map_diff(df_one_map_diff_SWGNTCLRCLN, title = "")
# CLDHGH
two_maps(df_two_maps_CLDHGH, title_pre = "(a) Pre-2010 High Cloud Fraction", title_post = "(b) Post-2010 High Cloud Fraction",
         unit_val = expression(yr^{-1}))
one_map(df_one_map_CLDHGH, title = "High Altitude Cloud Fraction(1980-2025)", units = expression(yr^{-1}))
one_map_diff(df_one_map_diff_CLDHGH, title = "Difference in High Altitude Cloud Fraction")
# CLDMID
two_maps(df_two_maps_CLDMID, title_pre = "(a) Pre-2010", title_post = "(b) Post-2010",
         unit_val = expression(yr^{-1}))
one_map(df_one_map_CLDMID, title = "(1980-2025)", units = expression(yr^{-1}))
one_map_diff(df_one_map_diff_CLDMID, title = "")
# CLDLOW
two_maps(df_two_maps_CLDLOW, title_pre = "(a) Pre-2010 Low Cloud Fraction", title_post = "(b) Post-2010 Low Cloud Fraction",
         unit_val = expression(yr^{-1}))
one_map(df_one_map_CLDLOW, title = "Low Altitude Cloud Fraction (1980-2025)", units = expression(yr^{-1}))
one_map_diff(df_one_map_diff_CLDLOW, title = "Difference in Low Altitude Cloud Fraction")
# GRN 
two_maps(df_two_maps_GRN, title_pre = "(a) Pre-2010", title_post = "(b) Post-2010",
         unit_val = expression(yr^{-1}))
one_map(df_one_map_GRN, title = "(1980-2025)", units = expression(yr^{-1}))
one_map_diff(df_one_map_diff_GRN, title = "")





