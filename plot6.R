library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

indices.of.vehicle.scc <- grep("vehicle", x = SCC$EI.Sector, ignore.case = TRUE)
scc.codes.for.vehicle <- SCC[indices.of.vehicle.scc,]$SCC

city.by.fips <- list(
  "24510"="Baltamore City",
  "06037"="Los Angeles"
)

fips.labeller <- function(var, val) {
  return(city.by.fips[as.character(val)])
}

total.fuel.emissions.by.year <- NEI %>%
  filter(SCC %in% scc.codes.for.vehicle, fips %in% c("24510", "06037")) %>%
  group_by(year, fips) %>%
  summarize(sum(Emissions)) %>%
  rename(total.emissions = `sum(Emissions)`)

max.total.emission = max(total.fuel.emissions.by.year$total.emissions)

ggplot(
  data = total.fuel.emissions.by.year,
  aes(y=total.emissions, x = year)) +
  geom_point() +
  geom_line() +
  facet_grid(.~fips, labeller = fips.labeller) +
  ylim(0, max.total.emission) + 
  ylab("Emissions in tons") + 
  xlab("Year") +
  ggtitle("Total Emissions Contributed by Motor Vehicles")

ggsave(file = "plot6.png")
