######
#
# Script: 0.ReadAndFormatDataset.R
#
# Read, format and filter the "Electric Power Consumption" dataset according to the project
# requirements, that is Electric power consumer from 2007-02-01 to 2007-02-02:
#
# Reminder of variables in the Dataset:
#   Date: Date in format dd/mm/yyyy
#   Time: time in format hh:mm:ss
#   Global_active_power: household global minute-averaged active power (in kilowatt)
#   Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#   Voltage: minute-averaged voltage (in volt)
#   Global_intensity: household global minute-averaged current intensity (in ampere)
#   Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#   Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#   Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
#
#
#Output: EPC : Filtered dataset with following variables:
#   Global_active_power: household global minute-averaged active power (in kilowatt)
#   Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#   Voltage: minute-averaged voltage (in volt)
#   Global_intensity: household global minute-averaged current intensity (in ampere)
#   Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#   Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#   Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
#   DateTime: date and Time in POSIX format
######

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