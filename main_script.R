df <- read.csv("datasets/Motor_Vehicle_Collisions_-_Crashes_20240826.csv", header=TRUE)
head(df)
df$datetime <- as.POSIXct(paste(df$crash.date, df$crash.time), format = "%m/%d/%Y %H:%M")



