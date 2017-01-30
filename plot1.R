# plot1.R 
#
# Reproduce histogram of global active power for Feb 1, 2007 through Feb 2, 2007
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

# Plot a histogram
hist(elecdata$Global_active_power, col="red",
     main="Global Active Power", xlab="Global Active Power (kilowatts)")
# Generate the png
dev.copy(png, "plot1.png")
dev.off()