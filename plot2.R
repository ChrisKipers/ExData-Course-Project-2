NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltamore.fips <- "24510"

baltamore.emissions <- NEI[NEI$fips == baltamore.fips,]

total.emissions.in.tons.per.year <-
  tapply(baltamore.emissions$Emissions, baltamore.emissions$year, sum)

png("plot2.png")

plot(
  names(total.emissions.in.tons.per.year),
  total.emissions.in.tons.per.year,
  type = "l",
  ylim = c(0, max(total.emissions.in.tons.per.year)),
  xlab = "Year",
  ylab = "PM2.5 in tons",
  main = "Total Emissons in Baltimore City")

dev.off()
