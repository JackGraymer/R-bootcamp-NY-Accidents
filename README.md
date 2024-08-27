# r-bootcamp project
# Motor vehicle crashes in New York.
## Description
This analysis aims to provide some insight about the car crashes in New York during the period of 2016 to 2022, focusing on some key factors such as vehicle type, hour and weather.

## Files
We count with 2 datasets, one cointaining the vehicle crashes and the second one about the weather of the location.

| Name                       | Rows     | Columns | Each row is a                          | Link                                                                                      |
|----------------------------|----------|---------|----------------------------------------|-------------------------------------------------------------------------------------------|
| **Vehicles dataset**       | 2.11M    | 29      | Motor Vehicle Collision                | [Vehicles dataset](https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95/data_preview) |
| **Weather dataset**        | 59,760   | 10      | Time stamp of Weather                  | [Weather dataset](https://www.kaggle.com/datasets/aadimator/nyc-weather-2016-to-2022?resource=download)                   |



## ToDo (Future Milestones)
- Clean Vehicles dataset
  - Remove columns and rows with too many NAs
  - Structure date and time columns
  - Round time to hours 
- Prepare Weather dataset
  - Adapt timestamp, separate for date and time in different columns
- change both dataset col names to the same
- Merge both datasets with date and time (use `merge(x, y, by=c("k1","k2"))`)
- Summary statistics and Visualization 
  - rain vs accidents general
  - rain in motorbikes vs cars
  - type of car (sedan, SUV with more accidents) hopefully SUV sucks
  - increase in electric scooters accidents
  - 
- 