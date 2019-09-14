message("<----- START Add indicators")

color <- function(timeSeries) {
  builder <- function(open, close) {
    if (open %>% is.na()) {
      return(0)
    }
    if (as.double(open) < as.double(close)) {
      return(1)
    } else {
      return(0)
    }
  }

  timeSeries <- as.data.frame(timeSeries)
  timeSeries$color <- mapply(
    builder,
    # timeSeries$Open %>% lag(),
    # timeSeries$Close %>% lag()
    timeSeries$Open,
    timeSeries$Close
  )

  colorsVector <- timeSeries$color
  dim(colorsVector) <- c(nrow(timeSeries), 1)
  colnames(colorsVector) <- "lastCandle"
  return(colorsVector)
}

redReversal <- function(timeSeries) {
  builder <- function(open, close, prevOpen, prevClose) {
    if (open %>% is.na()) {
      return(0)
    }
    if (as.double(open) <= as.double(close) && as.double(prevOpen) >= as.double(prevClose)) {
      return(1)
    } else {
      return(0)
    }
  }

  timeSeries <- as.data.frame(timeSeries)
  timeSeries$color <- mapply(
    builder,
    timeSeries$Open %>% lag(),
    timeSeries$Close %>% lag(),
    timeSeries$Open %>% lag(., 2),
    timeSeries$Close %>% lag(., 2)
  )

  colorsVector <- timeSeries$color
  dim(colorsVector) <- c(nrow(timeSeries), 1)
  colnames(colorsVector) <- "lastCandle"
  return(colorsVector)
}

add.indicator(
  strategyName,
  name = "redReversal",
  arguments = list(
    timeSeries = quote(timeSeries)
  ),
  label = "redReversal"
)
add.indicator(
  strategyName,
  name = "color",
  arguments = list(
    timeSeries = quote(timeSeries)
  ),
  label = "color"
)
add.indicator(
  strategyName,
  name = "color",
  arguments = list(
    timeSeries = quote(timeSeries)
  ),
  label = "color"
)
add.indicator(
  strategyName,
  name = "EMA",
  arguments = list(x = quote(Cl(timeSeries)), n = 51),
  label = "51.Baseline"
)
add.indicator(
  strategyName,
  name = "EMA",
  arguments = list(x = quote(Cl(timeSeries)), n = 14),
  label = "14.Mid"
)
add.indicator(
  strategyName,
  name = "EMA",
  arguments = list(x = quote(Cl(timeSeries)), n = 5),
  label = "5.Flash"
)

message("<----- END")
