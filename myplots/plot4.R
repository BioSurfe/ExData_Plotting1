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
#Plot 4
# 4.1 initialize the plot by setting the col and row
par(mfrow = c(2, 2))
# 4.2 plot1,1
plot(ExFile$Global_active_power, type= "n", ann=F, xaxt = "n")
title(xlab="",ylab = "Global active power",cex.lab = 0.6)
lines(ExFile$Global_active_power)
axis(side = 1, at =c(1,1440,2880), labels = c("Thu", "Fri", "Sat"))

# 4.3 plot1,2
plot(ExFile$Voltage,type= "n", ann=F, xaxt = "n")
lines(ExFile$Voltage, col = "black")
title(xlab="datetime",ylab = "Voltage", cex.lab = 0.6)
axis(side = 1, at =c(1,1440,2880), labels = c("Thu", "Fri", "Sat"))

#4.4 plot2,1
with(ExFile,
     plot(ExFile$Sub_metering_1,ann = F, type = "n", xaxt = "n"),
     plot(ExFile$Sub_metering_2,ann = F, type = "n", xaxt = "n"),
     plot(ExFile$Sub_metering_3,ann = F, type = "n", xaxt = "n"))

lines(ExFile$Sub_metering_1, col = "black")
lines(ExFile$Sub_metering_2, col = "red")
lines(ExFile$Sub_metering_3, col = "blue")

axis(side = 1, at =c(1,1440,2880), labels = c("Thu", "Fri", "Sat"))

title(ylab = "Energy sub metering", cex.lab = 0.6)

legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       cex = 0.8, bty = "n")

#4.4 plot 2,2
plot(ExFile$Global_reactive_power,ann = F, type = "n", xaxt = "n")

lines(ExFile$Global_reactive_power, col = "black")

axis(side = 1, at =c(1,1440,2880), labels = c("Thu", "Fri", "Sat"))

title(ylab = "Global_Reactive_Power", xlab = "datetime", cex.lab = 0.6)


dev.copy(png, file = "plot4.png",width = 480, height = 480, units = "px")
dev.off()
