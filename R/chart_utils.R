ChartUtils <- setRefClass("ChartUtils")
ChartUtils$methods(
  plotCandles = function(timeSeries) {
    p <- prettyCandlePlot(timeSeries)
    png("candles.png",
      units = "px",
      width = 3000,
      height = 1440
    )
    plot(p)
    ggsave("candles.png",
      limitsize = FALSE
    )
    dev.off()
  }
)
