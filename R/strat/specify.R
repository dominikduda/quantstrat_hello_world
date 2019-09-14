message("<----- START Add trade signals")

# Long entry:
add.signal(
  strategyName,
  name = "sigComparison",
  arguments = list(columns = c("EMA.5.Flash", "EMA.51.Baseline")),
  relationship = "gt",
  label = "flashAboveBaseline"
)
add.signal(
  strategyName,
  name = "sigComparison",
  arguments = list(columns = c("EMA.5.Flash", "EMA.14.Mid")),
  relationship = "gt",
  label = "flashAboveMid"
)
add.signal(
  strategyName,
  name = "sigComparison",
  arguments = list(columns = c("EMA.14.Mid", "EMA.51.Baseline")),
  relationship = "gt",
  label = "midAboveBaseline"
)
add.signal(strategyName,
  name = "sigFormula",
  arguments = list(
    formula = "flashAboveBaseline & flashAboveMid & midAboveBaseline & lastCandle.color",
    cross = TRUE
  ),
  label = "entryLong"
)


# add.signal(
#   strategyName,
#   name = "sigComparison",
#   arguments = list(columns = c("EMA.51.Baseline", "EMA.5.Flash")),
#   relationship = "gt",
#   label = "flashBelowBaseline"
# )
# add.signal(strategyName,
#   name = "sigFormula",
#   arguments = list(
#     formula = "lastCandle.color",
#     cross = TRUE
#   ),
#   label = "exitLong"
# )

# add.signal(
#   strategyName,
#   name = "sigComparison",
#   arguments = list(columns = c("EMA.51.Baseline", "EMA.5.Flash")),
#   relationship = "gt",
#   label = "candleTurnedRed"
# )
# add.signal(
#   strategyName,
#   name = "sigComparison",
#   arguments = list(columns = c("EMA.21.Slow", "EMA.51.Baseline")),
#   relationship = "gt",
#   label = "slowAboveBaseline"
# )
# add.signal(
#   strategyName,
#   name = "sigComparison",
#   arguments = list(columns = c("EMA.5.Flash", "EMA.14.Mid")),
#   relationship = "gt",
#   label = "flashAboveMid"
# )
# add.signal(
#   strategyName,
#   name = "sigCrossover",
#   arguments = list(columns = c("EMA.5.Flash", "EMA.14.Mid")),
#   relationship = "lt",
#   label = "longExit"
# )
# add.signal(
#   name = "sigFormula",
#   strategyName,
#   arguments = list(formula = "flashAboveBaseline"),
#   relationship = "gt",
#   label = "longEntry"
# )
# add.signal(strategyName,
#   name = "sigFormula",
#   arguments = list(
#     formula = "lastCandle.color",
#     cross = TRUE
#   ),
#   label = "exitLong"
# )
message("<----- END")


message("<----- Add trade rules")
# add.rule(
#   strategyName,
#   name = "ruleSignal",
#   arguments = list(
#     sigcol = "lastCandle.color",
#     sigval = 0,
#     orderqty = "all",
#     ordertype = "market",
#     orderside = "long",
#     replace = TRUE,
#     prefer = "Open"
#   ),
#   type = "exit"
# )
add.rule(
  strategyName,
  name = "ruleSignal",
  arguments = list(
    sigcol = "entryLong",
    sigval = TRUE,
    orderqty = 10000,
    ordertype = "market",
    orderside = "long",
    replace = FALSE,
    prefer = "Open",
    orderset = "ocolong"
  ),
  type = "enter",
  label = "longEntry"
)
add.rule(strategyName,
  name = "ruleSignal",
  arguments = list(
    sigcol = "entryLong",
    sigval = TRUE,
    replace = FALSE,
    orderside = "long",
    ordertype = "stoplimit",
    # tmult = TRUE,
    # threshold = quote(stopLoss),
    threshold = -0.001,
    TxnFees = txFee,
    orderqty = -10000,
    orderset = "ocoLongExit"
  ),
  type = "chain",
  parent = "longEntry",
  label = "StopLossLONG",
  enabled = TRUE
)
trailingStopPercent <- 0.001
add.rule(strategyName,
  name = "ruleSignal",
  arguments = list(
    sigcol = "entryLong",
    sigval = TRUE,
    replace = FALSE,
    orderside = "long",
    ordertype = "stoptrailing",
    # tmult = TRUE,
    # threshold = quote(stopLoss),
    threshold = trailingStopPercent,
    TxnFees = txFee,
    orderqty = 'all',
    orderset = "xxx"
  ),
  type = "chain",
  parent = "longEntry",
  label = "StopLossLONG",
  enabled = TRUE
)



message("<----- END")
