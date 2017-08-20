library(shiny)



server = function(input, output) {
  
  samp.hist <- reactiveValues(
    x = list(),
    overlap = NULL
  )
  
  observeEvent(input$add, {
  
    for (i in 1:input$nsamples){
      n <- length(samp.hist$x)
      samp.hist$x[[n+1]] = rnorm(input$samplesize,mean=0,sd=1)
    }

  })
  
  observeEvent(input$reset, {
    
    samp.hist$x <- list()
    samp.hist$overlap <- NULL
    
  })
  
  output$distplot <- renderPlot({
    
    x <- seq(-3,3,by=0.01)
    y <- dnorm(x)
    plot(x,y,type='l',yaxt='n',ylab='',xlab='Parameter Value',lwd=2)
    abline(v=0,lty=2)
    
  })
  
  output$CIplot <- renderPlot({
    
    bound <- function(dat,type){
      mn <- mean(dat)
      se <- 1/sqrt(length(dat))
      if(type=='lower'){return(mn-1.96*se)}
      if(type=='upper'){return(mn+1.96*se)}
    }
    
    
    if(length(samp.hist$x)>0){
      
      struct <- -(1:length(samp.hist$x))
      
      mns <- sapply(samp.hist$x,mean)
      upper <- sapply(samp.hist$x,bound,'upper')
      lower <- sapply(samp.hist$x,bound,'lower')
      
      plot(mns,struct,xlim=c(-3,3),yaxt='n',ylab="",
           xlab="Parameter Value",cex=0.5)
      abline(v=0,lty=2)
      
      cols <- rep('black',length(samp.hist$x))
      cols[upper<0|lower>0] <- 'red'
      
      samp.hist$overlap <- cols=='red'
      
      segments(lower,struct,upper,struct,cols)
      points(mns,struct,col=cols,pch=19)
      
    } else{
      plot('n',type='n',xlim=c(-3,3),ylim=c(0,1),
           yaxt='n',ylab="",xlab="Parameter Value")
      abline(v=0,lty=2)
    }
  })
  
  output$count <- renderText(paste('Samples:',length(samp.hist$overlap)))
  output$overlap <- renderText(paste('Misses:',sum(samp.hist$overlap)))
  output$pct <- renderText(
    if(length(samp.hist$overlap)>0){
      paste('Overlap: ',round(100-mean(samp.hist$overlap)*100),'%',sep="")
    } else{
      paste('Overlap:')
    }
    
    )
  
}