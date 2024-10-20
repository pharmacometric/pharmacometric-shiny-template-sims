#########################################################################################
#########################################################################################
##
##  Document Path: global.R
##
##  R version: 4.2.0 (2022-04-22)
##
##  Program purpose: Global library loads and variables
##
#########################################################################################
#########################################################################################


# load libraries and print their versions
quickcode::libraryAll(clearPkgs = TRUE,
  shiny,
  shinyjs,
  rhandsontable,
  DT,
  flextable,
  nlme,
  markdown,
  card.pro,
  dplyr,
  ggplot2,
  magrittr,
  mrgsolve,
  patchwork
)

# clear console, set dir, load libs and load files
quickcode::clean(source = c(
  "utils.R"
))

# add all individual utils
for (ui_each in c(
  "includes/header",
  "includes/body",
  "includes/footer"
)) {
  this.path = ui_each
  source(file.path(ui_each,"libs.R"), local = T)
}



GLOBAL<- reactiveValues()
GLOBAL$lastsim <- NULL
GLOBAL$start.sim <- FALSE
seed.val <- 67772
