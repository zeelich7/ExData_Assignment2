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
plot(coal_emissions$year,coal_emissions$total,xlab="Year",ylab=expression("Total PM "[2.5]*" Emissions"),main="Total Emissions from Coal Sources", type="l")
dev.off()
