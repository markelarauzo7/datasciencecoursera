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
full_data <- group_by(full_data,year,type)

full_data_baltimore <- subset(full_data, fips == "24510")

## grep("Vehicles+", c("abc", "def", "cba a", "aa"), perl=TRUE, value=FALSE)
vehicle_related_lines <- grep("Vehicles+", full_data_baltimore$SCC.Level.Two, 
                              perl=TRUE, value=FALSE)
vehicle_data <- full_data_baltimore[vehicle_related_lines,]
emissions_per_year <- summarise(vehicle_data,sum(Emissions))

qplot(year,`sum(Emissions)`, data = emissions_per_year, color = year,
      main = "Emissions per year from Vehicles", xlab = "Year", 
      ylab = "Tons of PM2.5") 

dev.copy(png, file = "Plot5.png")

dev.off()
