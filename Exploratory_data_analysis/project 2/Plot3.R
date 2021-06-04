#LOADING THE LIBRARIES
library(data.table)
library(dplyr)
library(reshape2)
library(ggplot2)
#LOADING THE DATASETS
SCC <- as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
##Question
#Of the four types of sources indicated by the ???????????????? (point, nonpoint, onroad, nonroad) variable,
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

#Filtering the dataset to contain the data of only Baltimore city
neibm <- filter(NEI,fips == "24510")

#Creating a pipeline that applies melt and dcast to the dataset according to our need
neibm %>% melt(id="year",measure.vars = "Emissions") %>% dcast(year~variable,sum)

#plotting a nd saving as png file
png("plot3.png")
ggplot(neibm,aes(factor(year),Emissions,fill=type))+facet_grid(.~type,scales = "free",space="free")+geom_bar(stat = "identity")+theme_bw(base_family = 'Avenir',base_size = 10)+labs(x="year", y=expression(" Emission (Tons)"))+labs(title =expression(" Emissions, Baltimore City 1999-2008 by Source Type"))
dev.off()
