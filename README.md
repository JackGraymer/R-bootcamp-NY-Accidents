# r-bootcamp project - [New York Traffic Accidents report](https://jackgraymer.github.io/R-bootcamp-NY-Accidents/)
## Motor vehicle crashes in New York.
## Description
This analysis aims to provide some insight about the car crashes in New York during the period of 2016 to 2022, focusing on some key factors such as vehicle type, time and weather.

## Files
We count with 2 datasets, one cointaining the vehicle crashes and the second one about the weather of the location.

| Name                       | Rows     | Columns | Each row is a                          | Link                                                                                      |
|----------------------------|----------|---------|----------------------------------------|-------------------------------------------------------------------------------------------|
| **Vehicles dataset**       | 2.11M    | 29      | Motor Vehicle Collision                | [Vehicles dataset](https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95/data_preview) |
| **Weather dataset**        | 59,760   | 10      | Time stamp of Weather                  | [Weather dataset](https://www.kaggle.com/datasets/aadimator/nyc-weather-2016-to-2022?resource=download)                   |

## Structure

Running `document.Rmd` will create the final output.

As a testing sandbox, some of the code was developed in `main_script.R` and once tested was moved to the document.

Some parts like Esquisse and Shiny can't be included in the final document as they require a server running the local app, so screenshots were made and included in the `resource folder`.

    📦r-bootcamp-assignment
    ┣ 📂data
    ┃ ┣ 📜merged_all_years.csv
    ┃ ┣ 📜merged_data_2016.csv
    ┃ ┣ 📜merged_data_2017.csv
    ┃ ┣ 📜merged_data_2018.csv
    ┃ ┣ 📜merged_data_2019.csv
    ┃ ┣ 📜merged_data_2020.csv
    ┃ ┣ 📜merged_data_2021.csv
    ┃ ┣ 📜vehicles.csv
    ┃ ┣ 📜weather.xlsx
    ┃ ┗ 📜weather_2021.xlsx
    ┣ 📂resources
    ┃ ┣ 📜esquisse people injured.png
    ┃ ┣ 📜esquisse people killed.png
    ┃ ┣ 📜esquisse.png
    ┃ ┣ 📜esquisse_plotly.png
    ┃ ┗ 📜shiny.png
    ┣ 📜.gitignore
    ┣ 📜Assignment_Rbootcamp.pdf
    ┣ 📜document.html
    ┣ 📜document.Rmd
    ┣ 📜main_script.R
    ┣ 📜README.md
    ┗ 📜shiny.R

## Milestones
- Clean Vehicles dataset
  - Remove columns and rows with too many NAs
  - Structure date and time columns
  - Round time to hours 
- Prepare Weather dataset
  - Adapt timestamp, separate for date and time in different columns
- change both dataset col names to the same
- Merge both datasets with date and time (use `merge(x, y, by=c("k1","k2"))`)
- Summary statistics and Visualization 
  - Analysis by Time grouped by hour, day, month
  - Type of car (sedan, SUV with more accidents) hopefully SUV sucks
  - Interactive map of NY crashes
  - Injuries vs Deaths
  - etc.
- Chapter of choice (Where the package Esquisse is expalined and used)
- ChatGPT as a tool for data science
- Conclusion

[Github Repository](https://github.com/lucarenz1997/r-bootcamp-assignment)

