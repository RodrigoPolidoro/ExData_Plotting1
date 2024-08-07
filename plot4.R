# Import lubridate library
library(lubridate)

# Read the dataset into R
house_consumption = read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Convert date and time variables to its appropriates classes
house_consumption$Date = dmy(house_consumption$Date)
house_consumption$Time = hms(house_consumption$Time)

# Subset to find only the values between February 1st and February 2nd of 2007
hc_feb07 = house_consumption[ house_consumption$Date %in% c(dmy("01/02/2007"), dmy("02/02/2007")), ]

# Remove the original data frame
# Perform garbage collection to free up memory
rm(house_consumption)
gc()

# Convert class of numeric columns to numeric
hc_feb07[, -c(1, 2)] = sapply(hc_feb07[, -c(1, 2)], as.numeric)

# Creates date time column
hc_feb07$Date_Time = make_datetime(year(hc_feb07$Date), month(hc_feb07$Date), day(hc_feb07$Date),
                                   hour(hc_feb07$Time), minute(hc_feb07$Time), second(hc_feb07$Time))

# Start PNG device
png(file="plot4.png",width=480,height=480)

# Set 4 plotting screens
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

with(hc_feb07, {
  # First plot
  plot(Date_Time, Global_active_power, type = "l", ylab = "Global Active Power", xlab = "", col = "black", xaxt = "n")
  axis(1, at=c(dmy_hms("01/02/2007 00:00:00"), dmy_hms("02/02/2007 00:00:00"), dmy_hms("03/02/2007 00:00:00")), labels=c("Thu","Fri","Sat"))
  
  # Second plot
  plot(Date_Time, Voltage, type = "l", ylab = "Voltage", xlab = "", col = "black", xaxt = "n")
  axis(1, at=c(dmy_hms("01/02/2007 00:00:00"), dmy_hms("02/02/2007 00:00:00"), dmy_hms("03/02/2007 00:00:00")), labels=c("Thu","Fri","Sat"))
  
  # Third plot
  plot(Date_Time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black", xaxt = "n")
  lines(Date_Time, Sub_metering_2, col = "red")
  lines(Date_Time, Sub_metering_3, col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, col = c("black", "blue", "red"), cex = 1, bty = "n")
  axis(1, at=c(dmy_hms("01/02/2007 00:00:00"), dmy_hms("02/02/2007 00:00:00"), dmy_hms("03/02/2007 00:00:00")), labels=c("Thu","Fri","Sat"))
  
  # Fourth plot
  plot(Date_Time, Global_reactive_power, type = "l", ylab = "Global Active Power", xlab = "", col = "black", xaxt = "n")
  axis(1, at=c(dmy_hms("01/02/2007 00:00:00"), dmy_hms("02/02/2007 00:00:00"), dmy_hms("03/02/2007 00:00:00")), labels=c("Thu","Fri","Sat"))
})

# Close PNG device
dev.off()