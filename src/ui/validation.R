require('clusterCrit')

validationUi <- fixedPage(
  verticalLayout(
    titlePanel("Validation"),
    fixedRow(
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
    fixedRow(
      column(12, h3("Plots"), uiOutput("validationPlot"))
    )
  )
)
