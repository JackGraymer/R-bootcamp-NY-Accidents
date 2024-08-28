# Load necessary libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)

# Load the data
accident_data <- read.csv("data/merged_data_2021.csv", header = TRUE)
accident_data$CRASH.DATE <- as.Date(accident_data$CRASH.DATE)
min_date <- min(accident_data$CRASH.DATE, na.rm = TRUE)
max_date <- max(accident_data$CRASH.DATE, na.rm = TRUE)

# Define UI for the Shiny app
ui <- fluidPage(
  titlePanel("Accident Data Filter"),
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("date_range", "Select Date Range:",
                     start = min_date,
                     end = max_date,
                     min = min_date,
                     max = max_date),
      selectInput("weekday", "Select Weekday(s):", 
                  choices = unique(accident_data$Weekday),
                  selected = c("Monday", "Wednesday", "Friday"),
                  multiple = TRUE),
      checkboxInput("is_deadly", "Accidents with Death(s)", value = FALSE),
      checkboxInput("is_injured", "Accidents with injured people", value = FALSE),
      actionButton("filter", "Apply Filters")
    ),
    
    mainPanel(
      plotOutput("accident_plot")
    )
  )
)
# Define server logic for the Shiny app
server <- function(input, output) {
  
  filtered_data <- reactive({
    data <- accident_data
    
    # Extract start and end dates from the input
    start_date <- input$date_range[1]
    end_date <- input$date_range[2]
    
    # Filter by the date range
    data <- data %>% filter(CRASH.DATE >= start_date & CRASH.DATE <= end_date)
    
    # Filter by weekdays
    data <- data %>% filter(Weekday %in% input$weekday)
    
    # Filter by deadly accidents
    if (input$is_deadly) {
      data <- data %>% filter(IS.DEADLY.ACCIDENT == TRUE)
    }
    
    # Filter by injured accidents
    if (input$is_injured) {
      data <- data %>% filter(IS.INJURED.ACCIDENT == TRUE)
    }
    
    return(data)
  })
  
  output$accident_plot <- renderPlot({
    data <- filtered_data()
    
    # Summarize the data to get the count of accidents per weekday
    data_summary <- data %>% 
      group_by(Weekday) %>% 
      summarise(Number_of_Accidents = n())
    
    # Plot the number of accidents by weekday
    ggplot(data_summary, aes(x = Weekday, y = Number_of_Accidents, fill = Weekday)) +
      geom_bar(stat = "identity") +
      labs(title = "Number of Accidents by Weekday",
           x = "Weekday",
           y = "Number of Accidents") +
      theme_minimal()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
