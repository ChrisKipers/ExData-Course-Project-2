library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

indices.of.vehicle.scc <- grep("vehicle", x = SCC$EI.Sector, ignore.case = TRUE)
scc.codes.for.vehicle <- SCC[indices.of.vehicle.scc,]$SCC

total.fuel.emissions.by.year <- NEI %>%
  filter(SCC %in% scc.codes.for.vehicle, fips == "24510") %>%
  group_by(year) %>%
  summarize(sum(Emissions)) %>%
  rename(total.emissions = `sum(Emissions)`)

max.total.emission = max(total.fuel.emissions.by.year$total.emissions)

ggplot(
  data = total.fuel.emissions.by.year,
  aes(y=total.emissions, x = year)) +
  geom_point() +
  geom_line() +
  ylim(0, max.total.emission) + 
  ylab("Emissions in tons") + 
  xlab("Year") +
  ggtitle("Total Emissions Contributed by Motor Vehicles in Baltamore City")

ggsave(file = "plot5.png")
