# Initialize ####
library(data.table)
setwd("C:/Users/dlabar/Google Drive/Coursera/courseradatascience/04-ExploratoryAnalysis/Assignment 1/ExData_Plotting1")

# Load data ####
zfile <- "powerdata.zip"
tfile <- "household_power_consumption.txt"

if(!file.exists(zfile)) download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", zfile)
if(!file.exists(tfile)) unzip(zfile)

hpc<-fread(tfile, na.strings="?")

# Reformat and subset data ####
str(hpc)
hpc[,`:=`(Date = as.IDate(Date,format="%d/%m/%Y"),
          Time = as.ITime(Time,format="%H:%M:%S"),
          DateTime = as.POSIXct(paste(Date,Time),format="%d/%m/%Y %H:%M:%S"),
          Global_active_power = as.numeric(Global_active_power),
          Global_reactive_power = as.numeric(Global_reactive_power),
          Voltage = as.numeric(Voltage),
          Global_intensity = as.numeric(Global_intensity),
          Sub_metering_1 = as.numeric(Sub_metering_1),
          Sub_metering_2 = as.numeric(Sub_metering_2),
          Sub_metering_3 = as.numeric(Sub_metering_3))]

hpcSub <- hpc[between(Date, "2007-02-01", "2007-02-02")]
hpcSub <- hpc[Date=="2007-02-01" | Date=="2007-02-02"]
hpcSub

# Plots ####
with(hpcSub, {
#  # Plot 1:
#  png(filename = "plot1.png", width = 480, height = 480)
#  hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
#  dev.off()
#  
#  # Plot 2:
#  png(filename = "plot2.png", width = 480, height = 480)
#  plot(DateTime, Global_active_power, type="l", xlab=NA, ylab="Global Active Power (kilowatts)")
#  dev.off()
  
  # Plot 3:
  png(filename = "plot3.png", width = 480, height = 480)
  plot(DateTime, Sub_metering_1, type = "l", xlab=NA, ylab="Energy sub metering")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
  legend("topright", lwd=1, col=c("black","blue","red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  dev.off()

#  # Plot 4:
#  png(filename = "plot4.png", width = 480, height = 480)
#  par(mfcol=c(2,2))
#  plot(DateTime, Global_active_power, type="l", xlab=NA, ylab="Global Active Power (kilowatts)")
#  plot(DateTime, Sub_metering_1, type = "l", xlab=NA, ylab="Energy sub metering")
#  lines(DateTime, Sub_metering_2, col="red")
#  lines(DateTime, Sub_metering_3, col="blue")
#  legend("topright", lwd=1, col=c("black","blue","red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#  plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage")
#  plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
#  dev.off()
#  par(mfcol=c(1,1))
})

file.remove(tfile)