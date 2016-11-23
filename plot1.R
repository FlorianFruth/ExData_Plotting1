#read in data
data_all <- read.csv("data/household_power_consumption.txt",header = TRUE, sep = ";")

#convert the Date column to a date data type
data_all$Date <- dmy(data_all$Date)

#filter the relevant data in the specified time window
date1 <- dmy("01-02-2007")
date2 <- dmy("02-02-2007")
data <- data_all[data_all$Date>=date1 & data_all$Date<=date2,]
date_and_time <- paste(data$Date, data$Time, sep=" ")
date_and_time <- strptime(date_and_time, format="%Y-%m-%d %H:%M:%S")

#convert the numeric columns to data type numeric
data[c(3:9)] <- sapply(data[c(3:9)],as.numeric)

#Plot number 1
png(filename = "plot1.png",width = 480, height = 480)
hist(data$Global_active_power, col = "red",
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")
dev.off()