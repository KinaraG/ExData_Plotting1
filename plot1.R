
install.packages("data.table")
library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileurl,'./Electric power consumption.zip', mode = 'wb')
unzip("Electric power consumption.zip", exdir = getwd())

Data <- read.table('./household_power_consumption.txt', header = TRUE, sep = ";", na.strings = "?", colClasses = c('character',
        'character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
head(Data)

#Changing format of date

Data$Date <- as.Date (Data$Date, format = "%d/%m/%Y")

# filtering out Data data from the dates 2007-02-01 and 2007-02-02

Required_Data <- subset(Data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Generating Plot 1

hist(Required_Data$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     main = "Global Active Power", col = "red")
dev.copy(png,'plot1.png', width=480,height=480)
dev.off()
