library(shiny)

#Adapted from https://github.com/TimothyKBook/RegressionPlot
fluidPage(
  titlePanel("Regression Simulator"),
  sidebarLayout(
    sidebarPanel(
      plotOutput("plot1", click = "plot_click"),
      br(),
      "The line of best fit is:",
      br(),
      div(style = "color: blue", strong(textOutput("line_text"))),
      br(),
      "and the correlation is:",
      div(style = "color: blue", strong(textOutput("corr_text"))),
      br(),
      #checkboxInput("resids", label = "Plot Residuals?", value = TRUE),
      actionButton("reset_button", "Reset Points")
    ),
    mainPanel(
      tableOutput("my_data_table")
    )
  )
)
