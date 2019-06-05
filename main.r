require(devtools)
library(FinancialInstrument)
library(PerformanceAnalytics)
# Github
library(blotter)
library(quantstrat)

candles <-
  read.csv(file = "AUDUSD_5min.csv", sep = ",", header = TRUE)
# Local.time column need to be reformatted, then follow:
# https://stackoverflow.com/questions/40876400/r-quantstrat-csv-import-for-intra-day-data#answer-40901697
# posix_times <- as.POSIXct(candles[, 1])