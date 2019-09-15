message("<----- START Visualize")

# Save result chart to temp svg file
tempFile <- tempfile()
svgDev <- svg(tempFile, width = 34, height = 14, pointsize = 20)
chart.Posn(
  Portfolio = portfolioName, Symbol = "timeSeries",
  TA = paste(
    paste("add_EMA(n = ", baselineEMALength, ", col = 'Blue', with.col = Cl)", sep = ""),
    "add_EMA(n = 14, col = 'Yellow', with.col = Cl)",
    "add_EMA(n = 5, col = 'Red',  with.col = Cl)",
    sep = "; "
  )
)
dev.off()

secondsFromEpoch <- Sys.time() %>%
  as.numeric() %>%
  round()
filePath <- paste(strategyName, "trades", secondsFromEpoch, sep = "_") %>%
  paste("./plots/", ., ".png", sep = "")

bmp <- rsvg(tempFile, width = 6880, height = 2880)
png::writePNG(bmp, filePath, dpi = 500)
graphics.off()

# Open new plot
paste("eog", filePath, sep = " ") %>% system()

message("<----- END")
