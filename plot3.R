library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

total.emissons.by.type <- NEI %>%
  filter(fips == "24510") %>%
  group_by(type, year) %>%
  summarize(sum(Emissions)) %>%
  rename(total.emissions = `sum(Emissions)`)

qplot(
  year,
  total.emissions,
  data = total.emissons.by.type,
  facets = . ~ type,
  geom = c("point", "line"),
  ylab = "Total PM2.5 in tons",
  main = "Total Emissions in Baltimore City")

ggsave(file = "plot3.png")
