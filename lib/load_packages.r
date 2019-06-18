if (!'pacman' %in% installed.packages()) {
  install.packages('pacman')
}
require(pacman)
p_load(FinancialInstrument,
       PerformanceAnalytics,
       TTR,
       devtools,
       dplyr,
       magrittr,
       quantmod)
p_load_gh(
  'IlyaKipnis/IKTrading',
  'braverock/blotter',
  'braverock/quantstrat',
  'dominikduda/candlePlotter'
)