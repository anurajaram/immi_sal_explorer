# Author - Anupama Rajaram
# server.R file for showing Survivor statistics for Titanic passengers 
# weblink = https://anurajaram.shinyapps.io/immi-sal/
# Displays 3 types of charts, based on selection
#     (a) No. of Survivors by gender & passenger class
#     (b) Salary by visa class - greencard, H1-B, etc.
#     (c) Salary by industry/ job title


library(shiny)

# load the salary dataset for immigrant workers
sal_data <- read.csv("salary.csv", header = TRUE)


# function definition, to be used if input selection = "Salary by Visa class"
visapie <- function(){
  boxplot(PAID_WAGE_PER_YEAR~ EDUCATION_LEVEL_REQUIRED, data=sal_data,
          col=(c("gold","darkgreen")),
          # specifying some color
          main="Median Salary by Education level", 
          xlab="Visa Class", ylab="Annual Salary")
}



library(plotly)
library(ggplot2)


shinyServer( function(input, output) 
    {
  
  
  data1 <- reactive({
      switch(input$visa_type , 
                   "e3aus" = "47 applications",
                   "gc" = "51 applications",
                   "h1b" = "504 applications",
                   "h1bsg" = "4 applications")
  })
  
  # output based on radion button selection
    output$value <- renderText({ data1()  })
    
    

  # call from ui.R file comes here
  # we will display output based on input selection, so using switch statement
  output$distPlot <- renderPlot({
    
  
    p <- ggplot(sal_data, 
                aes(x = VISA_CLASS, fill= JOB_TITLE_SUBGROUP)) + 
                geom_bar( position = "dodge")  
    
    data <- switch(input$plotseln, 
                   "Salary by State" = plot(sal_data$WORK_STATE, 
                                            sal_data$PAID_WAGE_PER_YEAR,
                                            main="Salary by visa class", 
                                            xlab="Visa Class", 
                                            ylab="Annual Salary"),
                   
                   "Salary by Education" = visapie(), 
                   # call to pre-defined function
                   
                   "Visa applications by job_title" =  print(p)
    
        
                   )

    
  })

    
      
}

)