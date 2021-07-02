#LOADING THE LIBRARIES
library(data.table)
library(dplyr)
library(reshape2)
library(ggplot2)
#LOADING THE DATASETS
SCC <- as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
##Question
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (???????????????? == "????????????????????")
#from 1999 to 2008? Use the base plotting system to make a plot answering this question. 

#Filtering the dataset to contain the data of only Baltimore city
neibm <- filter(NEI,fips == "24510")

#Creating a pipeline that applies melt and dcast to the dataset according to our need
neibm %>% melt(id="year",measure.vars = "Emissions") %>% dcast(year~variable,sum)

#plotting a nd saving as png file
png("plot2.png")
barplot(neibm$Emissions,names=neibm$year,xlab = "years",ylab = "Emissions",main="Emission over the years in Baltimore City")
dev.off()