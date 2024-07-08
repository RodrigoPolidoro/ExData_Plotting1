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
png(file="plot3.png",width=480,height=480)

# Plot energy sub metering along the time frame
with(hc_feb07, {
    plot(Date_Time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black")
    lines(Date_Time, Sub_metering_2, col = "red")
    lines(Date_Time, Sub_metering_3, col = "blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, col = c("black", "blue", "red"), cex = 1)
})

# Close PNG device
dev.off()
