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


## Change device parameters for 4 plots
par(mfrow = c(2,2))

## Creating plot (1,1)
with(power_data,plot(Date_Time, Global_active_power, 
     xlab = "", ylab = "Global Active Power (kilowatts)", type = "l" ))

## Creating plot (1,2)
with(power_data,plot(Date_Time, Voltage, xlab = "datetime", ylab = "Voltage",type = "l"))

## Creating plot (2,1)
with(power_data,plot(Date_Time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l"))
with(power_data,lines(Date_Time, Sub_metering_2, type = "l", col = "red"))
with(power_data,lines(Date_Time, Sub_metering_3, type = "l", col = "blue"))

legend("topright",pch="-",col=c("black","red","blue"),cex = 0.15, inset=.05, lwd = 2, 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Creating plot (2,2)
with(power_data,plot(Date_Time, Global_reactive_power, xlab = "datetime", 
     ylab = "Global_reactive_power",type = "h"))

## Output plots to a png file
dev.copy(png, file = "Plot4.png")

dev.off()
