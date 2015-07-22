#Plot 5
##How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate total emissions for Baltimore and type ON-ROAD
Baltimore<-subset(NEI,fips=="24510" & type=="ON-ROAD")
total<-aggregate(x=list(total=Baltimore$Emissions),by=list(year=Baltimore$year), FUN=sum)

#Plot emissions by year to see the trend
png(filename = "plot5.png",width = 480, height = 480, units = "px", bg = "transparent")
plot(total$year,total$total,xlab="Year",ylab="Total Emissions",type="l",main="Total On Road Emissions for Baltimore by year")
dev.off()
