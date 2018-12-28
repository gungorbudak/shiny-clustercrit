require(clusterCrit)

validationUi <- fluidPage(
  verticalLayout(
    titlePanel("Validation"),
    fluidRow(
      column(12, selectInput(
                             "criteria",
                             "Choose criteria:",
                             choices = getCriteriaNames(TRUE),
                             selected = c("Davies_Bouldin", "Dunn"),
                             multiple = TRUE
                             )
      )
    ),
    fluidRow(
      column(12, plotOutput("validationPlot"))
    )
  )
)
