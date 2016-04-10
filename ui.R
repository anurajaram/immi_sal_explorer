# Author - Anupama Rajaram
# ui.R file for showing salary variations for highly skilled immigrant workers.
# Shiny app called "titanic_app" 
# sidebar allows selection of 3 types of charts
#     (a) Median salary by US state
#     (b) Salary by visa class - greencard, H1-B, etc.
#     (c) Salary by industry/ job title

library(shiny)

# load the salary dataset
sal_data <- read.csv("salary.csv", header = TRUE)
freq_visa <- table(sal_data$VISA_CLASS)



library(ggplot2)


# code to format page layout, input selection on left, output chart on right
fluidPage(
  
  titlePanel("Skilled Immigrant Salary Explorer"),
  
  sidebarPanel(
    
    # select the visa type, to get the count
    radioButtons("visa_type", "No. of applications submitted - select visa type",
                 c("E-3 Australian" = "e3aus",
                   "Greencard" = "gc",
                   "H1-B visa" = "h1b",
                   "H1-B1 Singapore" = "h1bsg")),
    hr(),
    helpText("No. of visa applications : "),
    textOutput( "value"),
    
  br(),
  br(),
    
    
    # code below provides users with a dropdown box with 3 options
    selectInput("plotseln", 
                label = " Select plot for viewing",
                choices = c("Salary by State", 
                            "Salary by Education",
                            "Visa applications by job_title"),
                # also specifying default selection
                selected = "Visa applications by job_title")
    
  ),
  
  # main panel which will display the charts based on selection
  # call to object in server.R file
  mainPanel(
    plotOutput("distPlot")
    
  )
)