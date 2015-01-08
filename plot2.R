library(sqldf)
field.types<-list(Date='datetime',Time='datetime',Global_active_power='number',
	Global_reactive_power='number',Voltage='number',Global_intensity='number',Sub_metering_1='number',Sub_metering_2='number',Sub_metering_3='number')
startdate<-as.Date('1/2/2007', '%d/%m/%Y')
enddate<-as.Date('2/2/2007', '%d/%m/%Y') 
powerdata <- read.csv.sql("household_power_consumption.txt",sql="select * from file where Date='1/2/2007' or Date='2/2/2007'", sep=";",header=TRUE)
powerdata$Date <-as.Date(powerdata$Date, "%d/%m/%Y")
png("plot2.png", width = 480, height = 480, units = "px")
with(powerdata, plot(strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S"),Global_active_power, xlab="",ylab = "Global Active Power (killowatts)",type="l"))
dev.off()

