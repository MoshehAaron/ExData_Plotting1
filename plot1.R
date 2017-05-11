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





## Plot 1

## open device & save in new subdir

	if(!file.exists("plots")) dir.create("plots")
	png(filename = "./plots/plot1.png", width = 480, height = 480, units="px")

## create graph

	with(inputdata, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red"))
	
## close device

	##close device = save file

	dev.off()
