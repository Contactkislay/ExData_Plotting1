## Download and unzip the downloaded file
filename<- "exdata-data-household_power_consumption.zip"
if (!file.exists(filename)){
   fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
   download.file(fileURL, filename, method="curl")
 }
 # Unzip the downloaded file
 if (!file.exists("household_power_consumption.txt")) { 
   unzip(filename) 
 }

## Read the data from downloaded text file
powerConsumptionData<-read.table("./household_power_consumption.txt", sep=";",header=TRUE,  dec=".",stringsAsFactors=FALSE)

## Gather the required data for plotting the diagram
requiredData <- powerConsumptionData[powerConsumptionData$Date %in% c("1/2/2007","2/2/2007") ,]
datetime <- strptime(paste(requiredData$Date, requiredData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(requiredData$Global_active_power)

## Plot the diagram
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()

