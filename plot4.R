## download and unzip data
	
	## it is assumed that the working dir is already set correctly.
	##the downloaded file is saved in a subdir "data", and its contents are unzipped there as well.

	if(!file.exists("data")) dir.create("data")
	if(!file.exists("./data/household_power_consumption.zip")){
		fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
		download.file(fileUrl, destfile = "./data/household_power_consumption.zip")
		}
	if(!file.exists("./data/household_power_consumption.txt")){unzip("./data/household_power_consumption.zip", exdir = "./data")}



## read data

	inputfile <- file("./data/household_power_consumption.txt")
	inputdata <- read.table(text = grep("^[1,2]/2/2007",readLines(inputfile),value=TRUE), sep = ";", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = "?")






## Plot 4

## convert date and time format
	
	inputdata$Date <- as.Date(inputdata$Date, format = "%d/%m/%Y")
	inputdata$DateTime <- as.POSIXct(paste(inputdata$Date, inputdata$Time))

## open device & save in new subdir

	if(!file.exists("plots")) dir.create("plots")
	png(filename = "./plots/plot4.png", width = 480, height = 480, units="px")

## create graph
	
	par(mfrow = c(2, 2))
	
	## graph 1 (top left)
	plot(inputdata$DateTime, inputdata$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
	
	## graph 2 (top right)
	plot(inputdata$DateTime, inputdata$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
	
	##graph 3 (bottom left)
	plot(inputdata$DateTime, inputdata$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
	lines(inputdata$DateTime, inputdata$Sub_metering_2, col = "red")
	lines(inputdata$DateTime, inputdata$Sub_metering_3, col = "blue")
	legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)

	##graph 4 (bottom right)
	plot(inputdata$DateTime, inputdata$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")

## close device

	##close device = save file

	dev.off()
