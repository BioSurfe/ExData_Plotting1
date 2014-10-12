# Download and unzip the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./exdata-data-household_power_consumption")
unzip("exdata-data-household_power_consumption.zip","household_power_consumption.txt")

# read the file 
rawFile <- read.table("./household_power_consumption.txt", header = T, sep = ";", na.string="?")

# Select rows containing required dates
SubFile<- rawFile$Date %in% c('1/2/2007','2/2/2007')
ExFile <- rawFile[SubFile,]

# create a new column with time stamps
library(lubridate)
ExFile$ts <- dmy_hms(paste(ExFile$Date, ExFile$Time))

#Plot 2
plot(ExFile$ts, ExFile$Global_active_power, type="l", xlab="",ylab = "Global active power (Kilowatts)")

#save the file
dev.copy(png, file = "plot2.png",width = 480, height = 480, units = "px")
dev.off()
