library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#find  motor vehicle sources code
MotorSCC <- SCC[which(SCC$SCC.Level.One=="Mobile Sources"),]$SCC

# find  motor vehicle sources emission
both <- intersect(NEI$SCC, MotorSCC)

# for Baltimore City 
SubNEI <- subset(NEI, fips == "24510" & SCC %in% both)
totalEmission <- tapply(SubNEI$Emissions, SubNEI$year, FUN = mean)
g<-  qplot(names(totalEmission), log10(totalEmission))
g <- g + geom_line(aes(group = 1))
g <- g + labs( x = "Year", y = "Emissions PM2.5  from motor vehicle sources")
g<- g + labs(title = "Emissions PM2.5  from motor vehicle sources in \n 
Baltimore City")
print(g)
dev.copy(png, file ="Plot5.png")
dev.off()