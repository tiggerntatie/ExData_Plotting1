# plot3.R 
#
# Reproduce line graphs of Sub_metering_1, 2, 3 for Feb 1, 2007 through Feb 2, 2007
#
# Retrieve the source data ane extract:
dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "household_power_consumption.zip"
datafile <- "household_power_consumption.txt"
if (!file.exists(destfile)) {
  download.file(dataurl, destfile, method="curl")
}
if (!file.exists(datafile)) {
  unzip(destfile)
}

# Extract, only if we haven't already
if (! exists("elecdata")) {
  elecdata <- subset(read.table(datafile, sep=";", header=TRUE, na.strings="?"), 
                     Date=="1/2/2007" | Date=="2/2/2007")
}
# insert a DateTime column
if (!exists("elecdata$DateTime")) {
  elecdata$DateTime <- as.POSIXct(paste(elecdata$Date, elecdata$Time), format="%d/%m/%Y %H:%M:%S")
}

# don't copy from default device (clips text). Work directly with png.
png("plot3.png")
# Plot a line graph for Sub_metering_1
plot(elecdata$DateTime, as.numeric(elecdata$Sub_metering_1), type="l", xlab="", ylab="Energy sub metering")
# Sub_metering_2
lines(elecdata$DateTime, as.numeric(elecdata$Sub_metering_2), col="red")
# Sub_metering_3
lines(elecdata$DateTime, as.numeric(elecdata$Sub_metering_3), col="blue")
# legends
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=1, col=c("black","red","blue"))

dev.off()