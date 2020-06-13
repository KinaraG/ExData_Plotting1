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

# Generating graph 4

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(Required_Data, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png,'plot4.png', width=480,height=480)
dev.off()
