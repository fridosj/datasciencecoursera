#LOADING THE LIBRARIES
library(data.table)
library(dplyr)
library(reshape2)
library(ggplot2)
#LOADING THE DATASETS
SCC <- as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
##Question
#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

#Using the grepl function to find the SCC related to motor vehicle sources
vehicle <- grepl("vehicle",SCC[,SCC.Level.Two],ignore.case = TRUE)
vehcileSCC <- SCC[vehicle,SCC]
#Filtering the dataset to contain the emissions from motor vehicle sources
neivehicle <- filter(NEI,fips == "24510" & SCC %in% vehcileSCC)

#plotting a nd saving as png file
png("Plot5.png")
ggplot(neivehicle,aes(x=factor(year),y=Emissions))+geom_bar(stat = "identity",fill ="#FF0099")+labs(title ="Emissions from motor vehicle sources" )
dev.off()