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

# Start PNG device
png(file="plot1.png",width=480,height=480)

# Plot global active power histogram
hist(hc_feb07$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

# Close PNG device
dev.off()