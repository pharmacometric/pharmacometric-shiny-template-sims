# load libraries
quickcode::libraryAll(
  ggplot2,
  dplyr,
  mrgsolve,
  patchwork,
  flextable,
  nlme
)


setpath <- function(){

}


source.part = function(path, which = c("ui","server"), input = NULL, output = NULL,session = NULL){
  this.path = path
  which = match.arg(which)
  for(h in list.files(path = path, pattern = paste0(which,".R$"), recursive = FALSE))
  source(file.path(path,h), local = TRUE)
}



updateSimStatus <- function(message = "Running simulations..."){
  shinyjs::runjs(paste0("$('#tracksimulations').html('",message,"')"))
}


updateGraphStatus <- function(message = "Generating graphs..."){
  shinyjs::runjs(paste0("$('#reportgraphstatus').html('",message,"')"))
}


disableSims <- function(is = "true"){
  shinyjs::runjs(paste0('$("#runsimbutton").prop("disabled",',is,')'))
}


potheme <- list(theme(
  axis.title.y = element_text(face = "bold"),
  panel.background = element_rect(colour = "#333333"),
  strip.text = element_text(face = "bold")
))

po.nopanel0 <- list(theme(
  axis.title.x = element_text(size = 16),
  axis.title.y = element_text(size = 16, face = "bold", angle = 90),
  axis.text.x = element_text(size = 16),
  axis.text.y = element_text(size = 16),
  legend.text = element_text(size = 16),
  legend.title = element_text(size = 16),
  panel.background = element_rect(colour = "#000000"),
  strip.text.x = element_text(size = 16, face = "bold")
))

po.nopanel1 <- list(
  theme(
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14, face = "bold", angle = 90),
    axis.text.x = element_text(size = 14),
    axis.text.y = element_text(size = 14),
    legend.text = element_text(size = 14),
    legend.title = element_text(size = 14),
    # panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    strip.text.x = element_text(size = 14, face = "bold")
  )
)

po.nopanel3 <- list(theme(
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  panel.background = element_blank(),
  legend.position = "bottom",
  axis.title.x = element_text(size = 13, face = "bold"),
  axis.title.y = element_text(size = 13, face = "bold", angle = 90),
  axis.text.x = element_text(size = 12),
  axis.text.y = element_text(size = 12),
  legend.text = element_text(size = 10),
  legend.title = element_text(size = 10),
  strip.text.x = element_text(size = 12, face = "bold"),
  plot.title = element_text(size = 14, face = "bold")
))
po.nopanel <- list(theme(
  legend.position = "bottom",
  axis.title.x = element_text(size = 12, face = "bold"),
  axis.title.y = element_text(size = 12, face = "bold", angle = 90),
  axis.text.x = element_text(size = 12),
  axis.text.y = element_text(size = 12),
  legend.text = element_text(size = 10),
  legend.title = element_text(size = 10),
  strip.text.x = element_text(size = 12, face = "bold"),
  plot.title = element_text(size = 10, face = "bold")
))




pop_off <- function(.){
  .[1:{length(.)-1}]
}
