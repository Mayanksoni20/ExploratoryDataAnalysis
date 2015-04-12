
setwd("//Users//sonim//desktop//Exploratory-Data-Analysis")

library(data.table)


url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "household_power_consumption"
download.file(url, file, method = "curl")

unzip(file, exdir = "//Users//sonim//desktop//Exploratory-Data-Analysis")

data <- fread("household_power_consumption.txt")


class(data$Date)
class(data$Time)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
class(data$Date)

data_subset <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02"]

class(data_subset)
data_subset <- data.frame(data_subset)

for(i in c(3:9)) {data_subset[,i] <- as.numeric(as.character(data_subset[,i]))}

data_subset$Date_Time <- paste(data_subset$Date, data_subset$Time)

data_subset$Date_Time <- strptime(data_subset$Date_Time, format="%Y-%m-%d %H:%M:%S")
class(data_subset$Date_Time)

png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

par(mar = c(6, 6, 5, 4))

plot(data_subset$Date_Time, data_subset$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power (kilowatts)", type="n")

lines(data_subset$Date_Time, data_subset$Global_active_power, type="S")

dev.off()