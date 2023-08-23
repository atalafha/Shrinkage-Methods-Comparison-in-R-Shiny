library(shiny)
library(glmnet)
library(ggplot2)
library(DT)
library(datasets)
library(shiny)
library(glmnet)
library(DT)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Shrinkage Methods: Ridge, LASSO & Elastic Net"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("data_choice", "Choose dataset:", choices = c("mtcars", "Upload CSV"), selected = "mtcars"),
      fileInput("file", "Upload CSV File", accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
      uiOutput("var_select"),
      sliderInput("alpha", "Alpha for Elastic Net (0=Lasso, 1=Ridge):", min = 0, max = 1, value = 0.5, step = 0.1),
      actionButton("run_analysis", "Run Analysis")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Data Overview", DTOutput("data_view")),
        tabPanel("Coefficient Paths", plotOutput("coef_plot")),
        tabPanel("Results", DTOutput("results_table"))
      )
    )
  )
)


server <- function(input, output, session) {
  
  # Data choice
  data_reactive <- reactive({
    if(input$data_choice == "mtcars") {
      return(mtcars)
    } else {
      return(read.csv(input$file$datapath))
    }
  })
  
  # Dynamically generate UI input for selecting response variable
  output$var_select <- renderUI({
    selectInput("response", "Select response variable:", choices = names(data_reactive()))
  })
  
  # Data overview
  output$data_view <- renderDT({
    data_reactive()
  })
  
  observeEvent(input$run_analysis, {
    df <- data_reactive()
    
    # Prepare data for modeling
    x <- as.matrix(df[, setdiff(names(df), input$response)])
    y <- df[[input$response]]
    
    # Fit models
    fit_ridge <- cv.glmnet(x, y, alpha = 1)
    fit_lasso <- cv.glmnet(x, y, alpha = 0)
    fit_enet  <- cv.glmnet(x, y, alpha = input$alpha)
    
    # Coefficient path plot
    output$coef_plot <- renderPlot({
      plot_glmnet <- function(fit, method) {
        plot(fit, xvar = "lambda", label = TRUE, main = paste(method, "Coefficient Paths"))
      }
      
      par(mfrow = c(1, 3))
      plot_glmnet(fit_ridge, "Ridge")
      plot_glmnet(fit_lasso, "LASSO")
      plot_glmnet(fit_enet,  paste("Elastic Net (alpha =", input$alpha, ")"))
    })
    
    # Display results
    results <- data.frame(
      Method = c("Ridge", "LASSO", "Elastic Net"),
      MSE = c(min(fit_ridge$cvm), min(fit_lasso$cvm), min(fit_enet$cvm)),
      Lambda = c(fit_ridge$lambda.min, fit_lasso$lambda.min, fit_enet$lambda.min)
    )
    
    output$results_table <- renderDT({ results })
  })
}

shinyApp(ui, server)
