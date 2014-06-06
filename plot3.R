###
#using the package
# sqldf lead to long loading time of the data:
#library("sqldf")
#mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
#myFile <- "household_power_consumption.txt"
#myData <- read.csv2.sql(myFile,mySql)
#
###############
# I read first the whole table to find the rows which shall be processed
# first I find out how muc rows shall can be skipped --> 66637 rows
# then I find out how much rows have to be processed for the two days mentoined
#hpc <- read.table("household_power_consumption.txt",
#                  sep = ";", 
#                  col.names = colnames(read.table(
#                  "household_power_consumption.txt",
#                   nrow = 1, header = TRUE, sep=";")))
# hpcsub=subset(hpc, Date=="1/2/2007")
# nrow(hpcsub) -->1440
# hpcsub=subset(hpc, Date=="2/2/2007")
# nrow(hpcsub) -->1440
#########################
#
#This leads to the following statement to read only the rows which shall be processed which runs very fast
#Of course this is a rather brute force approach 
#
#
hpc <- read.table("household_power_consumption.txt",
                  skip = 66637, nrow = 2880, sep = ";", 
                  col.names = colnames(read.table(
                  "household_power_consumption.txt",
                   nrow = 1, header = TRUE, sep=";")))
#create new row with date time
dt= paste(hpc$Date,hpc$Time )
hpc$DateTime= strptime(dt, "%d/%m/%Y %H:%M:%S")

#plot 3

plot(hpc$DateTime,hpc$Sub_metering_1,type="l",col="black",main="",xlab="",ylim=c(0,40),
	ylab="Energy sub metering")

par(new=TRUE)
plot(hpc$DateTime,hpc$Sub_metering_2,type="l",col="red",main="",xlab="",ylim=c(0,40),
	ylab="Energy sub metering")

par(new=TRUE)
plot(hpc$DateTime,hpc$Sub_metering_3,type="l",col="blue",main="",xlab="",ylim=c(0,40),
	ylab="Energy sub metering")
legend("topright",lty=1,col=c("black","red","blue"),
	legend=c("Sub metering 1","Sub metering 2","Sub metering 3"))


dev.copy(png,file="plot3.png",width=480,height=480,bg = "transparent" )
dev.off()