# Shiny App (app.R)

library(shiny)
library(eRm)
library(ggplot2)
library(bslib)

ui <- fluidPage(
  theme = bs_theme(bootswatch = "flatly"),
  
  titlePanel("Rasch Model Explorer (eRm)"),
  
  sidebarLayout(
    sidebarPanel(
      
      fileInput("file", "Upload Binary CSV Dataset"),
      
      helpText("Dataset must contain only 0/1 responses."),
      
      hr(),
      
      uiOutput("item_selector")
      
    ),
    
    mainPanel(
      
      tabsetPanel(
        
        tabPanel("Item Characteristic Curve",
                 plotOutput("icc_plot", height = "500px")),
        
        tabPanel("Person-Item Map",
                 plotOutput("wright_map")),
        
        tabPanel("Fit Statistics", tableOutput("fit_table")),
        
        tabPanel("Item Difficulties",
                 tableOutput("item_table"))
        
      )
      
    )
  )
)

server <- function(input, output) {
  
  # Load uploaded data
  raw_data <- reactive({
    
    req(input$file)
    
    read.csv(input$file$datapath)
    
  })
  
  
  # Fit Rasch model
  rasch_model <- reactive({
    
    req(raw_data())
    
    RM(raw_data())
    
  })
  
  
  # Recover full item difficulty vector
  item_difficulty <- reactive({
    
    req(rasch_model())
    
    betas_est <- rasch_model()$etapar
    
    # recover first item using sum-to-zero constraint
    beta1 <- -sum(betas_est)
    
    all_betas <- c(beta1, betas_est)
    
    names(all_betas) <- colnames(raw_data())
    
    return(all_betas)
    
  })
  
  
  # Dynamic item selector
  output$item_selector <- renderUI({
    
    req(raw_data())
    
    selectInput(
      "selected_item",
      "Select Item",
      choices = colnames(raw_data())
    )
    
  })
  
  
  # ICC plot
  output$icc_plot <- renderPlot({
    
    req(item_difficulty(), input$selected_item)
    
    beta <- item_difficulty()[input$selected_item]
    
    theta <- seq(-4,4,length.out = 200)
    
    prob <- 1/(1+exp(-(theta-beta)))
    
    df <- data.frame(theta,prob)
    
    ggplot(df,aes(theta,prob))+
      
      geom_line(color="steelblue",size=1.3)+
      
      geom_vline(xintercept = beta,
                 linetype="dashed",
                 color="red")+
      
      labs(
        title=paste("ICC for",input$selected_item),
        subtitle=paste("Item difficulty (beta) =",round(beta,3)),
        x="Latent ability (theta)",
        y="Probability of correct response"
      )+
      
      theme_minimal(base_size = 14)
    
  })
  
  
  # Fit Statistics (Infit/Outfit)
  output$fit_table <- renderTable({
    req(rasch_model())
    # itemfit requires person parameters
    p_params <- person.parameter(rasch_model())
    fit <- itemfit(p_params)
    
    # Extract Infit/Outfit MSQ
    fit_df <- data.frame(
      Item = names(item_difficulty()),
      Outfit_MSQ = fit$i.outfitMSQ, # eRm naming can be tricky
      Infit_MSQ = fit$i.infitMSQ
    )
    fit_df
  }, digits = 3)
  
  
  # Wright Map
  output$wright_map <- renderPlot({
    
    req(rasch_model())
    
    plotPImap(rasch_model(),
              main="Person-Item Map (Wright Map)")
    
  })
  
  
  # Item parameter table
  output$item_table <- renderTable({
    
    req(item_difficulty())
    
    data.frame(
      Item = names(item_difficulty()),
      Difficulty = as.numeric(item_difficulty())
    )
    
  }, digits = 3)
  
}

shinyApp(ui, server)
