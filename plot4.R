#######################
# Downloading the data
#######################

if(!exists("newdata")){(dir.create("newdata"))}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile = "./newdata/power.zip")
unzip("./newdata/power.zip")

library(dplyr)
library(lubridate)

# Read the data and preapre the desired data set
household<-read.csv2("household_power_consumption.txt",nrows = 2076000,header = T, stringsAsFactors = F)
household$Date <- dmy(household$Date)
household_subset <- household %>% filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02") ) 

############################
# Plot 4
############################
png("plot4.png",width = 480, height = 480) 

par( mfrow = c(2,2), mar=c(5,5,2,2))
x<-as.numeric(household_subset$Global_active_power)
plot(x,type = "l", xlab=" ", ylab = "Global Active Power",xaxt="n")
axis(side = 1,labels = c("Thu","Fri","Sat"), at = c(1,length(x)/2,length(x)))

x<-as.numeric(household_subset$Voltage)
plot(x,type = "l", xlab="datetime", ylab = "Voltage",xaxt="n")
axis(side = 1,labels = c("Thu","Fri","Sat"), at = c(1,length(x)/2,length(x)))

x<-as.numeric(household_subset$Sub_metering_1)
y<-as.numeric(household_subset$Sub_metering_2)
z<-as.numeric(household_subset$Sub_metering_3)
plot(x, type = "n",xlab=" ", ylab = "Energy sub metering", xaxt = "n")
lines(x,col="black");lines(y,col="red");lines(z,col="blue")
axis(side = 1,labels = c("Thu","Fri","Sat"), at = c(1,length(x)/2,length(x)))
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd = 1, col = c("black","red","blue"),bty = "n",text.width = 1250,xjust=2,cex = 0.8)

x<-as.numeric(household_subset$Global_reactive_power)
plot(x,type = "l", xlab="datetime", ylab = "Global_reactive_power",xaxt="n")
axis(side = 1,labels = c("Thu","Fri","Sat"), at = c(1,length(x)/2,length(x)))

dev.off()