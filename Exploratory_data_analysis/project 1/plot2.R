library(data.table)
#loading packages
df <- fread("household_power_consumption.txt",na.strings = '?')
# Create a new coulumn datetime combining date and time in POSIXct format
df[,datetime := as.POSIXct(paste(Date, Time),format="%d/%m/%Y %H:%M:%S")]
# Filter the data 
df <- df[(datetime >= "2007-02-01") & (datetime < "2007-02-03")]
#plot 2
png("plot2.png", width=480, height=480)
plot(df[,datetime],df[,Global_active_power], type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
