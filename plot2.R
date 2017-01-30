# plot2.R 
#
# Reproduce line graph of global active power vs. time for Feb 1, 2007 through Feb 2, 2007
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

# Plot a line graph
plot(elecdata$DateTime, elecdata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.copy(png, "plot2.png")
dev.off()