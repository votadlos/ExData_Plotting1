require(sqldf)
file <- c("../household_power_consumption.txt")

#data subset
data_subset <- read.csv.sql(file, header = T, sep=";", sql = "select * from file where Date IN ('1/2/2007', '2/2/2007')" )

#NA change
data_subset[data_subset =="?"] <- NA

#date convert
data_subset$Date<-as.POSIXct(paste(data_subset$Date, data_subset$Time), format="%d/%m/%Y %H:%M:%S")

#plot image
png(filename="figure/plot4.png", width = 480, height = 480)
par(mfrow=c(2,2)) #ff, mar=c(3,2,1,0))

#Plot1
plot(data_subset$Date, data_subset$Global_active_power, type="l", xlab="", ylab="Global Active Power")

#Plot2
plot(data_subset$Date, data_subset$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Plot3
with(data_subset, plot(data_subset$Date, data_subset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(data_subset, points(data_subset$Date, data_subset$Sub_metering_2, type="l", col="Red"))
with(data_subset, points(data_subset$Date, data_subset$Sub_metering_3, type="l", col="Blue"))
legend("topright", lty=1, col=c("Black","Red","Blue"), bty="n",
legend=c("Sub_metering1", "Sub_metering2", "Sub_metering3"))

#Plot4
plot(data_subset$Date, data_subset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
