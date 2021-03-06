readAndTidyData <- function(filename) {
  dataOrig <- read.table(filename, header=TRUE, sep=";", na.strings="?")  
  # Only need dates 2007-02-01 and 2007-02-02.
  df <- dataOrig[dataOrig$Date %in% c("1/2/2007", "2/2/2007"),]  
  # Convert the Date and Time variables to Date/Time classes in R.
  df$DateTime <- strptime(paste(df$Date, df$Time, sep=" "),
                          format="%d/%m/%Y %H:%M:%S")
  df$Date <- NULL
  df$Time <- NULL
  df <- df[,c(ncol(df),1:(ncol(df)-1))]
}

df <- readAndTidyData("../exdata-data-household_power_consumption/household_power_consumption.txt")

# Open png device.
png(filename="plot3.png", width=480, height=480, units="px", pointsize="12", bg="transparent")

# Plot.
with(df, plot(DateTime, Sub_metering_1, type="l", col="black",
              ylab="Energy sub metering", xlab=""))
with(df, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(df, lines(DateTime, Sub_metering_3, type="l", col="blue"))
with(df, legend("topright",
                legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                lty=1,
                col=c("black", "red", "blue")))

# Close png device.
dev.off()
