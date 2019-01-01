require('clusterCrit')

validationUi <- fluidPage(
  verticalLayout(
    titlePanel("Validation"),
    fluidRow(
      column(12, 
        selectInput(
          "criteria",
          "Criteria",
          choices = getCriteriaNames(TRUE),
          selected = c("Davies_Bouldin", "Dunn", "Calinski_Harabasz"),
          multiple = TRUE,
          width = "100%"
        )
      )
    ),
    fluidRow(
      column(12, h3("Plots"), uiOutput("validationPlot"))
    )
  )
)
