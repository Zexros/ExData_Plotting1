# Library ----

library(dplyr)
library(lubridate)
library(tidyr)

# Setting directory ----

wd_root <- "/home/glauco"

wd_project <- paste0(wd_root, "/R/local")

if (getwd() != wd_project){
  setwd(wd_project)
}

# data acquisition and cleaning ---- 

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

filename_zip <- "exdata_data_household_power_consumption.zip"

filedataset <- paste0(wd_project, "/dataset")

filedir <- paste0(filedataset,"/",filename_zip)

filename_unzip <- "household_power_consumption.txt"

filedir_unzip <- paste0(filedataset,"/",filename_unzip)

if (!file.exists(filedir)){ 
  download.file(fileURL, filedir, method="curl")
  unzip(filedir, exdir = filedataset)
} 

if(file.exists(filedir_unzip)){
  
  eletric_power_df <- read.table(filedir_unzip, header = TRUE, sep = ";")
  eletric_power_df[eletric_power_df =="?"] <- NA
  eletric_power_df$Global_active_power <- as.numeric(eletric_power_df$Global_active_power)
  eletric_power_df$Global_reactive_power <- as.numeric(eletric_power_df$Global_reactive_power)
  eletric_power_df$Voltage <- as.numeric(eletric_power_df$Voltage)
  eletric_power_df$Global_intensity <- as.numeric(eletric_power_df$Global_intensity)
  eletric_power_df$Sub_metering_1 <- as.numeric(eletric_power_df$Sub_metering_1)
  eletric_power_df$Sub_metering_2 <- as.numeric(eletric_power_df$Sub_metering_2)
  eletric_power_df$Sub_metering_3 <- as.numeric(eletric_power_df$Sub_metering_3)
  eletric_power_df$DateTime <-dmy_hms(paste(eletric_power_df$Date, eletric_power_df$Time))
}

df_filter <- filter(eletric_power_df, as.Date(eletric_power_df$DateTime) >= dmy("01-02-2007") & as.Date(eletric_power_df$DateTime) <= dmy("02-02-2007")) %>%
  drop_na()


# Create Charts ----

# Library ----

library(dplyr)
library(lubridate)
library(tidyr)

# Setting directory ----

wd_root <- "/home/glauco"

wd_project <- paste0(wd_root, "/R/local")

if (getwd() != wd_project){
  setwd(wd_project)
}

# data acquisition and cleaning ---- 

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

filename_zip <- "exdata_data_household_power_consumption.zip"

filedataset <- paste0(wd_project, "/dataset")

filedir <- paste0(filedataset,"/",filename_zip)

filename_unzip <- "household_power_consumption.txt"

filedir_unzip <- paste0(filedataset,"/",filename_unzip)

if (!file.exists(filedir)){ 
  download.file(fileURL, filedir, method="curl")
  unzip(filedir, exdir = filedataset)
} 

if(file.exists(filedir_unzip)){
  
  eletric_power_df <- read.table(filedir_unzip, header = TRUE, sep = ";")
  eletric_power_df[eletric_power_df =="?"] <- NA
  eletric_power_df$Global_active_power <- as.numeric(eletric_power_df$Global_active_power)
  eletric_power_df$Global_reactive_power <- as.numeric(eletric_power_df$Global_reactive_power)
  eletric_power_df$Voltage <- as.numeric(eletric_power_df$Voltage)
  eletric_power_df$Global_intensity <- as.numeric(eletric_power_df$Global_intensity)
  eletric_power_df$Sub_metering_1 <- as.numeric(eletric_power_df$Sub_metering_1)
  eletric_power_df$Sub_metering_2 <- as.numeric(eletric_power_df$Sub_metering_2)
  eletric_power_df$Sub_metering_3 <- as.numeric(eletric_power_df$Sub_metering_3)
  eletric_power_df$DateTime <-dmy_hms(paste(eletric_power_df$Date, eletric_power_df$Time))
}

df_filter <- filter(eletric_power_df, as.Date(eletric_power_df$DateTime) >= dmy("01-02-2007") & as.Date(eletric_power_df$DateTime) <= dmy("02-02-2007")) %>%
  drop_na()


# Create Charts ----

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(df_filter, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
#Save Charts -----

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()

#Remove old data and reset directory ----

rm(list = ls())

setwd(wd_root)



#Save Charts -----

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

#Remove old data and reset directory ----

rm(list = ls())

setwd(wd_root)
