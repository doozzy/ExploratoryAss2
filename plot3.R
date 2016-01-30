library(ggplot2)
#read data
NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")
#make two variables categorial
NEI <- transform(NEI, year= factor(year))
NEI <- transform(NEI, type= factor(type))
#data for Baltimore city
SubNEI <- subset(NEI, fips == "24510" )
#aggregate Emission for each year and type 
SubNEI <-  aggregate(Emissions ~ year * type,data=SubNEI, FUN=sum)
#draw the graph
 g <- ggplot(SubNEI, aes(year, log10(Emissions), col = type),is.na = TRUE)
 g <- g + geom_point(alpha = 1/3) +facet_grid(. ~ type)+geom_line(aes(group=type))
 g<- g+ theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
 g <- g + scale_x_discrete(breaks = seq(1999,2008,3)) 
print(g)
dev.copy(png, file ="Plot3.png")
dev.off()