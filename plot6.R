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
