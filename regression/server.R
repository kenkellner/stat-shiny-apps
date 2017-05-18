library(shiny)

function(input, output) {

  xy = reactiveValues(
    x = NULL,
    y = NULL
  )

  observeEvent(input$plot_click, {
    if(input$plot_click$x >= 0 & input$plot_click$x <= 10 &
       input$plot_click$y >= 0 & input$plot_click$y <= 10){
      xy$x = c(xy$x, input$plot_click$x)
      xy$y = c(xy$y, input$plot_click$y)
    }
  })

  observeEvent(input$reset_button, {
    xy$x = NULL
    xy$y = NULL
  })


  output$plot1 <- renderPlot({
    if(length(xy$x) < 1){
      df_points = data.frame(x = -1, y = -1)
    }
    else{
      m = lm(xy$y ~ xy$x)
      b0 = coef(m)[1]
      b1 = coef(m)[2]
      x_lin = seq(0, 10, 0.01)
      y_lin = b0 + x_lin * b1
      df_points = data.frame(x = xy$x, y = xy$y)
    }

    plot(df_points,xlim=c(0,10),ylim=c(0,10),xlab="Variable 1",ylab="Variable 2",cex=1.5,pch=19)

    if(length(xy$x) > 1){
      abline(m,col='red',lwd=2)

      if(resids){
        segments(xy$x,xy$y,xy$x,m$fitted.values,lty=2,col='gray',lwd=2)
      }
    }

  })

  output$line_text <- renderText({
    if(length(xy$x) < 2){
      "Please enter more points!"
    }
    else{
      m = lm(xy$y ~ xy$x)
      b0 = coef(m)[1]
      b1 = coef(m)[2]
      paste0("y = ", round(b0,2), " + ", round(b1,2), "x")
    }
  })

  output$corr_text <- renderText({
    if(length(xy$x) < 2){
      "Please enter more points!"
    }
    else{
      cor(xy$x, xy$y)
    }
  })

  output$my_data_table <- renderTable(data.frame(x = xy$x, y = xy$y))

}
