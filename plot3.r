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
  labs(title = "Baltimore - Total Emissions by Year per Type", x = "Year", y = "Total Emissions")
dev.off()
