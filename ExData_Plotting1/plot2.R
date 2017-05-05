raw_data <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", header = TRUE, 
                       stringsAsFactors = FALSE, colClasses = c("character","character","numeric","numeric",
                        "numeric","numeric","numeric","numeric","numeric" ))


## We will only be using data between 2007-02-01 and 2007-02-02
power_data <- (subset(raw_data, Date == "1/2/2007" | Date == "2/2/2007"))

## Date/Time data conversion to Date
aux <- paste(power_data$Date, power_data$Time, sep = " ")
aux <- strptime(aux, "%d/%m/%Y %H:%M:%S")

power_data$Date_Time <- aux
power_data$Day <- weekdays(power_data$Date_Time)

with(power_data,plot(Date_Time, Global_active_power, 
     xlab = "", ylab = "Global Active Power (kilowatts)", type = "l" ))

dev.copy(png, file = "Plot2.png")

dev.off()
