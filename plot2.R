#read data from fileUrl 
#fileUrl <- https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#download.file(fileUrl, destfile = "exdata%2Fdata%2FNEI_data.zip", mode = "wb")
#unzip("exdata%2Fdata%2FNEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#find total Emission for Baltimore city
totalEmission <- tapply(subset(NEI$Emissions, NEI$fips == "24510"), subset(NEI$year, NEI$fips =="24510"), FUN = sum)
years <-names(totalEmission)
plot( totalEmission, xaxt = "n", xlab = "Year", main= "Total Emission for Baltimore City")
lines(totalEmission)
axis(1, at=1:length(years), labels=years)
dev.copy(png, file ="Plot2.png")
dev.off()