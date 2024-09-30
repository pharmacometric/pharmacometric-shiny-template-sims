for (ui_each in c(
  "includes/header",
  "includes/body",
  "includes/footer"
)) {
  this.path = ui_each
  source(file.path(ui_each,"ui.R"), local = T)
}


ui <- fluidPage(
  useShinyjs(),
  use.cardpro(theme = "a"),
  header.main,
  body.main
)
