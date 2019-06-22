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