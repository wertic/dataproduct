library(shiny)

shinyUI(fluidPage(
  
  titlePanel("MPG prediction model"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Model parameters"),      
      checkboxInput("use_cyl", label = "Use Number of cylinders", value = TRUE), 
      checkboxInput("use_hp", label = "Use Gross horsepower", value = TRUE),
      checkboxInput("use_wt", label = "Use Weight", value = TRUE),
      h3("Prediction parameters"),
      sliderInput("p_cyl", "Number of cylinders:", 
                  min = 4, max = 8, value = 6.0, step=2),
      sliderInput("p_hp", "Gross horsepower:", 
                  min = 52, max = 335, value = 60.0, step=1),
      sliderInput("p_wt", "Weight:", 
                  min = 1.513, max = 5.424, value = 3.420, step= 0.1)
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Summary", 
                           h3("Executive summary"),
                           p("The model is based on the linear model and allows to predict mpg Miles/US gallon
                             based on weight, horsepower and the number of cylinders."),
                           h3("Data source"),
                           p("All the data for this model provided is publically available dataser in R libs."), 
                           br()                           
                  ), 
                  tabPanel("Exploratory analysis", 
                           h3("Model data summary"),
                           verbatimTextOutput("summary"),
                           h3("Parameters historgrams"),
                           plotOutput("mpg_plot"),
                           plotOutput("cyl_plot"),
                           plotOutput("hp_plot"),
                           plotOutput("wt_plot"),
                           plotOutput("corr_plot")
                  ),
                  tabPanel("Prediction", 
                           div(class="jumbotron",
                                 h3("Predicted mpg"),
                                 h1(textOutput("prediction"))
                               ),
                           h3("The model overview"),
                           verbatimTextOutput("model_summary")
                  )
      )
    )
  )
))