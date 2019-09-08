print("<----- START Visualize")

svgDev <- svg(paste(strategyName, "trades.svg", sep = "_"), width = 20, height = 8, pointsize = 20)
chart.Posn(Portfolio = portfolioName, Symbol = "timeSeries")


# prevDevice <- dev.cur()
# dev.copy(dev.next)
# dev.set(dev.next())

# dev.copy2pdf(out.type = "pdf", which = prevDevice)
# dev.print(device = dev.cur, width = 6, height = 6, horizontal = TRUE, onefile = TRUE) # prints it

dev.off()
dev.off()

# graphics.off()


print("<----- END")
