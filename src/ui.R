source('src/ui/data.R')
source('src/ui/clustering.R')
source('src/ui/validation.R')

ui <- verticalLayout(
  tags$head(
    tags$link(rel = "shortcut icon", type = "image/png", href = "OptimalClustersLogo.png"),
    tags$style(
      "h2 { margin-bottom: 20px; }
      .half-rule { width: 200px; height: 1px; margin: 20px auto; background-color: #eee; border: 0; }
      .footer { margin: 40px 0px; }"
    )
  ),
  navbarPage(
    "OptimalClusters",
    tabPanel("Data", dataUi),
    tabPanel("Clustering", clusteringUi),
    tabPanel("Validation", validationUi),
    fluid = FALSE,
    position = "static-top",
    windowTitle = "OptimalClusters - a web app to determine optimal number of clusters"
  ),
  fixedPage(
    hr(),
    div(p("OptimalClusters is a web app to determine optimal number of clusters."),
      class = "footer text-muted text-center")
  )
)
