print("<----- Add trade filters")
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
  arguments = list(columns = c("EMA.21.Slow", "EMA.51.Baseline")),
  relationship = "gt",
  label = "slowAboveBaseline"
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
  name = "sigCrossover",
  arguments = list(columns = c("EMA.5.Flash", "EMA.14.Mid")),
  relationship = "lt",
  label = "longExit"
)
add.signal(
  strategyName,
  name = "sigFormula",
  arguments = list(formula = "flashAboveBaseline & slowAboveBaseline & flashAboveMid"),
  relationship = "gt",
  label = "longEntry"
)

print("<----- Add trade rules")
add.rule(
  strategyName,
  name = "ruleSignal",
  arguments = list(
    sigcol = "longExit",
    sigval = TRUE,
    orderqty = "all",
    ordertype = "market",
    orderside = "long",
    replace = FALSE,
    prefer = "Open"
  ),
  type = "exit"
)
add.rule(
  strategyName,
  name = "ruleSignal",
  arguments = list(
    sigcol = "longEntry",
    sigval = TRUE,
    orderqty = "all",
    ordertype = "market",
    orderside = "long",
    replace = FALSE,
    prefer = "Open"
  ),
  type = "enter"
)
