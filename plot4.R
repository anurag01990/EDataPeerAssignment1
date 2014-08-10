## plot4.R - generates plot4.png

## Downloading the data
filename = "exdata_plotting1.zip"
if (!file.exists(filename)) {
  retval = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                         destfile = filename,
                         method = "curl")
}

## Reading the data
df.power = read.csv(unz(filename, "household_power_consumption.txt"), header=T,
                    sep=";", stringsAsFactors=F, na.strings="?",
                    colClasses=c("character", "character", "numeric",
                                 "numeric", "numeric", "numeric",
                                 "numeric", "numeric", "numeric"))

## Formatting the date and time and subsetting
df.power$timestamp = strptime(paste(df.power$Date, df.power$Time),
                              format="%d/%m/%Y %H:%M:%S", tz="UTC")
startDate = strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="UTC")
endDate = strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="UTC")
df.power = df.power[df.power$timestamp >= startDate & df.power$timestamp <= endDate, ]

## Creating the plot
png(filename="plot4.png", width=480, height=480)

# Setting the canvas for 4 plots
par(mfcol=c(2,2))

# Creating First plot
plot(df.power$timestamp, df.power$Global_active_power, type="l", xlab="",
     ylab="Global Active Power")

# Creating Second plot
plot(df.power$timestamp, df.power$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(df.power$timestamp, df.power$Sub_metering_2, col="red")
lines(df.power$timestamp, df.power$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=par("lwd"), bty="n")

# Creating Third Plot
plot(df.power$timestamp, df.power$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

# Creating Fourth plot
plot(df.power$timestamp, df.power$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()

