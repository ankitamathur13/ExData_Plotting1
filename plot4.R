library(sqldf)
field.types<-list(Date='datetime',Time='datetime',Global_active_power='number',
	Global_reactive_power='number',Voltage='number',Global_intensity='number',Sub_metering_1='number',Sub_metering_2='number',Sub_metering_3='number')

powerdata <- read.csv.sql("household_power_consumption.txt",sql="select * from file where Date='1/2/2007' or Date='2/2/2007'", sep=";",header=TRUE)
powerdata$Date <-as.Date(powerdata$Date, "%d/%m/%Y")
powerdata$Datetime <- with(powerdata, strftime(paste(Date, Time), "%Y-%d-%m %H:%M:%S"))

png("plot4.png", width = 480, height = 480, units = "px")
#set plot to be 2x2 matrix
par(mfrow=c(2,2))

#plot 1
with(powerdata, plot(strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S"),Global_active_power, xlab="",ylab = "Global Active Power (killowatts)",type="l"))

#plot 2
with(powerdata, plot(strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S"),Voltage, xlab="datetime",ylab = "Voltage",type="l"))

#plot 3
with(powerdata, plot(Sub_metering_1, xlab="", ylab = "Energy Sub Metering", type="l" , xaxt="n"))
axis(1, at=c(1,(dim(powerdata)[1]/2)+1,dim(powerdata)[1]), labels=c("Thu", "Fri","Sat"))
lines(powerdata$Sub_metering_2, col="blue")
lines(powerdata$Sub_metering_2, col="red")
lines(powerdata$Sub_metering_3, col="blue")
legend('topright',  names(powerdata)[7:9] ,lty=1, col=c('black','red', 'blue'), cex=.75)

#plot 4
with(powerdata, plot(strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S"),Global_reactive_power, xlab="datetime",type="l"))

#close the device
dev.off()


