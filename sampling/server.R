library(shiny)

function(input,output){

  xy <- cbind(rep(1:10,10),rep(1:10,each=10))

  wts <- reactive(

    #return( rnorm(100,input$wt.mean,input$wt.sd))
    return( rnorm(100,100,20))

  )

  deer.sim <- function(sample.size){

    deer.weights <- wts()

    pop.mean <- mean(deer.weights)
    pop.sd <- sd(deer.weights)

    sample.ind <- sample(1:100,size=sample.size,replace=F)

    sample <- deer.weights[sample.ind]

    samp.mean <- mean(sample)
    samp.sd <- sd(sample)

    out <- list(samp.mean=samp.mean,samp.sd=samp.sd,samp.size=sample.size,sample.ind=sample.ind,
                pop.mean=pop.mean,pop.sd=pop.sd)
    return(out)
  }

  runsim <- reactive(
    deer.sim(input$sample.size)
  )

  hist <- reactiveValues(
    samp = NULL,
    mn = NULL
  )

  observeEvent(input$sample.size,{
    inp <- runsim()
    hist$samp <- c(hist$samp,input$sample.size)
    hist$mn <- c(hist$mn,inp$samp.mean)

  })

  output$plot1 <- renderPlot({
    inp <- runsim()

    par(mar=c(1,1,1,1))

    plot(xy,pch=19,xlab="",ylab="",xaxt='n',yaxt='n',cex=2)
    points(xy[inp$sample.ind,],cex=2,col='red',pch=19)


  },height=400,width=400)

  output$plot2 <- renderPlot({
    inp <- runsim()

    sorted <- list()
    sorted$samp <- hist$samp[order(hist$samp)]
    sorted$mn <- hist$mn[order(hist$samp)]

    par(mar=c(5,4,1,1))
    plot(sorted$samp,sorted$mn,col='red',pch=19,cex=2,
         xlab='Sample Size',ylab="Sample Mean")
    legend('bottomleft',lty=2,legend='Population Mean')
    abline(h=inp$pop.mean,lwd=2,lty=2)

  })


   output$pop.mean <- renderText({inp <- runsim(); round(inp$pop.mean,2)})
  # output$pop.sd <- renderText({round(runsim$pop.sd,2)})
  #
  output$samp.mean <- renderText({inp <- runsim(); round(inp$samp.mean,2)})
  output$samp.sd <- renderText({inp <- runsim(); round(inp$samp.sd,2)})




}
