message("<----- START Visualize")

# Save result chart to temp svg file
tempFile <- tempfile()
svgDev <- svg(tempFile, width = 34, height = 14, pointsize = 20)
chart.Posn(
  Portfolio = portfolioName, Symbol = "timeSeries",
  TA = "add_EMA(n = 51, col = 'Blue', with.col = Cl)"
)
dev.off()

secondsFromEpoch <- Sys.time() %>% as.numeric()
filePath <- paste(strategyName, "trades", secondsFromEpoch, sep = "_") %>%
  paste(., ".png", sep = "") %>%
  paste("./plots/", ., sep = "")

bmp <- rsvg(tempFile, width = 6880, height = 2880)
png::writePNG(bmp, filePath, dpi = 500)
graphics.off()

# Open new plot
paste("eog", filePath, sep = " ") %>% system()

message("<----- END")
