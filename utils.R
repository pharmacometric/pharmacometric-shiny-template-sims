# load libraries
quickcode::libraryAll(
  ggplot2,
  dplyr,
  mrgsolve,
  dmutate,
  BE,
  patchwork,
  flextable,
  nlme,
  sasLM
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





theme1 <- theme(
  panel.border = element_rect(linetype = 1, fill = NA),
  plot.margin = margin(0.5, 1, 0.5, 1, "cm"),
  plot.title = element_text(size = 20, face = "bold", hjust = 0.5, vjust = 3),
  strip.text = element_text(size = 13),
  axis.ticks = element_line(size = 0.8, color = "#000000"),
  axis.ticks.length = unit(0.2, "cm"),
  axis.text = element_text(size = 14),
  axis.title = element_text(size = 14),
  axis.title.y = element_text(margin = margin(t = 0, r = 1, b = 0, l = 0)),
  axis.title.x = element_text(margin = margin(t = 5, r = 0, b = 0, l = 0)),
  legend.text = element_text(size = 13),
  legend.title = element_text(size = 14)
)

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

