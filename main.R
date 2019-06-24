source("R/load_packages.R")
source("R/input_utils.R")
source("R/chart_utils.R")

timeSeries <- InputUtils()$normalizedTimeSeries("AUDUSD_5min.csv")
ChartUtils()$plotCandles(timeSeries)
timeSeries <- transform(
  timeSeries,
  Open = as.double(Open),
  High = as.double(High),
  Low = as.double(Low),
  Close = as.double(Close)
)
timeSeries <- xts(timeSeries, order.by = timeSeries$Time)

source("R/configure_strat.R")
source("R/add_indicators.R")

timeSeries <- applyIndicators(strategy = strategyName, mktdata = timeSeries)

source("R/specify_strategy.R")

out <- applyStrategy(strategy = strategyName, portfolios = portfolioName)

print("<----- Done!!")
