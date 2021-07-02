library(data.table)
#loading packages
df <- fread("household_power_consumption.txt",na.strings = '?')
# Create a new coulumn datetime combining date and time in POSIXct format
df[,datetime := as.POSIXct(paste(Date, Time),format="%d/%m/%Y %H:%M:%S")]
# Filter the data 
df <- df[(datetime >= "2007-02-01") & (datetime < "2007-02-03")]
#plot 3
png("plot3.png", width=480, height=480)
plot(df[,datetime],df[,Sub_metering_1],type = "l",,xlab="",ylab = "Energy sub metering")
lines(df[,datetime],df[,Sub_metering_2],col="red")
lines(df[,datetime],df[,Sub_metering_3],col="blue")
legend("topright",pch="____",col = c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()



