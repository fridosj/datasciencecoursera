#LOADING THE LIBRARIES
library(data.table)
library(dplyr)
library(reshape2)
#LOADING THE DATASETS
SCC <- as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
##Question
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.

#Applying melt and dcast to the datset and making Year as ID and Emissionsa as variable to to get the total sum for seperate years 
NEImelt <- melt(NEI,id="year",measure.vars = "Emissions")
NEI.year <- dcast(NEImelt,year~variable,sum)
#plotting a nd saving as png file
png("plot1.png")
barplot(NEI.year$Emissions,names=NEI.year$year,xlab = "years",ylab = "Emissions",main="Emission over the years")
dev.off()