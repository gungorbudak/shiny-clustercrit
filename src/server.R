source('src/server/data.R')
source('src/server/clustering.R')
source('src/server/validation.R')

server <- function(input, output) {
  # A reactive variable to store some data
  values <- reactiveValues()

  # Data operations
  data <- as.data.frame(rbind(
      matrix(rnorm(500, mean = 0, sd = 0.05), ncol = 5),
      matrix(rnorm(500, mean = 1, sd = 0.05), ncol = 5),
      matrix(rnorm(500, mean = 2, sd = 0.05), ncol = 5),
      matrix(rnorm(500, mean = 3, sd = 0.05), ncol = 5),
      matrix(rnorm(500, mean = 4, sd = 0.05), ncol = 5),
      matrix(rnorm(500, mean = 5, sd = 0.05), ncol = 5)
  ))

  # Clustering operations

  ## Options to determine plot height
  clusteringPlotCount <- reactive({
    req(input$range)
    range <- input$range
    range[2] - range[1] + 1
  })
  clusteringPlotHeight <- reactive({
    300 * ceiling(clusteringPlotCount() / 3)
  })

  ## Render plots
  output$clusteringPlotRender <- renderPlot({
    if (input$method == 'kmeans') {
      params = list(
        iter.max = input$iter.max,
        nstart = input$nstart,
        algorithm = input$algorithm
        )
      values$clusterings <- cls_kmeans(data, input$range, params)
    } else if (input$method == 'pam') {
      params = list(
        metric = input$metric,
        stand = input$stand,
        do.swap = input$do.swap,
        pamonce = input$pamonce
        )
      values$clusterings <- cls_pam(data, input$range, params)
    } else if (input$method == 'hcut') {
      params = list(
        hc_func = input$hc_func,
        hc_method = input$hc_method,
        hc_metric = input$hc_metric,
        stand = input$stand
        )
      values$clusterings <- cls_hcut(data, input$range, params)
    }
    plots <- plt_any(data, values$clusterings, input$method)
    do.call(grid.arrange, plots)
  })

  ## Output the rendered plots
  output$clusteringPlot <- renderUI({
    plotOutput("clusteringPlotRender", height = clusteringPlotHeight())
  })

  # Validation operations

  ## Options to determine plot height
  validationPlotCount <- reactive({
    req(input$criteria)
    length(input$criteria)
  })
  validationPlotHeight <- reactive({
    300 * ceiling(validationPlotCount() / 3)
  })

  ## Render plots
  output$validationPlotRender <- renderPlot({
    plots <- run_validation(data, values$clusterings, input$criteria, input$method)
    do.call(grid.arrange, plots)
  })

  ## Output the rendered plots
  output$validationPlot <- renderUI({
    plotOutput("validationPlotRender", height = validationPlotHeight())
  })

}
