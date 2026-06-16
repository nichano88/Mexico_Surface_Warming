##########################################
#This file will be used to develop an ITS
#Analysis for the Surface Temp Anomaly
##########################################
library(nlme)
library(DT)
library(AICcmodavg)
library(stringr)
library(tibble)
library(dplyr)
library(ggplot2)

ITS_analysis <- function(x,y,time,tas_array){
  
  ts <- tas_array[x, y, ]
  
  df <- tibble(
    year = time,
    Post.intervention.time = c(rep(0,30),1:16),
    TAS = ts
  )
  
### Fit ITS ARMA(1,1)
  model.b <- gls(
    TAS ~ year + Post.intervention.time,
    data = df,
    correlation = corARMA(p=1, q=1, form = ~ year),
    method = "ML",
    na.action = na.exclude
  )
### Now develop the counter factual model
  df2 <- df
  df2$Post.intervention.time <- 0   # counter factual = no slope change after 2010
  
  df <- df %>% mutate(
    model.b.predictions = predict(model.b),
    model.b.se = predictSE.gls(model.b, newdata = df, se.fit = TRUE)$se,
    model.c.predictions = predictSE.gls(model.b, newdata = df2, se.fit = TRUE)$fit,
    model.c.se = predictSE.gls(model.b, newdata = df2, se.fit = TRUE)$se
  )
  
### Plot the Results !!! ###
ITS_Plot <- ggplot(df,aes(year,TAS)) +
  # Compute the 95% confidence band for the model predictions (2 STD's)
  geom_ribbon(aes(ymin = model.c.predictions - (1.96*model.c.se),
                  ymax = model.c.predictions + (1.96*model.c.se)),
                  fill = "pink") +
  geom_ribbon(aes(ymin = model.b.predictions - (1.96*model.b.se),
                  ymax = model.b.predictions + (1.96*model.b.se)),
                  fill = "lightgreen") +
  geom_point(aes(fill = TAS), 
             size = 4, shape = 21,
             color = "black",
             alpha = 0.9) +
  geom_line(aes(y = model.c.predictions,
                linetype = "Counterfactual",
                color = "Counterfactual")) +
  geom_line(aes(y = model.b.predictions,
                linetype = "ARMA(1,1)",
                color = "ARMA(1,1)")) +
  scale_linetype_manual(values = c("Counterfactual" = "dashed",
                                    "ARMA(1,1)" = "solid")) +
  scale_color_manual(values = c("Counterfactual" = "red",
                                "ARMA(1,1)" = "black")) +
  scale_fill_gradient(
    low = "yellow",
    high = "red",
    name = "Observed Temp Anomaly (°C)"
  ) +
  geom_line(alpha=0.5) +
  labs(
    title = "Interrupted Time Series Analysis: Largest 2010 Warming Shift",
    x = "Year",
    y = "°C",
    linetype = "Model",
    color = "Model"
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(color = "black"),
    panel.background = element_rect(fill = "white", color = NA),
    plot.background  = element_rect(fill = "white", color = NA)#,
    #panel.grid       = element_blank()
  )
  #Return warming trend acceleration/deceleration post 2010
  return(list(
    Plot = ITS_Plot,
    Model_Fit = summary(model.b)
    )
  )
}