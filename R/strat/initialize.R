message("<----- START Boilerplate")

initDate <- "1995-01-01"
backtestFrom <- timeSeries[, c("Time")][1]
backtestTo <- timeSeries[, c("Time")][timeSeries %>% nrow()]
Sys.setenv(TZ = "UTC")
currency("USD")
currency("timeSeries", currency = "USD")

print("<---------- Set variables")
initEq <- 160000
tradesize <- 160000
stopLoss <- 0.005
txFee <- -10
baselineEMALength <- 50
midEMALength <- 14
flashEMALength <- 5
strategyName <- "hello_world_strat"
portfolioName <- "hello_world_portfolio"
accountName <- "hello_world_account"

print("<---------- Clean cached strategy, portfolio and account")
rm.strat(strategyName)
suppressWarnings(
  rm(
    "account.hello_world_account",
    "portfolio.hello_world_portfolio",
    pos = .blotter
  )
)
suppressWarnings(rm("order_book.hello_world_portfolio", pos = .strategy))

print("<---------- Initialize portfolio, account, orders and strategy")
initPortf(
  portfolioName,
  symbols = "timeSeries",
  initDate = initDate,
  currency = "USD"
)
initAcct(
  accountName,
  portfolios = portfolioName,
  initDate = initDate,
  currency = "USD",
  initEq = initEq
)
initOrders(portfolioName, initDate = initDate)
strategy(strategyName, store = TRUE)

message("<----- END")
