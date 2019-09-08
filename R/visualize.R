message("<----- START Visualize")

# Save result chart to temp svg file
tempFile <- tempfile()
svgDev <- svg(tempFile, width = 34, height = 14, pointsize = 20)
chart.Posn(Portfolio = portfolioName, Symbol = "timeSeries")
dev.off()

# Convert svg to bitmap and save it as png
bmp <- rsvg(tempFile, width = 6880, height = 2880)
png::writePNG(bmp, paste(strategyName, "trades.png", sep = "_"), dpi = 500)
graphics.off()

message("<----- END")
