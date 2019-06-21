dataOptionsModeSelectionUi <- selectInput(
  "data_mode",
  "Mode",
  choices = c("Upload", "Select"),
  selected = "Select",
  width = "100%"
)

dataOptionsUploadUi <- fileInput(
  "input_file",
  "File",
  multiple = FALSE,
  accept = c("text/csv","text/comma-separated-values,text/plain", ".csv"),
  width = "100%"
)

dataOptionsUploadOptionsUi <- fixedRow(
  column(4, selectInput(
    "separator_type",
    "Separator Type", 
    choices = c("Comma" = ",", "Semicolon" = ";", "Tab" = "\t"),
    selected = ","
  )),
  column(4, selectInput(
    "quote_type",
    "Quote Type",
    choices = c("None" = "", "Single Quote" = "'", "Double Quote" = '"'),
    selected = '"'
  )),
  column(4, checkboxInput(
    "header",
    "Header",
    TRUE
  ))
)

dataOptionsSelectUi <- selectInput(
  "dataset",
  "Dataset",
  choices = c("Rock" = "rock", 
              "Pressure" = "pressure", 
              "Cars"= "cars", 
              "Iris"= "iris"),
  selected = "iris",
  width = "100%"
)

dataOptionsModeUi <- verticalLayout(
  conditionalPanel(
    condition = "input.data_mode == 'Upload'",
    verticalLayout(
      fixedRow(
        column(4, dataOptionsUploadUi),
        column(8, dataOptionsUploadOptionsUi)
      )
    )
  ),
  conditionalPanel(
    condition = "input.data_mode == 'Select'",
    verticalLayout(
      fixedRow(
        column(4, dataOptionsSelectUi),
        column(8, uiOutput("dataOptionsSelectColumnUi"))
      )
    )
  )
)

dataOptionsUi <- verticalLayout(
  fixedRow(
    column(12, dataOptionsModeSelectionUi)
  ),
  fixedRow(
    column(12, dataOptionsModeUi)
  )
)

dataOptionsPreprocessUi <- verticalLayout(
  fixedRow(
    column(2, checkboxInput("scale", label = "Scale", value = FALSE, width = "100%")),
    column(2, checkboxInput("centralize", label = "Centralize", value = FALSE, width = "100%")),
    column(4, selectInput("normalize", "Normalize",
                choices = c("None" = "",
                            "n1 - Standardization" = "n1", 
                            "n2 - Positional Standardization" = "n2", 
                            "n3 - Unitization" = 'n3', 
                            "n3a - Positional Unitization" = "n3a",
                            "n4 - Unitization with Zero Minimum" = "n4",
                            "n5- Normalization in Range <-1,1>" = "n5",
                            "n5a - Positional Normalization in Range <-1,1>" = "n5a",
                            "n6 - Quotient Transformation" = "n6",
                            "n7 - Quotient Transformation" = "n7",
                            "n8 - Quotient Transformation" = "n8",
                            "n9 - Quotient Transformation" = "n9",
                            "n9a - Positional Quotient Transformation" = "n9a",
                            "n10 - Quotient Transformation" = "n10",
                            "n11 - Quotient Transformation" = "n11",
                            "n12 - Normalization" = "n12",
                            "n12a - Positional Normalization" = "n12a",
                            "n13 - Normalization with Zero Being the Central Point" = "n13"
                            ),
                selected = "",
                width = "100%")),
    column(2, selectInput("fill_missing", "Fill Missing",
                choices = c("None" = "",
                            "Mean" = "mean",
                            "Median" = "median"
                            ),
                selected = "",
                width = "100%")),
    column(2, checkboxInput("reduce_dimension", label = "Reduce Dimension", value = FALSE, width = "100%"))
  )
)

dataOptionsDisplayOptionsUi <- selectInput(
  "display_option",
  "Display Option",
  choices = c("All" = "all", "Head" = "head", "Tail" = 'tail', "Summary" = "summary"),
  selected = "head",
  width = "100%"
)

dataUi <- verticalLayout(
  titlePanel("Data"),
  fixedRow(
    column(12, h3("Options"), dataOptionsUi)
  ),
  hr(class="half-rule"),
  fixedRow(
    column(12, h3("Preprocess"), dataOptionsPreprocessUi)
  ),
  hr(class="half-rule"),
  fixedRow(
    column(12, h3("Display"), dataOptionsDisplayOptionsUi, tableOutput("dataDisplay"))
  )
)
