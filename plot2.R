require(sqldf)
file <- c("../household_power_consumption.txt")

#data subset
data_subset <- read.csv.sql(file, header = T, sep=";", sql = "select * from file where Date IN ('1/2/2007', '2/2/2007')" )

#NA change
data_subset[data_subset =="?"] <- NA

#date convert
data_subset$Date<-as.POSIXct(paste(data_subset$Date, data_subset$Time), format="%d/%m/%Y %H:%M:%S")

#plot image
png(filename="figure/plot2.png", width = 480, height = 480)
plot(data_subset$Date, data_subset$Global_active_power, type="l",
xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
