install.packages("data.table")
library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileurl,'./Electric power consumption.zip', mode = 'wb')
unzip("Electric power consumption.zip", exdir = getwd())

Data <- read.table('./household_power_consumption.txt', header = TRUE, sep = ";", na.strings = "?", colClasses = c('character',
                                                                                                                   'character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# Changing format of date

Data$Date <- as.Date (Data$Date, format = "%d/%m/%Y")

# filtering out Data data from the dates 2007-02-01 and 2007-02-02

Required_Data <- subset(Data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Cobining Date and Time Column

DateTime <- paste (as.Date (Required_Data$Date),Required_Data$Time)

# Chnage the format

Required_Data$DateTime <- as.POSIXct(DateTime)

# Generating Graph 3

with (Required_Data, {
  plot(Sub_metering_1 ~ DateTime, type="l",
       ylab = "Global Active Power (kilowatts)",xlab="")
  lines (Sub_metering_2 ~ DateTime, col="red")
  lines (Sub_metering_3 ~ DateTime, col="blue")
})

legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png,'plot3.png', width=480,height=480)
dev.off()
