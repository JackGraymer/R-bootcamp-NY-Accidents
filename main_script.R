# VEHICLES DF - CLEANING
vehicles_df <- read.csv("data/vehicles.csv", header=TRUE)
vehicles_df$CRASH.DATE <- as.Date(vehicles_df$CRASH.DATE, format = "%m/%d/%Y")

# Define the cutoff date as other dataframe starts with 2016
cutoff_date <- as.Date("2016-01-01")

# Filter the dataframe
vehicles_df <- vehicles_df[vehicles_df$CRASH.DATE >= cutoff_date, ]


# WEATHER DF - CLEANING

install.packages("readxl")
library(readxl)
weather_df <- read_excel("data/weather.xlsx")


# MERGING DATAFRAMES





