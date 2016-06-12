library(ggvis)

# For dropdown menu
actionLink <- function(inputId, ...) {
  tags$a(href='javascript:void',
         id=inputId,
         class='action-button',
         ...)
}

shinyUI(fluidPage(
  titlePanel("Overview of Flexitime usage"),
  fluidRow(
    column(3,
      wellPanel(
        h4("Filter"),
        sliderInput("flexi.leave.2015", "Flexileave 2015", 0, 14, 0, step = 1),
        sliderInput("certified.sickleave.2015", "Certified sickleave 2015", 0, 230, 0, step = 1),
        sliderInput("uncertified.sickleave.2015", "Uncertified sickleave 2015", 0, 13, 0, step = 1),
        sliderInput("days.not.recorded.2015", "Days not recorded 2015", 0, 110, 0, step = 10),
        sliderInput("excess.2015", "Excess 2015", -100, 1500, 0, step = 50),
        
        selectInput("name.of.EE.subgroup", "Contract",
          c("All", "Temporary Agent", "Contract Agent", "National Expert", "Interim")),
        
        selectInput("pay.Scale.Group", "Grade",
                    c("All", "AD05","AD06","AD07","AD08","AD09","AD10","AD11","AD12","AD13",
                      "AD14","AD15","AST01","AST02","AST03","AST04","AST05","AST06","AST07",
                      "AST08","AST09","AST10","FGII.04","FGII.05","FGII.06","FGIII.08","FGIII.09","FGIII.10",
                      "FGIV.13","FGIV.14","FGIV.16","FGIV.18","SNE")),
        
        textInput("personnel.Number..P.", "SAP Personnelnumber"),
        textInput("last.Name", "Initial of Last Name")
      ),
      wellPanel(
        selectInput("xvar", "X-axis variable", axis_vars, selected = "Flexileave 2015"),
        selectInput("yvar", "Y-axis variable", axis_vars, selected = "Uncertified sickleave 2015"),
      tags$small(paste0(
        "Note: AD and AST are Temporary agent grades.",
        " FG are Contract agent grades.",
        " SNE is the only National expert grade.",
        " Interims should not have an FG grade."
      ))
    )
  ),
    column(9,
      ggvisOutput("plot1"),
      wellPanel(
        span("Number of staff members selected:",
          textOutput("n_flexitimes")
        )
      )
    )
  )
))