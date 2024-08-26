## packages

# install.packages("lubridate")
library(lubridate) # used to round to the next hour

# install.packages("dplyr")
library(dplyr)

# install.packages("readxl")
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


# Create broader categories for main causes
# Your list of strings
conditions <- c("Aggressive Driving/Road Rage", "Pavement Slippery", "Following Too Closely", 
                "Unspecified", "", "Passing Too Closely", "Driver Inexperience", 
                "Passing or Lane Usage Improper", "Turning Improperly", "Unsafe Lane Changing", 
                "Unsafe Speed", "Reaction to Uninvolved Vehicle", "Steering Failure", 
                "Traffic Control Disregarded", "Other Vehicular", "Driver Inattention/Distraction", 
                "Oversized Vehicle", "Pedestrian/Bicyclist/Other Pedestrian Error/Confusion", 
                "Alcohol Involvement", "View Obstructed/Limited", "Failure to Yield Right-of-Way", 
                "Illnes", "Lost Consciousness", "Brakes Defective", "Backing Unsafely", "Glare", 
                "Passenger Distraction", "Fell Asleep", "Obstruction/Debris", "Tinted Windows", 
                "Animals Action", "Drugs (illegal)", "Pavement Defective", "Other Lighting Defects", 
                "Outside Car Distraction", "Driverless/Runaway Vehicle", "Tire Failure/Inadequate", 
                "Fatigued/Drowsy", "Headlights Defective", "Accelerator Defective", 
                "Failure to Keep Right", "Physical Disability", "Eating or Drinking", 
                "Cell Phone (hands-free)", "Lane Marking Improper/Inadequate", 
                "Cell Phone (hand-Held)", "Using On Board Navigation Device", "Other Electronic Device", 
                "Traffic Control Device Improper/Non-Working", "Tow Hitch Defective", 
                "Windshield Inadequate", "Vehicle Vandalism", "Shoulders Defective/Improper", 
                "Prescription Medication", "Listening/Using Headphones", "Texting", "80", 
                "Reaction to Other Uninvolved Vehicle", "1", "Drugs (Illegal)", "Illness", 
                "Cell Phone (hand-held)")

# Create categorizatoin/mapping for conditions
categorize_condition <- function(condition) {
  if (grepl("Driving|Following|Passing|Inexperience|Improper|Changing|Speed|Distraction|Alcohol|Drugs|Phone|Eating|Fatigued|Sleeping|Pedestrian|Failure to Yield|Backing|Oversized", condition, ignore.case = TRUE)) {
    return("Human Error")
  } else if (grepl("Brakes|Steering|Tire|Headlights|Accelerator|Windshield|Tow Hitch|Defective|Failure", condition, ignore.case = TRUE)) {
    return("Mechanical Error")
  } else if (grepl("Pavement|Glare|Obstruction|Weather|Animals|View|Control|Shoulders", condition, ignore.case = TRUE)) {
    return("Environmental Conditions")
  } else if (grepl("Illness|Lost Consciousness|Physical Disability", condition, ignore.case = TRUE)) {
    return("Medical Condition")
  } else if (condition == "" || grepl("Unspecified|Other", condition, ignore.case = TRUE)) {
    return("Other/Unspecified")
  } else {
    return("Other/Unspecified")
  }
}


# create new column with broader category for accident
vehicles_df <- vehicles_df %>%
  mutate(Category = sapply(CONTRIBUTING.FACTOR.VEHICLE.1, categorize_condition))

# Define the cutoff date as other dataframe starts with 2016
cutoff_date <- as.Date("2016-01-01")
vehicles_df <- vehicles_df[vehicles_df$CRASH.DATE >= cutoff_date, ]
vehicles_df <- vehicles_df %>%
  # Combine date and time into one string
  mutate(CRASH.TIME = as.POSIXct(paste(CRASH.DATE, CRASH.TIME), format = "%Y-%m-%d %H:%M")) %>%
  # Round up to the next hour
  mutate(CRASH.TIME = ceiling_date(CRASH.TIME, "hour")) %>%
  # Create the final CRASH.DATETIME column
  mutate(CRASH.DATETIME = CRASH.TIME)


# WEATHER DF - CLEANING
weather_df <- read_excel("data/weather.xlsx")

# Convert the TIME column to correct format
weather_df <- weather_df %>%
  mutate(time = as.POSIXct(time, format = "%Y-%m-%dT%H:%M"))
glimpse(weather_df)


# MERGING DATAFRAMES
merged_df <- inner_join(vehicles_df, weather_df, by = c("CRASH.DATETIME" = "time"))

write.csv(merged_df,"merged.csv")