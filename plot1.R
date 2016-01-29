fileUrl <- https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
download.file(fileUrl, destfile = "exdata%2Fdata%2FNEI_data.zip", mode = "wb")

unzip("exdata%2Fdata%2FNEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- transform(NEI, year= factor(year))
totalEmission <- tapply(NEI$Emissions, NEI$year, FUN = sum)
years <-names(totalEmission)
plot( totalEmission, xaxt = "n")
lines(totalEmission)
axis(1, at=1:length(years), labels=years)
dev.copy(png, file ="Plot1.png")
dev.off()