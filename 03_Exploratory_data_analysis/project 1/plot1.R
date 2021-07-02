library(data.table)
#loading packages
df <- fread("household_power_consumption.txt",na.strings = '?')
# Create a new coulumn datetime combining date and time in POSIXct format
df[,datetime := as.POSIXct(paste(Date, Time),format="%d/%m/%Y %H:%M:%S")]
# Filter the data 
df <- df[(Date=="2007-02-01")|(Date=="2007-02-02")]
#plot 1
png("plot2.png", width=480, height=480)
hist(df[,Global_active_power],xlab="Global_active_power (kilowatts)",ylab = "Frequency",col= "red")
dev.off()
