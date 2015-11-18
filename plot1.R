NEI <- readRDS("summarySCC_PM25.rds")

total.emissions.in.megatons.per.year <-
  tapply(NEI$Emissions, NEI$year, sum) / 10 ^ 6

png("plot1.png")

plot(
  names(total.emissions.in.megatons.per.year),
  total.emissions.in.megatons.per.year,
  type = "l",
  ylim = c(0, max(total.emissions.in.megatons.per.year)),
  xlab = "Year",
  ylab = "PM2.5 in Megatons",
  main = "Total Emissons in the United States")

dev.off()
