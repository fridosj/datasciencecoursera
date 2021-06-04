#LOADING THE LIBRARIES
library(data.table)
library(dplyr)
library(reshape2)
library(ggplot2)
#LOADING THE DATASETS
SCC <- as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
##Question
#Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

#Using the grepl function to find the SCC related to coal combustion-related sources
combustionRelated <- grepl("comb", SCC[, SCC.Level.One], ignore.case=TRUE)
coalRelated <- grepl("coal", SCC[, SCC.Level.Four], ignore.case=TRUE) 
combustionSCC <- SCC[combustionRelated & coalRelated, SCC]
#Filtering the dataset to contain the emissions from coal combustion-related sources
coalcombustionNEI <- filter(NEI,SCC %in% combustionSCC)

#plotting a nd saving as png file
png("Plot4.png")
ggplot(coalcombustionNEI,aes(x=factor(year),y=Emissions/(10^5)))+geom_bar(stat = "identity",fill ="#FF0099")+labs(title = "Emissions from coal combustion-related sources")
dev.off()