require(devtools)
library(magrittr)
library(FinancialInstrument)
library(PerformanceAnalytics)
library(quantmod)
library(TTR)
# Github
library(blotter)
library(quantstrat)
library(IKTrading)

prepare_time_for_posix_format <- function(text) {
  return(gsub(".000 GMT+0200", "", text, fixed = TRUE))
}
candles <-
  read.csv(file = "AUDUSD_5min.csv", sep = ",", header = TRUE)
posix_times <- as.POSIXct(candles[, 1], format = '%d.%m.%Y %H:%M:%OS')
time_series <- xts(x = candles[, 2:6], order.by = posix_times)


print('--------> Done!!')