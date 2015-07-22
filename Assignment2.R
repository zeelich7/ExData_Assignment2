#Plot 1
##1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate total emissions 
totalEmissions<-aggregate(x=list(total=NEI$Emissions),by=list(year=NEI$year), FUN=sum)

#Plot emissions by year to see the trend
png(filename = "plot1.png",width = 480, height = 480, units = "px", bg = "transparent")
plot(totalEmissions$year,totalEmissions$total,xlab="Year",ylab="Total Emissions",type="l")
dev.off()



#Plot 2
##2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate total emissions for Baltimore
Baltimore<-subset(NEI,fips=="24510")
totalEmissionsBaltimore<-aggregate(x=list(total=Baltimore$Emissions),by=list(year=Baltimore$year), FUN=sum)

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
totalByType<-aggregate(x=list(total=Baltimore$Emissions),by=list(year=Baltimore$year,type=Baltimore$type), FUN=sum)

#Plot emissions by year for each type to see the trend
png(filename = "plot3.png",width = 480, height = 480, units = "px")
ggplot(totalByType, aes(year, total)) +
  geom_line(aes(color=type))+
  labs(title = "Baltimore - Total Emission by Year per Type", x = "Year", y = "Total Emissions")
dev.off()



#Plot 4
##Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Get a subset of the coal related rows
coal_related <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
coal_related <- SCC[coal_related, ]
coal_related <- NEI[NEI$SCC %in% coal_related$SCC, ]

#Get the total coal related emissions per year 
coal_emissions <- aggregate(x=list(total=coal_related$Emissions), by=list(year=coal_related$year), FUN = sum)

#Plot emissions by year for each type to see the trend
png(filename = "plot4.png",width = 480, height = 480, units = "px", bg = "transparent")
plot(coal_emissions$year,coal_emissions$total,xlab="Year",ylab="Total Emissions",type="l",main="Total Coal Related Emissions by Year")
dev.off()



#Plot 5
##How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate total emissions for Baltimore and type ON-ROAD
Baltimore<-subset(NEI,fips=="24510" & type=="ON-ROAD")
#motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
#motor <- SCC[motor, ]
#Baltimore_motor <- subset[Baltimore$SCC %in% motor$SCC, ]
total<-aggregate(x=list(total=Baltimore$Emissions),by=list(year=Baltimore$year), FUN=sum)

#Plot emissions by year to see the trend
png(filename = "plot5.png",width = 480, height = 480, units = "px", bg = "transparent")
plot(total$year,total$total,xlab="Year",ylab="Total Emissions",type="l",main="Total On Road Emissions for Baltimore by year")
dev.off()


#Plot 6
##Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
#Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate total emissions for Baltimore (24510) and LA county (06037) and type ON-ROAD
on_road_subset<-subset(NEI,(fips=="24510"|fips=="06037") & type=="ON-ROAD")
total<-aggregate(x=list(total=on_road_subset$Emissions),by=list(year=on_road_subset$year,county=on_road_subset$fips), FUN=sum)

#Plot emissions by year and county to see the trend
png(filename = "plot6.png",width = 480, height = 480, units = "px", bg = "transparent")
ggplot(total, aes(year, total,color=county)) +
  geom_line()+
  scale_color_discrete(name="County", labels=c("Los Angeles","Baltimore"))+
  labs(title = "Baltimore vs LA County - Total Motor Emission by Year", x = "Year", y = "Total Emissions")
dev.off()
