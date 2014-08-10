## load library in order to use sql query to read relevant data
library(sqldf)

## assign file name of the data file in the working directory
my_file <- "household_power_consumption.txt"

## read data into a data frame called df for two days in February
df <- read.csv.sql(my_file, sep=";",sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"')

## explicitly set Date and Time to date/time type with strotime function
df$Date<- strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")
df$Time<- strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")

## modify default parameters to change the layout of data
par(mar = c(2,4,1,1))

## plot empty chart and subsequent lines
with(df, plot(Date, Sub_metering_1, type = "n", ylab = "Energy submetering", xlab = " "))
with(df, lines(Date, Sub_metering_1, type = "l", col = "black"))
with(df, lines(Date, Sub_metering_2, type = "l", col = "red"))
with(df, lines(Date, Sub_metering_3, type = "l", col = "blue"))

## insert legend
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
