priv.normalize <- function(time_series) {
  time_series <- time_series[1:3000,]
  colnames(time_series) <-
    c('Time', 'Open', 'High', 'Low', 'Close', 'Volume')
  time_series <-
    transform(time_series, Time = as.POSIXct(Time, format = '%d.%m.%Y %H:%M:%OS'))
  # Filtering exchange close periods (dukascopy specific apparently)
  time_series <-
    filter(time_series, !(Open == High & High == Low & Low == Close))
  time_series$ema_14 <- EMA(time_series$Close, 14)
  return(time_series)
}

normalized_time_series <- function(file_name) {
  return(read.csv(
    file = file_name,
    sep = ",",
    header = TRUE
  ) %>% priv.normalize)
}
