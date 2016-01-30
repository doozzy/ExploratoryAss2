library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#find motor vehicle sources codes
MotorSCC <- SCC[which(SCC$SCC.Level.One=="Mobile Sources"),]$SCC
both <- intersect(NEI$SCC, MotorSCC)

#Baltimore City
SubBalti <- subset(NEI, fips == "24510" & SCC %in% both)

#LA 
SubLA <- subset(NEI, fips == "06037" & SCC %in% both)

#find Emissions PM2.5  from motor vehicle sources for both cities 
BaltiEmi<-with(SubBalti, tapply(Emissions, year, mean, na.rm = T))
LAEmi<-with(SubLA, tapply(Emissions, year, mean, na.rm =T))

#makes them as data fram
dBalti<-data.frame(years = names(BaltiEmi), mean = BaltiEmi)
dLA<-data.frame(years = names(LAEmi), mean = LAEmi)

# merge them together
mrg <- merge(dBalti, dLA, by = "years")

xnames <- factor(names(mrg[,2]))
with(mrg, plot( names(mrg[,2]), mrg[,2], ylim =c( -1, 100), col = "blue", 
ylab ="Emission PM2.5", xlab = "year", pch= 19,
 main= "Compare emissions from motor vehicle sources in \n Baltimore City with Los Angeles County"))
with(mrg, points(  names(mrg[,3]), mrg[,3], pch= 3, col = "red"))
lines(names(mrg[,2]), mrg[,2] )
lines (names(mrg[,3]), mrg[,3])

legend ("topright", pch = c(19,3), col= c("blue", "red"), legend= c("Baltimore City",
"Los Angeles County"))

dev.copy(png, file ="Plot6.png")
dev.off()