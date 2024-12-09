############################################################################
############################################################################
##  Document Path: includes/body/ui.R
##
##  Description: User interface for main body section
##
##  R version 4.4.1 (2024-06-14 ucrt)
##
#############################################################################
#############################################################################


body.model.info <- card.pro(
  title = "Model Information", width = 12,
  header.bg = "blue",
  removebtn = FALSE,
  colorbtn = FALSE,
  expandbtn = FALSE,
  editbtn = FALSE,
  collapsed = TRUE,
  shadow = FALSE,
  includeMarkdown(file.path(this.path, "model_information.md"))
)
