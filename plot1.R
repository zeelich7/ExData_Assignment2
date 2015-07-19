#Plot 1
#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

#Calculate total emissions 
totalEmissions<-aggregate(x=list(total=NEI$Emissions),by=list(year=NEI$year), FUN=mean)

#Plot emissions by year to see the trend
png(filename = "plot1.png",width = 480, height = 480, units = "px", bg = "transparent")
plot(totalEmissions$year,totalEmissions$total,xlab="Year",ylab="Total Emissions",type="l")
dev.off()