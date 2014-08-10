# Download and unzip the file
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./exdata-data-household_power_consumption")
#unzip("exdata-data-household_power_consumption.zip","household_power_consumption.txt")

# read the file 
rawFile <- read.table("./household_power_consumption.txt", header = T, sep = ";", na.string="?")

# Select rows containing required dates
SubFile<- rawFile$Date %in% c('1/2/2007','2/2/2007')
ExFile <- rawFile[SubFile,]

# Extract the date and time function into date and time format
library(lubridate)
ExFile$Date <- dmy(ExFile$Date)
ExFile$Time <- hms(ExFile$Time)

#Plot 2
plot(ExFile$Global_active_power, type= "n", ann=F, xaxt = "n")
title(xlab="",ylab = "Global active power (Kilowatts)")
lines(ExFile$Global_active_power)
axis(side = 1, at =c(1,1440,2880), labels = c("Thu", "Fri", "Sat"))

dev.copy(png, file = "plot2.png",width = 480, height = 480, units = "px")
dev.off()