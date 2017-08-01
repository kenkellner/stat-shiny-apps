library(shiny)

ui = fluidPage(
  withMathJax(),
  titlePanel("Central Limit Theorem"),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:",
                  list("Iris Petal Width",
                       "River Lengths",
                       "Cherry Tree Volume")
      ),
      sliderInput("nsamples","Number of Population Samples",30,min=1,max=100,step=1),
      sliderInput("samples", "Size of Each Population Sample:", 10, min = 1, max = 30,step=1),
      br(),
      "Population Parameters",
      uiOutput("popmean"),
      uiOutput("popsd"),
      uiOutput('mnsd'),
      br(),
      "Sampling Distribution Parameters",
      uiOutput("sampdistmean"),
      uiOutput("sampdistsd")


    ),
    mainPanel(
      plotOutput("hist1"),
      plotOutput("hist2")

    )
  )
)
