library(shiny)

fluidPage(
  titlePanel("Confidence Intervals"),
  sidebarLayout(
    sidebarPanel(
      div(style = "color: black; font-size: 25px", strong("Settings")),
      radioButtons('CIlevel','Confidence Level',
                   choiceValues=c(1.645,1.96,2.576),
                   choiceNames=c('90%','95%','99%'),inline=T,
                   selected=1.96),
      sliderInput("samplesize", "Sample Size:",
                  min = 1, max = 50, value = 10),
      sliderInput("nsamples", 'Number of Samples to Add:',
                  min = 1, max = 10, value = 1),
      actionButton("add", "Add Samples"),
      actionButton("reset", "Reset"),
      br(),
      br(),
      div(style = "color: black; font-size: 25px", strong("Output")),
      div(style = "color: black; ", strong(textOutput("count"))),
      div(style = "color: red; ", strong(textOutput("overlap"))),
      div(style = "color: black; ", strong(textOutput("pct"))),
      div(style = "color: black; ", strong("Equation:")),
      uiOutput("eq"),
      uiOutput("eqnum")
      
    ),
    mainPanel(
     plotOutput("distplot",height=250),
     plotOutput("CIplot",height=600)
    )
  )
)