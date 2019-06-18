plot_candles <- function(time_series) {
  ema_14_layer <- layer(
    geom = "line",
    mapping = aes(x = Time, y = ema_14),
    stat = 'identity',
    position = 'identity',
    params = list(color = '#f2ff00')
  )

  p <- prettyCandlePlot(time_series, under_candles_layers = c(ema_14_layer))
  png('candles.png',
      units = "px",
      width = 3000,
      height = 1440)
  plot(p)
  ggsave('candles.png',
         limitsize = FALSE)
  dev.off()
}
