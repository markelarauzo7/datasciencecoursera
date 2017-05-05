raw_data <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", header = TRUE, 
                       stringsAsFactors = FALSE, colClasses = c("character","character","numeric","numeric",
                                                                "numeric","numeric","numeric","numeric","numeric" ))

## We will only be using data between 2007-02-01 and 2007-02-02
power_data <- (subset(raw_data, Date == "1/2/2007" | Date == "2/2/2007"))

hist(power_data$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", col = "red")

dev.copy(png, file = "Plot1.png")

dev.off()
