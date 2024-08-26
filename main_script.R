## packages

install.packages("lubridate")
library(lubridate) # used to round to the next hour

install.packages("dplyr")
library(dplyr)

install.packages("readxl")
library(readxl)

# VEHICLES DF - CLEANING
vehicles_df <- read.csv("data/vehicles.csv", header=TRUE)
vehicles_df$CRASH.DATE <- as.Date(vehicles_df$CRASH.DATE, format = "%m/%d/%Y")
columns_to_remove <- c(
                       "CROSS.STREET.NAME",
                       "ON.STREET.NAME",
                       "OFF.STREET.NAME", 
                       "CONTRIBUTING.FACTOR.VEHICLE.3",
                       "CONTRIBUTING.FACTOR.VEHICLE.4", 
                       "CONTRIBUTING.FACTOR.VEHICLE.5",
                       "VEHICLE.TYPE.CODE.3",
                       "VEHICLE.TYPE.CODE.4",
                       "VEHICLE.TYPE.CODE.5",
                       "COLLISION_ID"
                       )
vehicles_df <- vehicles_df %>%
  select(-all_of(columns_to_remove))

# Filter the dataframe
vehicles_df <- vehicles_df[vehicles_df$CRASH.DATE >= cutoff_date, ]
glimpse(vehicles_df)

# Define the cutoff date as other dataframe starts with 2016
cutoff_date <- as.Date("2016-01-01")

vehicles_df <- vehicles_df %>%
  # Combine date and time into one string
  mutate(CRASH.TIME = as.POSIXct(paste(CRASH.DATE, CRASH.TIME), format = "%Y-%m-%d %H:%M")) %>%
  # Round up to the next hour
  mutate(CRASH.TIME = ceiling_date(CRASH.TIME, "hour")) %>%
  # Create the final CRASH.DATETIME column
  mutate(CRASH.DATETIME = CRASH.TIME)

# write.csv(vehicles_df,"vehicles_v2.csv")


# WEATHER DF - CLEANING
weather_df <- read_excel("data/weather.xlsx")

# Convert the TIME column to correct format
weather_df <- weather_df %>%
  mutate(time = as.POSIXct(time, format = "%Y-%m-%dT%H:%M"))
glimpse(weather_df)


# MERGING DATAFRAMES
merged_df <- inner_join(vehicles_df, weather_df, by = c("CRASH.DATETIME" = "time"))








