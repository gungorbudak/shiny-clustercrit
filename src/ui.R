source('src/ui/data.R')
source('src/ui/clustering.R')
source('src/ui/validation.R')

ui <- fluidPage(
  tags$head(
    tags$style(
      "h1 { text-align: center; margin-bottom: 20px; }
      h2 { margin-bottom: 20px; }
      .footer { margin-bottom: 20px; }"
    )
  ),
  verticalLayout(
    headerPanel("Shiny clusterCrit", windowTitle="Shiny clusterCrit"),
    tabsetPanel(type = "tabs",
      tabPanel("Data", dataUi),
      tabPanel("Clustering", clusteringUi),
      tabPanel("Validation", validationUi)
    ),
    hr(),
    div(p("Shiny clusterCrit is a web app to determine optimal number of clusters."),
        class = "footer text-muted text-center")
  )
)
