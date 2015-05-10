# Read data
data <- read.table("household_power_consumption.txt", 
                   nrows = 173000,
                   sep = ";",
                   header = TRUE)

s <- split(data, data$Date)
data <- rbind(s[[2]], s[[46]]) # These are the two dates we need
rm(s) # We no longer need s

# Convert Date and Time columns into date-time (POSIXlt) format:
data[, "Date"] <- as.Date(data$Date, format="%d/%m/%Y")

dates <- data[, 1]
times <- data[, 2]
datetimes <- paste(dates, times)   
datetimes <- strptime(datetimes, "%Y-%m-%d %H:%M:%S")   

# Plot 3
png("plot3.png")
plot(datetimes, 
     as.numeric(as.character(data$Sub_metering_1)), # Convert factor into numeric
     ylab ="Energy sub metering",
     type = "l",
     xlab = "")
lines(datetimes, 
      as.numeric(as.character(data$Sub_metering_2)), # Factor into numeric
      col = "red")
lines(datetimes, 
      as.numeric(as.character(data$Sub_metering_3)), # Factor into numeric
      col = "blue")
legend("topright",
       lty = "solid",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()