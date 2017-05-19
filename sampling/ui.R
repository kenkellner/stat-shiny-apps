library(shiny)

fluidPage(
  titlePanel("Sampling Simulator"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("wt.mean", label = h3("Population Mean"),
                  min = 70, max = 150, value = 100),
      sliderInput("wt.sd", label = h3("Population Mean"),
                  min = 0, max = 30, value = 20),
      sliderInput("sample.size", label = h3("Sample Size"),
                  min = 1, max = 100, value = 10),
      br(),

      "Sample Mean:",
      br(),
      div(style = "color: red", strong(textOutput("samp.mean"))),
      br(),
      "Sample SD:",
      div(style = "color: red", strong(textOutput("samp.sd"))),
    ),
    mainPanel(
      plotOutput("plot1"),
    )
  )
)
