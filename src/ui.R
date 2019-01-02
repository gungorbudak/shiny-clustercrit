source('src/ui/data.R')
source('src/ui/clustering.R')
source('src/ui/validation.R')

ui <- verticalLayout(
  tags$head(
    tags$style(
      "h2 { margin-bottom: 20px; }
      .footer { margin-bottom: 20px; }"
    )
  ),
  navbarPage(
    "OptimalClusters",
    tabPanel("Data", dataUi),
    tabPanel("Clustering", clusteringUi),
    tabPanel("Validation", validationUi),
    position = "static-top",
    windowTitle = "OptimalClusters"
  ),
  fluidPage(
    hr(),
    div(p("OptimalClusters is a web app to determine optimal number of clusters."),
      class = "footer text-muted text-center")
  )
)
