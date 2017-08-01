library(shiny)

server = function(input, output) {

  x <- reactive({
    if(input$dataset=='Iris Petal Width'){
      return(iris$Petal.Width)
    }
    if(input$dataset=='River Lengths'){
      return(rivers)
    }
    if(input$dataset=='Cherry Tree Volume'){
      return(trees$Volume)
    }
  })

  y <- reactive({
    s <- colMeans(replicate(input$nsamples,sample(x(),input$samples,replace=FALSE)))
    mn <- mean(s)
    sd <- sd(s)
    return(list(s=s,mn=mn,sd=sd))
  })

  output$hist1 <- renderPlot({
    hist(x(),main="Original Dataset",xlab=input$dataset,col='lightblue',probability=T)
  })

  output$hist2 <- renderPlot({
    hist(y()$s,main="Distribution of Sample Means",xlab=paste('Mean of',input$dataset),col='red',probability=T)
    curve(dnorm(x,mean=y()$mn,sd=y()$sd),add=T,lwd=2)
  })

  output$popmean <- renderUI({
    m <- mean(x())
    withMathJax(sprintf("$$\\mu = %.03f$$", m))
  })
  output$popsd <- renderUI({
    ps <- sd(x())
    withMathJax(sprintf("$$\\sigma = %.03f$$", ps))
  })
  output$mnsd <- renderUI({
    ms <- sd(x())/sqrt(input$samples)
    withMathJax(sprintf("$$\\frac{\\sigma}{\\sqrt{n}} = %.03f$$", ms))
  })

  output$sampdistmean <- renderUI({
    smn <- y()$mn
    withMathJax(sprintf("$$mean(\\bar{x}) = %.03f$$", smn))
  })
  output$sampdistsd <- renderUI({
    ssd <- y()$sd
    withMathJax(sprintf("$$sd(\\bar{x}) = %.03f$$", ssd))
  })

}
