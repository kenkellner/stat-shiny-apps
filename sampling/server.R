library(shiny)

function(input,output){

  xy <- cbind(rep(1:10,10),rep(1:10,each=10))

  deer.weights <- reactive(rnorm(100,input$wt.mean,input$wt.sd))

  deer.sim <- function(sample.size,deer.weights){

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
    deer.sim(input$sample.size,deer.weights)
  )

  output$plot1 <- renderPlot({

    par(mar=c(1,1,1,1))

    plot(xy,pch=19,xlab="",ylab="",xaxt='n',yaxt='n',cex=2)
    points(xy[runsim$sample.ind,],cex=2,col='red',pch=19)


  })

  output$pop.mean <- renderText({round(runsim$pop.mean,2)})
  output$pop.sd <- renderText({round(runsim$pop.sd,2)})

  output$samp.mean <- renderText({round(runsim$samp.mean,2)})
  output$samp.sd <- renderText({round(runsim$samp.sd,2)})




}
