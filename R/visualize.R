message("<----- START Visualize")

# Save result chart to temp svg file
tempFile <- tempfile()
svgDev <- svg(tempFile, width = 34, height = 14, pointsize = 20)
chart.Posn(Portfolio = portfolioName, Symbol = "timeSeries",
TA = "add_EMA(n = 51, col = 4)"
)

sma50 <- EMA(x = Cl(timeSeries), n = 50)
add_TA(sma50, on = 1, col = "blue")
dev.off()


    # chart.Posn(portfolio.st, Symbol = symbol,
    #            TA = "add_SMA(n = 10, col = 4); add_SMA(n = 30, col = 2)")

# Convert svg to bitmap and save it as png

random_id <- sample(9, 15, replace = TRUE) %>%
  as.character() %>%
  paste(., collapse = "")
bmp <- rsvg(tempFile, width = 6880, height = 2880)
png::writePNG(bmp, paste(strategyName, "trades", random_id, ".png", sep = "_"), dpi = 500)
graphics.off()

message("<----- END")
