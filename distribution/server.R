library(shiny)

function(input,output){

  require(fGarch)

  boxhist <- list(rn=NULL)

  observeEvent(input$reset_button, {
    boxhist <<- list(rn=NULL)
  })

  runsim <- reactive(
    rsnorm(input$smp, mean = 0, sd = 1, xi = input$skw)
  )





  output$plot1 <- renderPlot({

    rn <- runsim()

    hist(rn,freq=FALSE,col='lightgray',main="",xlab="",ylim=c(0,0.5))
    curve(dsnorm(x, mean = 0, sd = 1, xi = input$skw, log = FALSE),xlim=c(-4,4),add=T,lwd=2)

    abline(v=mean(rn),col='red',lwd=2)
    abline(v=median(rn),col='blue',lwd=2)

    if(input$skw>=1){
      legpos <- 'topright'
    } else{legpos <- 'topleft'}

    legend(legpos,legend=c('Mean','Median'),col=c('red','blue'),lwd=2)

  })

  output$plot2 <- renderPlot({

    rn <- runsim()

    if(is.null(boxhist$rn)){
      boxhist$rn <<- list(rn)
    } else {boxhist$rn[[length(boxhist$rn)+1]] <<- rn}

    boxplot(boxhist$rn)
    abline(h=0,col='red')

    legend('topleft',legend='Mean',col='red',lwd=1)


  })






}
