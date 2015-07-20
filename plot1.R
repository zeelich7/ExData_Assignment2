#Plot 1
##1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate total emissions 
totalEmissions<-aggregate(x=list(total=NEI$Emissions),by=list(year=NEI$year), FUN=sum)

#Plot emissions by year to see the trend
png(filename = "plot1.png",width = 480, height = 480, units = "px", bg = "transparent")
plot(totalEmissions$year,totalEmissions$total,xlab="Year",ylab="Total Emissions",type="l",main="Total Emissions in the United States from 1999 to 2008")
dev.off()
