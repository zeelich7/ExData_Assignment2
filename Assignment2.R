#Plot 1
##1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate total emissions 
totalEmissions<-aggregate(x=list(total=NEI$Emissions),by=list(year=NEI$year), FUN=mean)

#Plot emissions by year to see the trend
png(filename = "plot2.png",width = 480, height = 480, units = "px", bg = "transparent")
plot(totalEmissions$year,totalEmissions$total,xlab="Year",ylab="Total Emissions",type="l")
dev.off()



#Plot 2
##2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate total emissions for Baltimore
Baltimore<-subset(NEI,fips=="24510")
totalEmissionsBaltimore<-aggregate(x=list(total=Baltimore$Emissions),by=list(year=Baltimore$year), FUN=mean)

#Plot emissions by year to see the trend
png(filename = "plot2.png",width = 480, height = 480, units = "px", bg = "transparent")
plot(totalEmissionsBaltimore$year,totalEmissionsBaltimore$total,xlab="Year",ylab="Total Emissions",type="l")
dev.off()


#Plot 3
##3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

#Read in the data
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate total emissions for Baltimore
Baltimore<-subset(NEI,fips=="24510")
totalByType<-aggregate(x=list(total=Baltimore$Emissions),by=list(year=Baltimore$year,type=Baltimore$type), FUN=mean)

#Plot emissions by year for each type to see the trend
png(filename = "plot3.png",width = 480, height = 480, units = "px")
ggplot(totalByType, aes(year, total)) +
  geom_line(aes(color=type))+
  labs(title = "Total Emission by Year per Type", x = "Year", y = "Total Emissions")
dev.off()



#Plot 4
##Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

