## plot3.R
##    Script to read in househouse power consumption data and
##    plot the active power usage over a two day timeframe (Feb 1 & 2 2007)
##

## Read the data and convert the date time fields
data <- read.csv("household_power_consumption.txt", sep = ";")

data$Time <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Get the subset of data for 2/1/2007 - 2/2/2007 (removing "?" data)
data.twodays <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
data.Global_active_power <- subset(data.twodays, Global_active_power != "?")
data.Sub_metering_1 <- subset(data.twodays, Sub_metering_1 != "?")
data.Sub_metering_2 <- subset(data.twodays, Sub_metering_2 != "?")
data.Sub_metering_3 <- subset(data.twodays, Sub_metering_3 != "?")
data.Voltage <- subset(data.twodays, Voltage != "?")
data.Global_reactive_power <- subset(data.twodays, Global_reactive_power != "?")

## Convert data to numeric for plotting
data.Global_active_power$Global_active_power <- as.numeric(as.character(data.Global_active_power$Global_active_power))
data.Sub_metering_1$Sub_metering_1 <- as.numeric(as.character(data.Sub_metering_1$Sub_metering_1))
data.Sub_metering_2$Sub_metering_2 <- as.numeric(as.character(data.Sub_metering_2$Sub_metering_2))
data.Sub_metering_3$Sub_metering_3 <- as.numeric(as.character(data.Sub_metering_3$Sub_metering_3))
data.Voltage$Voltage <- as.numeric(as.character(data.Voltage$Voltage))
data.Global_reactive_power$Global_reactive_power <- as.numeric(as.character(data.Global_reactive_power$Global_reactive_power))


## Create a png device to write plot to file
png("plot4.png")

## Set a 2 by 2 plotting surface
par(mfrow=c(2,2))

## Create the Global Active Power plot
plot(data.Global_active_power$Time, data.Global_active_power$Global_active_power, type="l", ylab="Global Active Power", xlab="")

## Create the Voltage plot
plot(data.Voltage$Time, data.Voltage$Voltage, type="l", ylab="Voltage", xlab="datetime")

## Create the Engery sub metering plot
plot(data.Sub_metering_1$Time, data.Sub_metering_1$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(data.Sub_metering_2$Time, data.Sub_metering_2$Sub_metering_2, col="red")
lines(data.Sub_metering_3$Time, data.Sub_metering_3$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),  ## lines
       col=c("black", "red","blue"),  ## set the colors
       bty="n") ## No border

## Create the Global_reactive_power plot
plot(data.Voltage$Time, data.Global_reactive_power$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")


## Close the device to write file
dev.off()