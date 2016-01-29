library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
SCC[which(SCC$SCC.Level.One=="Mobile Sources"),]
MotorSCC <- SCC[which(SCC$SCC.Level.One=="Mobile Sources"),]$SCC
both <- intersect(NEI$SCC, MotorSCC)
SubNEI <- subset(NEI, fips == "24510" & SCC %in% both)
totalEmission <- tapply(SubNEI$Emissions, SubNEI$year, FUN = mean)
plott= qplot(names(totalEmission), log10(totalEmission))
print(plott)
dev.copy(png, file ="Plot5.png")
dev.off()