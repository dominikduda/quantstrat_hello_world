source('R/load_packages.R')
source('R/input_utils.R')
source('R/chart_utils.R')

timeSeries <- InputUtils()$normalizedTimeSeries('AUDUSD_5min.csv')
# ChartUtils()$plotCandles(timeSeries)
timeSeries <- xts(timeSeries, order.by = timeSeries$Time)

print('<----- Boilerplate')
initDate <- '1995-01-01'
backtestFrom <- timeSeries[, c('Time')][1]
backtestTo <- timeSeries[, c('Time')][timeSeries %>% nrow]
Sys.setenv(TZ = 'UTC')
currency('USD')
currency('AUD', currency = 'USD')

print('<----- Set acc size and trade size')
initEq <- 20000
tradesize <- 20000

print('<----- Name strategy, portfolio and account')
strategyName <- 'hello_world_strat'
portfolioName <- 'hello_world_portfolio'
accountName <- 'hello_world_account'

print('<----- Clean cached strategy, portfolio and account')
rm.strat(strategyName)
suppressWarnings(
  rm(
    "account.hello_world_account",
    "portfolio.hello_world_portfolio",
    pos = .blotter
  )
)
suppressWarnings(rm("order_book.hello_world_portfolio", pos = .strategy))

print('<----- Initialize portfolio, account, orders and strategy')
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

print('<----- Add indicators')
add.indicator(
  strategyName,
  name = 'EMA',
  arguments = list(x =  quote(Cl(timeSeries)), n = 51),
  label = '51.Baseline'
)
add.indicator(
  strategyName,
  name = 'EMA',
  arguments = list(x =  quote(Cl(timeSeries)), n = 21),
  label = '21.Slow'
)
add.indicator(
  strategyName,
  name = 'EMA',
  arguments = list(x =  quote(Cl(timeSeries)), n = 14),
  label = '14.Mid'
)
add.indicator(
  strategyName,
  name = 'EMA',
  arguments = list(x =  quote(Cl(timeSeries)), n = 5),
  label = '5.Flash'
)
add.indicator(
  strategyName,
  name = 'ATR',
  arguments = list(
    HLC =
      transform(
        HLC(timeSeries),
        Close = as.numeric(Close),
        Low = as.numeric(Low),
        High = as.numeric(High)
      ),
    n = 14
  ),
  label = 'ATRish'
)
timeSeries$absDiff.EMA2151 <-
  EMA(timeSeries %>% Cl, 21) - EMA(timeSeries %>% Cl, 51) %>% abs

# test <-
#   applyIndicators(strategy = strategyName, mktdata = timeSeries)

print('<----- Add trade filters')
# fliter (longs):
# - when ema21 too close to ema51
# - when ema5 too close to ema51
# - when ema5 too close to ema14
# find % good for market? OR atr part
# TODO

print('<----- Done!!')