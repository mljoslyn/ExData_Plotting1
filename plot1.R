## plot1.R
##    Script to read in househouse power consumption data and
##    plot the frequency of occurance ocross the active power usage
##

## Read the data and convert the date time fields
data <- read.csv("household_power_consumption.txt", sep = ";")

data$Time <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Get the subset of data for 2/1/2007 - 2/2/2007 (removing "?" data)
data.clean <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02") & Global_active_power != "?")

## Convert data to numeric for plotting
data.clean$Global_active_power <- as.numeric(as.character(data.clean$Global_active_power))

## Create a png device to write plot to file
png("plot1.png")

## Build the plot
hist(data.clean$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

## Close the device to write file
dev.off()