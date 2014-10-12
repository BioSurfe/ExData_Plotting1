# Download and unzip the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./exdata-data-household_power_consumption")
unzip("exdata-data-household_power_consumption.zip","household_power_consumption.txt")

# read the file 
rawFile <- read.table("./household_power_consumption.txt", header = T, sep = ";", na.string="?")

# Select rows containing required dates
SubFile<- rawFile$Date %in% c('1/2/2007','2/2/2007')
ExFile <- rawFile[SubFile,]

# Extract the date and time function into date and time format
library(lubridate)
ExFile$ts <- dmy_hms(paste(ExFile$Date, ExFile$Time))

#Plot 4
# 4.1 initialize the plot by setting the col and row
par(mfrow = c(2, 2))
# 4.2 plot1,1
plot(ExFile$ts,ExFile$Global_active_power, type= "n", ann=F)
title(xlab="",ylab = "Global active power")
lines(ExFile$ts, ExFile$Global_active_power)

# 4.3 plot1,2
plot(ExFile$ts, ExFile$Voltage,type= "n", ann=F)
lines(ExFile$ts,ExFile$Voltage, col = "black")
title(xlab="datetime",ylab = "Voltage")

#4.4 plot2,1
with(ExFile,
     plot(ExFile$ts, ExFile$Sub_metering_1,ann = F, type = "n"),
     plot(ExFile$ts, ExFile$Sub_metering_2,ann = F, type = "n"),
     plot(ExFile$ts, ExFile$Sub_metering_3,ann = F, type = "n"))

lines(ExFile$ts, ExFile$Sub_metering_1, col = "black")
lines(ExFile$ts, ExFile$Sub_metering_2, col = "red")
lines(ExFile$ts, ExFile$Sub_metering_3, col = "blue")

title(ylab = "Energy sub metering")


legend("topright", inset(-1,-1),lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.5, y.intersp=0.1, xpd = 0.5, xjust=0, yjust=0, trace = T)

#4.4 plot 2,2
plot(ExFile$ts, ExFile$Global_reactive_power,ann = F, type = "n")
lines(ExFile$ts, ExFile$Global_reactive_power, col = "black")
title(ylab = "Global_Reactive_Power", xlab = "datetime")

# create PNG
dev.copy(png, file = "plot4.png",width = 480, height = 480, units = "px")
dev.off()
