library(shiny)

fluidPage(
  titlePanel("Confidence Intervals"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("samplesize", "Sample Size:",
                  min = 1, max = 50, value = 10),
      numericInput('nsamples', 'Number of Samples to Add:', 1,min = 1, max = 10),
      actionButton("add", "Add Samples"),
      actionButton("reset", "Reset"),
      br(),
      br(),
      div(style = "color: black; font-size: 25px", strong(textOutput("count"))),
      div(style = "color: red; font-size: 25px", strong(textOutput("overlap"))),
      div(style = "color: black; font-size: 25px", strong(textOutput("pct")))
      
    ),
    mainPanel(
     plotOutput("distplot",height=250),
     plotOutput("CIplot",height=600)
    )
  )
)