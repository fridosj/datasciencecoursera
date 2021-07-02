#LOADING THE LIBRARIES
library(data.table)
library(dplyr)
library(reshape2)
library(ggplot2)
#LOADING THE DATASETS
SCC <- as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
##Question
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County,
#California (???????????????? == "????????????????????"). Which city has seen greater changes over time in motor vehicle emissions?

#Filtering the dataset to contain only th data of Baltimore City and Los ANgeles
neiBCLA <- filter(NEI,fips =="24510"|fips=="06037")
#Filtering the dataset to contain the emissions from motor vehicle sources and adding a new column of city name.
neiBCLA <- neiBCLA %>% filter(SCC %in% vehcileSCC) %>% mutate(city=ifelse(fips =="24510","Baltimore City","Los Angeles"))
neiBCLA
#plotting a nd saving as png file
png("Plot6.png")
ggplot(neiBCLA,aes(x=factor(year),y=Emissions,fill=city))+geom_bar(stat = "identity",fill ="#FF0099")+facet_grid(.~city)
dev.off()