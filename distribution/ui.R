library(shiny)

fluidPage(
  titlePanel("Distribution Simulator"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("smp", label = h4("Sample Size"),
                  min = 0, max = 1000, value = 500),
      br(),
      sliderInput("skw", label = h4("Skew"),
                  min = 0.01, max = 10, value = 1),
      br(),
      actionButton("reset_button", "Reset Boxplots")
    ),
    mainPanel(
      h4("Distribution"),
      plotOutput("plot1"),
      h4("Boxplot"),
      plotOutput("plot2")
    )
  )
)
