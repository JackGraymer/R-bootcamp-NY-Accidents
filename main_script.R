df <- read.csv("datasets/Motor_Vehicle_Collisions_-_Crashes_20240826.csv", header=TRUE)
colnames(df)
df$CRASH.DATE
df$CRASH.TIME

# Assuming DataFrame A is named df_A and DataFrame B is named df_B

# Convert crash.date and crash.time to a POSIXct datetime object in df_A
df$datetime <- as.POSIXct(paste(df$crash.date, df$crash.time), format = "%m/%d/%Y %H:%M")



