print("<----- START Add trade filters")

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
    formula = "flashAboveBaseline & flashAboveMid & midAboveBaseline",
    cross = TRUE
  ),
  label = "entryLong"
)


add.signal(
  strategyName,
  name = "sigComparison",
  arguments = list(columns = c("EMA.51.Baseline", "EMA.5.Flash")),
  relationship = "gt",
  label = "flashBelowBaseline"
)
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
#   strategyName,
#   name = "sigFormula",
#   arguments = list(formula = "flashAboveBaseline"),
#   relationship = "gt",
#   label = "longEntry"
# )


print("<----- Add trade rules")
add.rule(
  strategyName,
  name = "ruleSignal",
  arguments = list(
    sigcol = "flashBelowBaseline",
    sigval = TRUE,
    orderqty = "all",
    ordertype = "market",
    orderside = "long",
    replace = TRUE,
    prefer = "Open"
  ),
  type = "exit"
)
add.rule(
  strategyName,
  name = "ruleSignal",
  arguments = list(
    sigcol = "entryLong",
    sigval = TRUE,
    orderqty = 10000,
    ordertype = "market",
    orderside = "long",
    replace = TRUE,
    prefer = "Open"
  ),
  type = "enter"
)

print("<----- END")
