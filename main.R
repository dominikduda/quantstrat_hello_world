source("R/load_packages.R")
source("R/input_utils.R")
source("R/chart_utils.R")
timeSeries <- InputUtils()$normalizedTimeSeries("AUDUSD_5min.csv")


source("R/strat/initialize.R")
source("R/strat/add_indicators.R")

timeSeries <- applyIndicators(strategy = strategyName, mktdata = timeSeries)

source("R/strat/specify.R")

message("<----- Perform simulation START")
test <- applySignals(strategy = strategyName, mktdata = timeSeries)
out <- applyStrategy(strategy = strategyName, portfolios = portfolioName)
message("<----- END")

# Flush new data
updatePortf(portfolioName)
daterange <- time(getPortfolio(portfolioName)$summary)[-1]
updateAcct(accountName, daterange)
updateEndEq(accountName)

tstats <- tradeStats(Portfolios = portfolioName)
tstats %>%
  str() %>%
  print()

source("R/visualize.R")

message("<----- Done!!")
