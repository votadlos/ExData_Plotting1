require(sqldf)
file <- c("../household_power_consumption.txt")

#data subset
data_subset <-
read.csv.sql(file, header = T, sep=";", sql = "select * from file where Date IN ('1/2/2007', '2/2/2007')" )

#NA change
data_subset[data_subset =="?"] <- NA

#date convert
data_subset$Date<-as.POSIXct(paste(data_subset$Date, data_subset$Time), format="%d/%m/%Y %H:%M:%S")

#plot image
png(filename="figure/plot3.png", width = 480, height = 480)
with(data_subset, plot(data_subset$Date, data_subset$Sub_metering_1, type="l",
xlab="", ylab="Energy sub metering"))
with(data_subset, points(data_subset$Date, data_subset$Sub_metering_2, type="l", col="Red"))
with(data_subset, points(data_subset$Date, data_subset$Sub_metering_3, type="l", col="Blue"))

#write legend
legend("topright", lty=1, col=c("Black","Red","Blue"), legend=c("Sub_metering1", "Sub_metering2", "Sub_metering3"))

dev.off()
