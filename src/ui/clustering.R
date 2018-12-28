clusteringUi <- fluidPage(
  verticalLayout(
    titlePanel("Clustering"),
    fluidRow(
      column(6, selectInput(
                           "method",
                           "Choose a method:",
                            choices = c("kmeans", "hclust")
                            )
      ),
      column(6, sliderInput(
                            "range",
                            "Number of clusters:",
                            min = 2,
                            max = 100,
                            value = c(2, 7)
                            )
      )
    ),
    fluidRow(
      column(12, plotOutput("clusteringPlot"))
    )
  )
)
