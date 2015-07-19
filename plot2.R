#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot 2
##2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#Calculate total emissions for Baltimore
Baltimore<-subset(NEI,fips=="24510")
totalEmissionsBaltimore<-aggregate(x=list(total=Baltimore$Emissions),by=list(year=Baltimore$year), FUN=mean)

#Plot emissions by year to see the trend
png(filename = "plot2.png",width = 480, height = 480, units = "px", bg = "transparent")
plot(totalEmissionsBaltimore$year,totalEmissionsBaltimore$total,xlab="Year",ylab="Total Emissions",type="l")
dev.off()
