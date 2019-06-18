source('R/load_packages.R')
source('R/input_utils.R')
source('R/chart_utils.R')

timeSeries <- InputUtils()$normalizedTimeSeries('AUDUSD_5min.csv')
# ChartUtils()$plotCandles(timeSeries)

print(' <- Boilerplate')
initDate <- '1995-01-01'
backtestFrom <- timeSeries[, c('Time')][1]
backtestTo <- timeSeries[, c('Time')][timeSeries %>% nrow]
Sys.setenv(TZ = 'UTC')
currency('USD')
currency('AUD', currency = 'USD')

print(' <- Set acc size and trade size')
initEq <- 20000
tradesize <- 20000

print(' <- Name strategy, portfolio and account')
strategyName <- 'hello_world_strat'
portfolioName <- 'hello_world_portfolio'
accountName <- 'hello_world_account'

print(' <- Clean cached strategy, portfolio and account')
rm.strat(strategyName)
suppressWarnings(
  rm(
    "account.hello_world_account",
    "portfolio.hello_world_portfolio",
    pos = .blotter
  )
)
suppressWarnings(rm("order_book.hello_world_portfolio", pos = .strategy))

print(' <- Initialize portfolio, account, orders and strategy')
initPortf(
  portfolioName,
  symbols = 'AUD',
  initDate = initDate,
  currency = 'USD'
)
initAcct(
  accountName,
  portfolios = portfolioName,
  initDate = initDate,
  currency = 'USD',
  initEq = initEq
)
initOrders(portfolioName, initDate = initDate)
strategy(strategyName, store = TRUE)

print(' <- Add indicators')
add.indicator(
  strategyName,
  name = 'EMA',
  arguments = list(x = timeSeries %>% Cl %>% quote, n = 51),
  label = 'Baseline'
)
add.indicator(
  strategyName,
  name = 'EMA',
  arguments = list(x = timeSeries %>% Cl %>% quote, n = 14),
  label = 'LONG_EMA'
)
add.indicator(
  strategyName,
  name = 'EMA',
  arguments = list(x = timeSeries %>% Cl %>% quote, n = 5),
  label = 'SHORT_EMA'
)

print(' <- Add trade filters')
# TODO

print(' <- Done!!')