## PLEASE NOTE THAT YOU CAN SKIP ALL STEPS UNTIL THE NEXT HEADER IN 
## FULL CAPITALS AND WITH DOUBLE HASH TAGS IF YOU HAVE ALREADY CREATED 
## THE DATA FRAME CALLED "POWER" WITH 2880 OBSERVATIONS AND 8 VARIABLES

# setting working directory to preferred location
# setwd("E:/Cloudstation/R/courseproject1/ExData_Plotting1")

# loading necessary packages
library(dplyr)

# needed memory size approximation
# 2075259 * 9 * 8 = circa 150 M, so no problem for current day computers

# downloading the source file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              temp)
unzip(temp)
unlink(temp)

# reading of source file
power <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                    nrows = 100, na.strings="?")
classes <- sapply(power, class)
power <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                    colClasses = classes, na.strings="?")

# converting time variables to appropriate classes
power <- mutate(power, fulltime = paste(Date, Time))
power[,10] <- as.POSIXct(as.character(power[,10]), format = "%d/%m/%Y %H:%M:%S")

# filter out appropriate columns and rows
power <- select(power, 3:10)
rowselection <- grep("2007-02-0[12]", power$fulltime)
power <- power[rowselection,]
# there is now a dataframe called power with 2880 observations and 8 variables
# the last of these variables is the date & time

## PLOTTING THE GRAPHIC & SAVING THE PLOT
png(filename="plot3.png", width = 480, height = 480)
with(power, plot(fulltime, Sub_metering_1, type = "n", ylab="Energy sub metering",
                  xlab=""))
lines(power2$fulltime, power2$Sub_metering_1, col="black")
lines(power2$fulltime, power2$Sub_metering_2, col="red")
lines(power2$fulltime, power2$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1, 1, 1), col=c("black", "red", "blue"))
dev.off()

