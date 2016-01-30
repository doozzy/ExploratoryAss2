library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#find coal combustion-rlated sources
SCCCoal <-SCC[grep("Fuel Comb.*Coal$",SCC$EI.Sector, perl=TRUE),]$SCC

NEI <- transform(NEI, SCC= factor(SCC))

#find the coal combustion-rlated sources Emission 
both <- intersect(NEI$SCC, SCCCoal)
SubNEI <- subset(NEI, SCC %in% both)

# find teh average of Emission for each year
totalEmission <- tapply(SubNEI$Emissions, SubNEI$year, FUN = mean)
g<-  qplot(names(totalEmission), log10(totalEmission))
g <- g + geom_line(aes(group=1))
g <- g + labs (x = "year") + labs ( y = "Emission from coal Ccombustion-related sources")
g<- g + labs(title = "Emissions PM2.5 from coal combustion-related sources \n across the United States") 
print(g)
dev.copy(png, file ="Plot4.png")
dev.off()