#####
#
# Script: plot1.R
#
#    Plot the "Global Active Power" histogram according the the project directions that is:
#
#####

#
# Step 1: Read the data file and cerate the related dataset named EPC
#
ElecPwrCons = read.csv(file="household_power_consumption.txt",sep=";",header = TRUE, stringsAsFactors=FALSE, 
                       na.strings="?",
                       colClasses=c("character","character",replicate(7,"numeric")), 
                       col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

Sys.setlocale("LC_TIME", "C")
ElecPwrCons$DateTime = strptime(paste(ElecPwrCons$Date,ElecPwrCons$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
EPC = subset(ElecPwrCons, ElecPwrCons$DateTime>=strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S") &  ElecPwrCons$DateTime<=strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S") )

EPC$Date = NULL  # Get ride of now useless Date column
EPC$Time = NULL  # Get ride of now useless Time column

rm(ElecPwrCons)  # save some memory by removing now useless ElecPwrCons dataset

#
# Step 2: Create the histogram into plot1.png file
#
png(file = "plot1.png", bg = "white", width = 480, height = 480)
hist(EPC$Global_active_power, 
     main="Global Active Power", 
     border="black", 
     col="red", 
     xlab="Global Active Power (kilowatts)" )
dev.off()

png(file = "plot2.png", bg = "white", width = 480, height = 480)
plot(EPC$DateTime,EPC$Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab="")
lines(EPC$DateTime,EPC$Global_active_power)
dev.off()

png(file = "plot3.png", bg = "white", width = 480, height = 480)
plot(EPC$DateTime,EPC$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
legend("topright",
       border="black",
       col=c("black","red","blue"),
       text.col="black",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1)
       )
lines(EPC$DateTime,EPC$Sub_metering_1,col="black")
lines(EPC$DateTime,EPC$Sub_metering_2,col="red")
lines(EPC$DateTime,EPC$Sub_metering_3,col="blue")
dev.off()