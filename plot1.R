readAndTidyData <- function(filename) {
  dataOrig <- read.table(filename, header=TRUE, sep=";", na.strings="?")  
  # Only need dates 2007-02-01 and 2007-02-02.
  df <- dataOrig[dataOrig$Date %in% c("1/2/2007", "2/2/2007"),]  
  # Convert the Date and Time variables to Date/Time classes in R.
  df$DateTime <- paste(df$Date, df$Time, sep=" ")
  df$Date <- NULL
  df$Time <- NULL
  df <- df[,c(ncol(df),1:(ncol(df)-1))]
}

df <- readAndTidyData("../exdata-data-household_power_consumption/household_power_consumption.txt")

png(filename="plot1.png", width=480, height=480, units="px", pointsize="12", bg="transparent")
hist(df$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()
