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

  clusteringPlotCount <- reactive({
    req(input$range)
    range <- input$range
    range[2] - range[1] + 1
  })
  clusteringPlotHeight <- reactive({
    300 * (clusteringPlotCount() / 3)
  })
  output$clusteringPlotRender <- renderPlot({
    if (input$method == 'kmeans') {
      clusterings <- cls_kmeans(data, input$range)
    } else if (input$method == 'pam') {
      clusterings <- cls_pam(data, input$range)
    } else if (input$method == 'hclust') {
      clusterings <- cls_hclust(data, input$range)
    }
    values$clusterings <- clusterings
    plots <- plt_any(data, clusterings, input$method)
    do.call(grid.arrange, plots)
  })
  output$clusteringPlot <- renderUI({
    plotOutput("clusteringPlotRender", height = clusteringPlotHeight())
  })

  validationPlotCount <- reactive({
    req(input$criteria)
    length(input$criteria)
  })
  validationPlotHeight <- reactive({
    300 * (validationPlotCount() / 3)
  })
  output$validationPlotRender <- renderPlot({
    plots <- run_validation(data, values$clusterings, input$criteria, input$method)
    do.call(grid.arrange, plots)
  })
  output$validationPlot <- renderUI({
    plotOutput("validationPlotRender", height = validationPlotHeight())
  })

}
