source('src/server/data.R')
source('src/server/clustering.R')
source('src/server/validation.R')

server <- function(input, output) {

  data <- as.data.frame(rbind(
      matrix(rnorm(500, mean = 0, sd = 0.05), ncol = 5),
      matrix(rnorm(500, mean = 1, sd = 0.05), ncol = 5),
      matrix(rnorm(500, mean = 2, sd = 0.05), ncol = 5),
      matrix(rnorm(500, mean = 3, sd = 0.05), ncol = 5),
      matrix(rnorm(500, mean = 4, sd = 0.05), ncol = 5),
      matrix(rnorm(500, mean = 5, sd = 0.05), ncol = 5)
  ))
  values <- reactiveValues()

  # output$clusteringPlot <- renderPlot({
  #     do.call(grid.arrange, run_clustering(data, input$method, input$range))
  #   })

  output$clusteringPlot <- renderPlot({
    if (input$method == 'kmeans') {
      clusterings <- cls_kmeans(data, input$range)
    } else if (input$method == 'hclust') {
      clusterings <- cls_hclust(data, input$range)
    }
    values$clusterings <- clusterings
    plots <- plt_any(data, clusterings)

    do.call(grid.arrange, plots)
  })

  output$validationPlot <- renderPlot({
    plots <- run_validation(data, values$clusterings, input$criteria)

    do.call(grid.arrange, plots)
  })

}
