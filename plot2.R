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

# Plot 2
png("plot2.png")
plot(datetimes, 
     as.numeric(as.character(data$Global_active_power)), # Convert factor into numeric
     ylab ="Global Active Power (kilowatts)",
     type = "l",
     xlab = "")
dev.off()