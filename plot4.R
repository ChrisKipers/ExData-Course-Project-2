library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

indices.of.coal.scc <- grep("Fuel Comb.*coal", x = SCC$EI.Sector, ignore.case = TRUE)
scc.codes.for.coal <- SCC[indices.of.coal.scc,]$SCC

total.fuel.emissions.by.year <- NEI %>%
  filter(SCC %in% scc.codes.for.coal) %>%
  group_by(year) %>%
  summarize(sum(Emissions) / 1000) %>%
  rename(total.emissions = `sum(Emissions)/1000`)

max.total.emission = max(total.fuel.emissions.by.year$total.emissions)

ggplot(
  data = total.fuel.emissions.by.year,
  aes(y = total.emissions, x = year)) +
  geom_point() +
  geom_line() +
  ylim(0, max.total.emission) + 
  ylab("Emissions in Kilotons") + 
  xlab("Year") +
  ggtitle("Total Emissions Contributed by Coal Combustion")

ggsave(file = "plot4.png")
