print("<----- Add indicators")
add.indicator(
  strategyName,
  name = "EMA",
  arguments = list(x = quote(Cl(timeSeries)), n = 51),
  label = "51.Baseline"
)
# add.indicator(
#   strategyName,
#   name = "EMA",
#   arguments = list(x = quote(Cl(timeSeries)), n = 14),
#   label = "14.Mid"
# )
add.indicator(
  strategyName,
  name = "EMA",
  arguments = list(x = quote(Cl(timeSeries)), n = 5),
  label = "5.Flash"
)
