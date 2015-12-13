library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Generate a summary of the data
  output$summary <- renderPrint({
    summary(mtcars)
  })

  output$mpg_plot <- renderPlot({
    hist(mtcars$mpg, main = "Miles/Gallon", xlab = "Miles/Gallon")
  })
  
  output$cyl_plot <- renderPlot({
    hist(mtcars$cyl, main = "Cilinders", xlab = "number")
  })
  
  output$hp_plot <- renderPlot({
    hist(mtcars$hp, main = "Horsepower", xlab = "hp")
  })

  output$wt_plot <- renderPlot({
    hist(mtcars$wt, main = "Weight", xlab = "lbs")
  })
  
  output$corr_plot <- renderPlot({
    pairs(~mpg + cyl + hp + wt, data=mtcars, main="Parameters correlation matrix")
  })
  
  model <- reactive({
    params <- c("cyl", "hp", "wt")[c(input$use_cyl, input$use_hp, input$use_wt)]
    f <- as.formula(paste("mpg~", paste(params, collapse = "+")))    
    lm(f, data = mtcars)
  })
  
  output$prediction <- renderPrint({
    nd <- data.frame(cyl = c(input$p_cyl),
                     hp = c(input$p_hp),
                     wt = c(input$p_wt))
    cat(predict(model(), newdata = nd))
  })

  output$model_summary <- renderPrint({
    summary(model())
  })
  
})