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
Voltage <- as.numeric(requiredData$Voltage)
subMetering_1 <- as.numeric(requiredData$Sub_metering_1)
subMetering_2 <- as.numeric(requiredData$Sub_metering_2)
subMetering_3 <- as.numeric(requiredData$Sub_metering_3)
globalReactivePower <- as.numeric(requiredData$Global_reactive_power)

## Plot the diagram
par(mfrow = c(2,2))
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(datetime, Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(datetime, subMetering_1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering_2, type="l", col="red")
lines(datetime, subMetering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", lty=1, lwd=1,  cex=0.75, pt.cex = 1, col=c("black", "red", "blue"))
plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()

