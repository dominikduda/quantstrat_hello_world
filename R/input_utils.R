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
    timeSeries <- timeSeries[1:3000, ]
    colnames(timeSeries) <- c("Time", "Open", "High", "Low", "Close", "Volume")
    timeSeries <- transform(timeSeries, Time = as.POSIXct(Time, format = "%d.%m.%Y %H:%M:%OS"))
    # Filtering exchange close periods (dukascopy specific apparently)
    timeSeries <- filter(timeSeries, !(Open == High & High == Low & Low == Close))
    return(timeSeries)
  }
)
