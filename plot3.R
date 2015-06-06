## plot3.R
##    Script to read in househouse power consumption data and
##    plot the energy sub metering data over a two day timeframe (Feb 1 & 2 2007)
##

## Read the data and convert the date time fields
data <- read.csv("household_power_consumption.txt", sep = ";")

data$Time <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Get the subset of data for 2/1/2007 - 2/2/2007 (removing "?" data)
data.twodays <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
data.Sub_metering_1 <- subset(data.twodays, Sub_metering_1 != "?")
data.Sub_metering_2 <- subset(data.twodays, Sub_metering_2 != "?")
data.Sub_metering_3 <- subset(data.twodays, Sub_metering_3 != "?")

## Convert data to numeric for plotting
data.Sub_metering_1$Sub_metering_1 <- as.numeric(as.character(data.Sub_metering_1$Sub_metering_1))
data.Sub_metering_2$Sub_metering_2 <- as.numeric(as.character(data.Sub_metering_2$Sub_metering_2))
data.Sub_metering_3$Sub_metering_3 <- as.numeric(as.character(data.Sub_metering_3$Sub_metering_3))

## Create a png device to write plot to file
png("plot3.png")

## Create the Sub metering plot
plot(data.Sub_metering_1$Time, data.Sub_metering_1$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(data.Sub_metering_2$Time, data.Sub_metering_2$Sub_metering_2, col="red")
lines(data.Sub_metering_3$Time, data.Sub_metering_3$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),  ## lines
       lwd=c(1,1,1),  ## normal line width
       col=c("black", "red","blue"),  ## set the colors
       cex=0.75) ## shrink font a bit

## Close the device to write file
dev.off()