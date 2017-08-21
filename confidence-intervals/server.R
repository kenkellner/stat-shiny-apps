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
  
  #List of all conditions that when change
  #should reset app
  resetConditions <- reactive({
    list(input$reset,input$CIlevel,input$samplesize)
  })
  observeEvent(resetConditions(),{
    samp.hist$x <- list()
    samp.hist$overlap <- NULL
    
  })
  
  output$distplot <- renderPlot({
    
    par(mar = c(2,4.5,2,2) + 0.1)
    
    x <- seq(-3,3,by=0.01)
    y <- dnorm(x)
    plot(x,y,type='l',yaxt='n',ylab='',xlab='',lwd=2,
         main="Population Distribution")
    abline(v=0,lty=2)
    text(0,0.3,expression(italic(μ)),cex=3)
    
  })
  
  output$CIplot <- renderPlot({
    
    par(mar = c(4,4.5,2,2) + 0.1)
    
    bound <- function(dat,type){
      mn <- mean(dat)
      se <- 1/sqrt(length(dat))
      if(type=='lower'){return(mn-as.numeric(input$CIlevel)*se)}
      if(type=='upper'){return(mn+as.numeric(input$CIlevel)*se)}
    }
    
    
    if(length(samp.hist$x)>0){
      
      struct <- -(1:length(samp.hist$x))
      
      mns <- sapply(samp.hist$x,mean)
      upper <- sapply(samp.hist$x,bound,'upper')
      lower <- sapply(samp.hist$x,bound,'lower')
      
      plot(mns,struct,xlim=c(-3,3),yaxt='n',ylab="",
           main='Statistic Value and CI',
           xlab="",cex=0.5)
      abline(v=0,lty=2)
      
      cols <- rep('black',length(samp.hist$x))
      cols[upper<0|lower>0] <- 'red'
      
      samp.hist$overlap <- cols=='red'
      
      segments(lower,struct,upper,struct,cols)
      points(mns,struct,col=cols,pch=19)
      
    } else{
      plot('n',type='n',xlim=c(-3,3),ylim=c(0,1),
           main='Statistic Value and CI',
           yaxt='n',ylab="",xlab="")
      abline(v=0,lty=2)
    }
  })
  
  output$count <- renderText(paste('Samples:',length(samp.hist$overlap)))
  output$overlap <- renderText(paste('Misses:',sum(samp.hist$overlap)))
  output$pct <- renderText(
    if(length(samp.hist$overlap)>0){
      paste('Overlap μ: ',round(100-mean(samp.hist$overlap)*100),'%',sep="")
    } else{
      paste('Overlap μ:')
    }
    
  )
  
  output$eqnum <- renderUI({
    withMathJax(
      sprintf("$$\\mu\\pm%.02f\\cdot\\frac{%.02f}{\\sqrt{%.0f}}$$", 
              as.numeric(input$CIlevel),1,input$samplesize))
  })
  
  output$eq <- renderUI({
    withMathJax(
      sprintf(" $$\\mu\\pm z\\cdot\\frac{\\sigma}{\\sqrt{n}}=$$"))
  })
  

  
}