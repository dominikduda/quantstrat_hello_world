InputUtils <- setRefClass("InputUtils")
InputUtils$methods(
  normalizedTimeSeries = function(fileName) {
    return(read.csv(
      file = fileName,
      sep = ",",
      header = TRUE
    ) %>% p.normalize(.))
  },

  p.normalize = function(timeSeries) {
    timeSeries <- timeSeries[1:1000, ]
    colnames(timeSeries) <- c("Time", "Open", "High", "Low", "Close", "Volume")
    print(colnames(timeSeries))

    timeSeries <- transform(
      timeSeries[, -1],
      Time = as.POSIXct(timeSeries$Time, format = "%d.%m.%Y %H:%M:%OS")
    )

    # Filtering exchange close periods (dukascopy specific apparently)
    timeSeries <- filter(timeSeries, !(Open == High & High == Low & Low == Close))
    timeSeries <- xts(
      timeSeries,
      order.by = timeSeries$Time, format = "%d.%m.%Y %H:%M:%OS"
    )
    return(timeSeries)
  }
)
