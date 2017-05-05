rm(list=ls())
library('dplyr')
library('ggplot2')

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Make type and year factors so that it's easier for classifying/grouping
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)
NEI$fips <- as.factor(NEI$fips)

full_data <- merge(NEI,SCC,by.x = "SCC", by.y = "SCC")
full_data <- full_data[order(full_data$year),]
full_data <- group_by(full_data,year,fips)

full_data_balt_LA <- subset(full_data, fips == "24510" | fips == "06037")
#full_data_LA <- subset(full_data,fips =)

## grep("Vehicles+", c("abc", "def", "cba a", "aa"), perl=TRUE, value=FALSE)
vehicle_related_lines_balt_LA <- grep("Vehicles+", full_data_balt_LA$SCC.Level.Two, 
                              perl=TRUE, value=FALSE)
vehicle_data_balt_LA <- full_data_balt_LA[vehicle_related_lines_balt_LA,]
emissions_per_year_balt_LA <- summarise(vehicle_data_balt_LA,sum(Emissions))

fips_06037 <- emissions_per_year_balt_LA$fips == "06037"
fips_24510 <- emissions_per_year_balt_LA$fips == "24510"

emissions_per_year_balt_LA$fips <- as.character(emissions_per_year_balt_LA$fips)
emissions_per_year_balt_LA$fips[fips_06037] <- "California"
emissions_per_year_balt_LA$fips[fips_24510] <- "Baltimore"

emissions_per_year_balt_LA$fips <- as.factor(emissions_per_year_balt_LA$fips)

qplot(year,`sum(Emissions)`, data = emissions_per_year_balt_LA, color = year,
      main = "Emissions per year from Vehicles", xlab = "Year",facets = .~fips,  
      ylab = "Tons of PM2.5") 

dev.copy(png, file = "Plot6.png")

dev.off()
