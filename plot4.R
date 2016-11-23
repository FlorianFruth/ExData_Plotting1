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


# Plot number 4
png(filename = "plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))
with(data, {
        plot(date_and_time, Global_active_power, type = "l", xlab= "", ylab = "Global Active Power")
        plot(date_and_time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        plot(date_and_time, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        lines(date_and_time,data$Sub_metering_2, type = "l", col = "red")
        lines(date_and_time,data$Sub_metering_3, type = "l", col = "blue")
        legend("topright", lty=1, col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
        plot(date_and_time,Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()