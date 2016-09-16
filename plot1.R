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
# Plot 1
############################
png("plot1.png",width = 480, height = 480)

hist(as.numeric(household_subset$Global_active_power),col = "red",main = 
             "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()