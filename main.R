source('R/load_packages.R')
source('R/input_utils.R')
source('R/chart_utils.R')

timeSeries <- InputUtils()$normalizedTimeSeries('AUDUSD_5min.csv')
ChartUtils()$plotCandles(timeSeries)

init_date <- '1995-01-01'
backtest_from <- time_series[, c('Time')][1]
backtest_to <- time_series[, c('Time')][time_series %>% nrow]
Sys.setenv(TZ = 'UTC')
currency('USD')
currency('AUD', currency = 'USD')

initeq <- 20000
tradesize <- 20000
strategy.st <- 'hello_world_strat'
portfolio.st <- 'hello_world_strat'
account.st <- 'hello_world_strat'
rm.strat(strategy.st) # Remove the existing strategy if there is one

print('--------> Done!!')