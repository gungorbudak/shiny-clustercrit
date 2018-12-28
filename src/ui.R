source('src/ui/data.R')
source('src/ui/clustering.R')
source('src/ui/validation.R')

ui <- fluidPage(
  tags$head(
    tags$style(
      "h1 { text-align: center; }"
    )
  ),
  verticalLayout(
    headerPanel("Shiny clusterCrit", windowTitle="Shiny clusterCrit"),
    tabsetPanel(type = "tabs",
      tabPanel("Data", dataUi),
      tabPanel("Clustering", clusteringUi),
      tabPanel("Validation", validationUi)
    ),
    hr()
  )
)
