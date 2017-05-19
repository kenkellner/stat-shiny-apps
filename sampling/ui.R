library(shiny)

fluidPage(
  titlePanel("Sampling Simulator"),
  sidebarLayout(
    sidebarPanel(
      h4("Population Mean:"),
      div(style = "color: black; font-size: 30px", strong(textOutput("pop.mean"))),
      br(),
      # sliderInput("wt.mean", label = h3("Population Mean"),
      #             min = 70, max = 150, value = 100),
      # sliderInput("wt.sd", label = h3("Population SD"),
      #             min = 0, max = 30, value = 20),
      sliderInput("sample.size", label = h4("Sample Size"),
                  min = 0, max = 100, value = 10),
      br(),

      h4("Sample Mean:"),
      div(style = "color: red; font-size: 30px", strong(textOutput("samp.mean")))#,
      # br(),
      # "Sample SD:",
      # div(style = "color: red", strong(textOutput("samp.sd")))
    ),
    mainPanel(
      h4("Sampled Individuals"),
      plotOutput("plot1"),
      h4("Sample Size vs. Sample Mean"),
      plotOutput("plot2")
    )
  )
)
