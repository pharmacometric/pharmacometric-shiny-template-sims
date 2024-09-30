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

### function to calculate AUC above 0
calc.auc <- function(time, conc) {
  n <- length(time)
  0.5 * sum((conc[-1] + conc[-n]) * (time[-1] - time[-n]))
}
# Rounding up numbers:
r.0 <- function(number) {
  round(number, digit = 0)
}
r.1 <- function(number) {
  round(number, digit = 1)
}
r.2 <- function(number) {
  round(number, digit = 2)
}
r.2 <- function(number) {
  round(number, digit = 3)
}
r.100.1 <- function(number) {
  round(number * 100, digit = 1)
}
paste.m.ci <- function(median, lower, upper) {
  paste(median,
        " (", lower, ", ",
        upper, ")",
        sep = ""
  )
} # median(lower, upper)

paste.m.ci.r1 <- function(median, lower, upper) {
  paste(r.100.1(median),
        " (", r.100.1(lower), ", ",
        r.100.1(upper), ")",
        sep = ""
  )
} # round up to 1



prevGGplot <- function(plot1) {
  shiny::shinyApp(
    ui = shiny::fluidPage(
      shiny::titlePanel("Quick Preview Data"),
      shiny::mainPanel(
        plotly::plotlyOutput("hello1", height = 700, width = "auto")
      )
    ),
    server = function(input, output, session) {
      output$hello1 <- plotly::renderPlotly({
        plot1
      })
    }
  )
}



pathAddDate <- function(...) {
  combine <- paste0(...)
  ext <- tools::file_ext(combine)
  gsub(paste0("\\.", ext, "$"), paste0("_", Sys.Date(), paste0(".", ext)), combine)
}


#############################################################################
# plotting functions

plot.fun.adult.ado <- function(filepath, width = 6, height = 5.5, dpi = 150, cutoff = "70", xlab = "Time (Weeks)", ylab = "Guselkumab Concentration (µg/mL)") {
  a <- ggplot(data = subset(dat1, GRP == 7), aes(x = time / 7, y = q50)) +
    geom_line(size = 1, color = "black") +
    geom_ribbon(aes(ymin = q5, ymax = q95, fill = "black"), alpha = 0.2) +
    geom_line(data = subset(dat1, GRP == 1), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "#00BFC4") +
    geom_ribbon(data = subset(dat1, GRP == 1), aes(ymin = q5, ymax = q95, fill = "#00BFC4"), alpha = 0.2) +
    xlab(xlab) +
    ylab(ylab) +
    scale_x_continuous(limits = c(0, 52), breaks = seq(0, 52, 4)) +
    scale_y_continuous(limits = c(0, 20), breaks = c(0, 5, 10, 15, 20)) +
    scale_fill_manual("",
                      values = c("black" = "black", "#00BFC4" = "#00BFC4"),
                      breaks = c("black", "#00BFC4"),
                      labels = c("Adults", "Adolescents \u226512 to <18 yrs")
    ) +
    ggtitle(paste0("Adolescents <", cutoff, " kg, 1.3 mg; Adults, 100 mg")) +
    po.nopanel
  print(a)
  ggsave(paste(filepath, "/adults_sim_ado_below", cutoff, "kg.png", sep = ""), width = width, height = height, dpi = dpi)

  b <- ggplot(data = subset(dat1, GRP == 7), aes(x = time / 7, y = q50)) +
    geom_line(size = 1, color = "black") +
    geom_ribbon(aes(ymin = q5, ymax = q95, fill = "black"), alpha = 0.2) +
    geom_line(data = subset(dat1, GRP == 2), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "#00BFC4") +
    geom_ribbon(data = subset(dat1, GRP == 2), aes(ymin = q5, ymax = q95, fill = "#00BFC4"), alpha = 0.2) +
    xlab(xlab) +
    ylab(ylab) +
    scale_x_continuous(limits = c(0, 52), breaks = seq(0, 52, 4)) +
    scale_y_continuous(limits = c(0, 20), breaks = c(0, 5, 10, 15, 20)) +
    scale_fill_manual("",
                      values = c("black" = "black", "#00BFC4" = "#00BFC4"),
                      breaks = c("black", "#00BFC4"),
                      labels = c("Adults", "Adolescents \u226512 to <18 yrs")
    ) +
    ggtitle(paste0("Adolescents >", cutoff, " kg, 100 mg; Adults, 100 mg")) +
    po.nopanel

  print(b)
  ggsave(paste(filepath, "/adults_sim_ado_above", cutoff, "kg.png", sep = ""), width = width, height = height, dpi = dpi)


  c <- ggplot(data = subset(dat1, GRP == 7), aes(x = time / 7, y = q50)) +
    geom_line(size = 1, color = "black") +
    geom_ribbon(aes(ymin = q5, ymax = q95, fill = "black"), alpha = 0.2) +
    geom_line(data = subset(dat1, GRP == 3), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "#00BFC4") +
    geom_ribbon(data = subset(dat1, GRP == 3), aes(ymin = q5, ymax = q95, fill = "#00BFC4"), alpha = 0.2) +
    xlab(xlab) +
    ylab(ylab) +
    scale_x_continuous(limits = c(0, 52), breaks = seq(0, 52, 4)) +
    scale_y_continuous(limits = c(0, 20), breaks = c(0, 5, 10, 15, 20)) +
    scale_fill_manual("",
                      values = c("black" = "black", "#00BFC4" = "#00BFC4"),
                      breaks = c("black", "#00BFC4"),
                      labels = c("Adults", "Adolescents \u226512 to <18 yrs")
    ) +
    ggtitle(paste0("Adol, 1.3 mg/kg for <", cutoff, " kg 100 mg for >=", cutoff, "kg; Adults, 100 mg")) +
    theme(legend.position = c(0.63, 0.82)) +
    po.nopanel

  print(c)
  ggsave(paste(filepath, "/adults_sim_ado_all", cutoff, "kg.png", sep = ""), width = width, height = height, dpi = dpi)

  list(a, b, c)
}







plot.fun.adult.ado.ss <- function(filepath, width = 6, height = 5.5, dpi = 150, cutoff = "70", xlab = "Time (Weeks)", ylab = "Guselkumab Concentration (µg/mL)") {
  ggplot(data = subset(dat1, GRP == 7), aes(x = time / 7, y = q50)) +
    geom_line(size = 1, color = "black") +
    geom_ribbon(aes(ymin = q5, ymax = q95, fill = "black"), alpha = 0.2) +
    geom_line(data = subset(dat1, GRP == 1), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "#00BFC4") +
    geom_ribbon(data = subset(dat1, GRP == 1), aes(ymin = q5, ymax = q95, fill = "#00BFC4"), alpha = 0.2) +
    # geom_line(data=subset(dat1,GRP==4),aes(x=time/7,y=q50),linetype="solid",size=1,color="red")+
    # geom_ribbon(data=subset(dat1,GRP==4),aes(ymin=q5, ymax=q95,fill="red"),alpha=0.2)+
    xlab("Time (Weeks)") +
    ylab("Guselkumab Concentration (µg/mL)") +
    scale_x_continuous(limits = c(44, 52), breaks = c(44, 46, 48, 50, 52), labels = c(0, 2, 4, 6, 8)) +
    scale_y_continuous(limits = c(0, 15), breaks = c(0, 5, 10, 15)) +
    scale_fill_manual("",
                      values = c("black" = "black", "#00BFC4" = "#00BFC4"),
                      breaks = c("black", "#00BFC4"),
                      labels = c("Adults", "Adolescents \u226512 to <18 yrs")
    ) +
    ggtitle("Adolescents <70 kg, 1.3 mg/kg; Adults, 100 mg") +
    theme(legend.position = c(0.63, 0.82)) +
    po.nopanel
  ggsave(paste(filepath, "/adults_sim_ado_below70kg_SS.png", sep = ""), width = width, height = height, dpi = dpi)

  ggplot(data = subset(dat1, GRP == 7), aes(x = time / 7, y = q50)) +
    geom_line(size = 1, color = "black") +
    geom_ribbon(aes(ymin = q5, ymax = q95, fill = "black"), alpha = 0.2) +
    geom_line(data = subset(dat1, GRP == 2), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "#00BFC4") +
    geom_ribbon(data = subset(dat1, GRP == 2), aes(ymin = q5, ymax = q95, fill = "#00BFC4"), alpha = 0.2) +
    # geom_line(data=subset(dat1,GRP==5),aes(x=time/7,y=q50),linetype="solid",size=1,color="red")+
    # geom_ribbon(data=subset(dat1,GRP==5),aes(ymin=q5, ymax=q95,fill="red"),alpha=0.2)+
    xlab("Time (Weeks)") +
    ylab("Guselkumab Concentration (µg/mL)") +
    scale_x_continuous(limits = c(44, 52), breaks = c(44, 46, 48, 50, 52), labels = c(0, 2, 4, 6, 8)) +
    scale_y_continuous(limits = c(0, 15), breaks = c(0, 5, 10, 15)) +
    scale_fill_manual("",
                      values = c("black" = "black", "#00BFC4" = "#00BFC4"),
                      breaks = c("black", "#00BFC4"),
                      labels = c("Adults", "Adolescents \u226512 to <18 yrs")
    ) +
    ggtitle("Adolescents >70 kg, 100 mg; Adults, 100 mg") +
    theme(legend.position = c(0.63, 0.82)) +
    po.nopanel
  ggsave(paste(filepath, "/adults_sim_ado_above70kg_SS.png", sep = ""), width = width, height = height, dpi = dpi)


  ggplot(data = subset(dat1, GRP == 7), aes(x = time / 7, y = q50)) +
    geom_line(size = 1, color = "black") +
    geom_ribbon(aes(ymin = q5, ymax = q95, fill = "black"), alpha = 0.2) +
    geom_line(data = subset(dat1, GRP == 3), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "#00BFC4") +
    geom_ribbon(data = subset(dat1, GRP == 3), aes(ymin = q5, ymax = q95, fill = "#00BFC4"), alpha = 0.2) +
    # geom_line(data=subset(dat1,GRP==6),aes(x=time/7,y=q50),linetype="solid",size=1,color="red")+
    # geom_ribbon(data=subset(dat1,GRP==6),aes(ymin=q5, ymax=q95,fill="red"),alpha=0.2)+
    xlab("Time (Weeks)") +
    ylab("Guselkumab Concentration (µg/mL)") +
    scale_x_continuous(limits = c(44, 52), breaks = c(44, 46, 48, 50, 52), labels = c(0, 2, 4, 6, 8)) +
    scale_y_continuous(limits = c(0, 15), breaks = c(0, 5, 10, 15)) +
    scale_fill_manual("",
                      values = c("black" = "black", "#00BFC4" = "#00BFC4"),
                      breaks = c("black", "#00BFC4"),
                      labels = c("Adults", "Adolescents \u226512 to <18 yrs")
    ) +
    ggtitle("Adolescents, 1.3 mg/kg for <70 kg 100 mg for >=70kg; Adults, 100 mg") +
    theme(legend.position = c(0.63, 0.82)) +
    po.nopanel
  ggsave(paste(filepath, "/adults_sim_ado_all_SS.png", sep = ""), width = width, height = height, dpi = dpi)
}




plot.fun.adult.ped <- function(filepath, width = 6, height = 5.5, dpi = 150, cutoff = "70", xlab = "Time (Weeks)", ylab = "Guselkumab Concentration (µg/mL)") {
  ggplot(data = subset(dat1, GRP == 7), aes(x = time / 7, y = q50)) +
    geom_line(size = 1, color = "black") +
    geom_ribbon(aes(ymin = q5, ymax = q95, fill = "black"), alpha = 0.2) +
    #  geom_line(data=subset(dat1,GRP==1),aes(x=time/7,y=q50),linetype="solid",size=1,color="#00BFC4")+
    # geom_ribbon(data=subset(dat1,GRP==1),aes(ymin=q5, ymax=q95,fill="#00BFC4"),alpha=0.2)+
    geom_line(data = subset(dat1, GRP == 4), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "red") +
    geom_ribbon(data = subset(dat1, GRP == 4), aes(ymin = q5, ymax = q95, fill = "red"), alpha = 0.2) +
    xlab("Time (Weeks)") +
    ylab("Guselkumab Concentration (µg/mL)") +
    scale_x_continuous(limits = c(44, 52), breaks = c(44, 46, 48, 50, 52), labels = c(0, 2, 4, 6, 8)) +
    scale_y_continuous(limits = c(0, 15), breaks = c(0, 5, 10, 15)) +
    scale_fill_manual("",
                      values = c("black" = "black", "red" = "red"),
                      breaks = c("black", "red"),
                      labels = c("Adults", "Pediatrics \u22656 to <12 yrs")
    ) +
    ggtitle("Pediatrics < 70 kg, 1.3 mg/kg; Adults, 100 mg") +
    theme(legend.position = c(0.63, 0.82)) +
    po.nopanel
  ggsave(paste(filepath, "/adults_sim_ped_below70kg_SS.png", sep = ""), width = width, height = height, dpi = dpi)

  ggplot(data = subset(dat1, GRP == 7), aes(x = time / 7, y = q50)) +
    geom_line(size = 1, color = "black") +
    geom_ribbon(aes(ymin = q5, ymax = q95, fill = "black"), alpha = 0.2) +
    geom_line(data = subset(dat1, GRP == 5), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "red") +
    geom_ribbon(data = subset(dat1, GRP == 5), aes(ymin = q5, ymax = q95, fill = "red"), alpha = 0.2) +
    # geom_line(data=subset(dat1,GRP==5),aes(x=time/7,y=q50),linetype="solid",size=1,color="red")+
    # geom_ribbon(data=subset(dat1,GRP==5),aes(ymin=q5, ymax=q95,fill="red"),alpha=0.2)+
    xlab("Time (Weeks)") +
    ylab("Guselkumab Concentration (µg/mL)") +
    scale_x_continuous(limits = c(44, 52), breaks = c(44, 46, 48, 50, 52), labels = c(0, 2, 4, 6, 8)) +
    scale_y_continuous(limits = c(0, 15), breaks = c(0, 5, 10, 15)) +
    scale_fill_manual("",
                      values = c("black" = "black", "red" = "red"),
                      breaks = c("black", "red"),
                      labels = c("Adults", "Pediatrics \u22656 to <12 yrs")
    ) +
    ggtitle("Pediatrics > 70 kg, 100 mg; Adults, 100 mg") +
    theme(legend.position = c(0.63, 0.82)) +
    po.nopanel
  ggsave(paste(filepath, "/adults_sim_ped_above70kg_SS.png", sep = ""), width = width, height = height, dpi = dpi)


  ggplot(data = subset(dat1, GRP == 7), aes(x = time / 7, y = q50)) +
    geom_line(size = 1, color = "black") +
    geom_ribbon(aes(ymin = q5, ymax = q95, fill = "black"), alpha = 0.2) +
    geom_line(data = subset(dat1, GRP == 6), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "red") +
    geom_ribbon(data = subset(dat1, GRP == 6), aes(ymin = q5, ymax = q95, fill = "red"), alpha = 0.2) +
    # geom_line(data=subset(dat1,GRP==6),aes(x=time/7,y=q50),linetype="solid",size=1,color="red")+
    # geom_ribbon(data=subset(dat1,GRP==6),aes(ymin=q5, ymax=q95,fill="red"),alpha=0.2)+
    xlab("Time (Weeks)") +
    ylab("Guselkumab Concentration (µg/mL)") +
    scale_x_continuous(limits = c(44, 52), breaks = c(44, 46, 48, 50, 52), labels = c(0, 2, 4, 6, 8)) +
    scale_y_continuous(limits = c(0, 22), breaks = c(0, 5, 10, 15, 20, 25)) +
    scale_fill_manual("",
                      values = c("black" = "black", "red" = "red"),
                      breaks = c("black", "red"),
                      labels = c("Adults", "Pediatrics \u22656 to <12 yrs")
    ) +
    ggtitle("Pediatrics, 1.3 mg/kg for <70 kg 100 mg for \u226570kg; Adults, 100 mg") +
    theme(legend.position = c(0.63, 0.82)) +
    po.nopanel
  ggsave(paste(filepath, "/adults_sim_ped_all_SS.png", sep = ""), width = width, height = height, dpi = dpi)
}





plot.fun.adult.ado.ped <- function(filepath, width = 6, height = 5.5, dpi = 150, cutoff = "70", xlab = "Time (Weeks)", ylab = "Guselkumab Concentration (µg/mL)", ylim = c(0, 22), add.log = FALSE) {

  #GRP = 7  Adults

  g1 <- ggplot(data = subset(dat1, GRP == 7), aes(x = time / 7, y = q50)) +
    geom_line(size = 1, color = "black") +
    geom_ribbon(aes(ymin = q5, ymax = q95, fill = "black"), alpha = 0.35) +
    geom_line(data = subset(dat1, GRP == 1), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "#00BFC4") +
    geom_ribbon(data = subset(dat1, GRP == 1), aes(ymin = q5, ymax = q95, fill = "#00BFC4"), alpha = 0.2) +
    geom_line(data = subset(dat1, GRP == 4), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "red") +
    geom_ribbon(data = subset(dat1, GRP == 4), aes(ymin = q5, ymax = q95, fill = "red"), alpha = 0.2) +
    xlab("Time (Weeks)") +
    ylab("Guselkumab Concentration (µg/mL)") +
    scale_x_continuous(limits = c(44, 52), breaks = c(44, 46, 48, 50, 52), labels = c(0, 2, 4, 6, 8)) +
    scale_y_continuous(limits = ylim, breaks = c(0, 5, 10, 15, 20, 25)) +
    scale_fill_manual("",
                      values = c("black" = "black", "#00BFC4" = "#00BFC4", "red" = "red"),
                      breaks = c("black", "#00BFC4", "red"),
                      labels = c("Adults", "Adolescents \u226512 to <18 yrs", "Children \u22656 to <12 yrs")
    ) +
    ggtitle(paste0("Pediatrics <", cutoff, " kg")) +
    theme_bw() +
    po.nopanel3 +
    theme(legend.position = c(0.63, 0.82))
  g1
  ggsave(paste(filepath, "/adults_sim_ado_ped_below", cutoff, "kg_ss.png", sep = ""), width = width, height = height, dpi = dpi)

  if (add.log) {
    g1 + scale_y_log10(limits = c(0.1,100))
    ggsave(paste(filepath, "/adults_sim_ado_ped_below", cutoff, "kg_ss_log.png", sep = ""), width = width, height = height, dpi = dpi)
  }

  g2 <- ggplot(data = subset(dat1, GRP == 7), aes(x = time / 7, y = q50)) +
    geom_line(size = 1, color = "black") +
    geom_ribbon(aes(ymin = q5, ymax = q95, fill = "black"), alpha = 0.35) +
    geom_line(data = subset(dat1, GRP == 2), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "#00BFC4") +
    geom_ribbon(data = subset(dat1, GRP == 2), aes(ymin = q5, ymax = q95, fill = "#00BFC4"), alpha = 0.2) +
    geom_line(data = subset(dat1, GRP == 5), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "red") +
    geom_ribbon(data = subset(dat1, GRP == 5), aes(ymin = q5, ymax = q95, fill = "red"), alpha = 0.2) +
    xlab("Time (Weeks)") +
    ylab("Guselkumab Concentration (µg/mL)") +
    scale_x_continuous(limits = c(44, 52), breaks = c(44, 46, 48, 50, 52), labels = c(0, 2, 4, 6, 8)) +
    scale_y_continuous(limits = ylim, breaks = c(0, 5, 10, 15, 20, 25)) +
    scale_fill_manual("",
                      values = c("black" = "black", "#00BFC4" = "#00BFC4", "red" = "red"),
                      breaks = c("black", "#00BFC4", "red"),
                      labels = c("Adults", "Adolescents \u226512 to <18 yrs", "Children \u22656 to <12 yrs")
    ) +
    ggtitle(paste0("Pediatrics ≥", cutoff, " kg")) +
    theme_bw() +
    po.nopanel3 +
    theme(legend.position = c(0.63, 0.82))
  g2
  ggsave(paste(filepath, "/adults_sim_ado_ped_above", cutoff, "kg_ss.png", sep = ""), width = width, height = height, dpi = dpi)

  if (add.log) {
    g2 + scale_y_log10(limits = c(0.1,100))
    ggsave(paste(filepath, "/adults_sim_ado_ped_above", cutoff, "kg_ss_log.png", sep = ""), width = width, height = height, dpi = dpi)
  }
  g3 <- ggplot(data = subset(dat1, GRP == 7), aes(x = time / 7, y = q50)) +
    geom_line(size = 1, color = "black") +
    geom_ribbon(aes(ymin = q5, ymax = q95, fill = "black"), alpha = 0.35) +
    geom_line(data = subset(dat1, GRP == 3), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "#00BFC4") +
    geom_ribbon(data = subset(dat1, GRP == 3), aes(ymin = q5, ymax = q95, fill = "#00BFC4"), alpha = 0.2) +
    geom_line(data = subset(dat1, GRP == 6), aes(x = time / 7, y = q50), linetype = "solid", size = 1, color = "red") +
    geom_ribbon(data = subset(dat1, GRP == 6), aes(ymin = q5, ymax = q95, fill = "red"), alpha = 0.2) +
    xlab("Time (Weeks)") +
    ylab("Guselkumab Concentration (µg/mL)") +
    scale_x_continuous(limits = c(44, 52), breaks = c(44, 46, 48, 50, 52), labels = c(0, 2, 4, 6, 8)) +
    scale_y_continuous(limits = ylim, breaks = c(0, 5, 10, 15, 20, 25)) +
    scale_fill_manual("",
                      values = c("black" = "black", "#00BFC4" = "#00BFC4", "red" = "red"),
                      breaks = c("black", "#00BFC4", "red"),
                      labels = c("Adults", "Adolescents \u226512 to <18 yrs", "Children \u22656 to <12 yrs")
    ) +
    ggtitle(paste0("All Pediatrics")) +
    theme_bw() +
    po.nopanel3 +
    theme(legend.position = c(0.63, 0.82))
  g3
  ggsave(paste(filepath, "/adults_sim_ado_ped_", cutoff, "all_ss.png", sep = ""), width = width, height = height, dpi = dpi)


  g1 + g2 + g3 + patchwork::plot_layout(ncol = 2)
  ggsave(paste(filepath, "/adults_sim_ado_ped_", cutoff, "all_combined_cp.png", sep = ""), width = width * 2.2, height = height * 2, dpi = dpi)

  if (add.log) {
    g3 + scale_y_log10(limits = c(0.1,100))
    ggsave(paste(filepath, "/adults_sim_ado_ped_", cutoff, "all_ss_log.png", sep = ""), width = width, height = height, dpi = dpi)

    lg1 <- g1 + scale_y_log10(limits = c(0.1,100))
    lg2 <- g2 + scale_y_log10(limits = c(0.1,100))
    lg3 <- g3 + scale_y_log10(limits = c(0.1,100))

    lg1 + lg2 + lg3 + patchwork::plot_layout(ncol = 2)
    ggsave(paste(filepath, "/adults_sim_ado_ped_", cutoff, "all_combined_cp_log.png", sep = ""), width = width * 2.2, height = height * 2, dpi = dpi)
  }

  list(g1, g2, g3)
}


theme2 <- theme(
  panel.background = element_rect(fill = "white"),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  axis.text.x = element_text(vjust = 0.5)
)




boxplot.fun.wob <- function(pk.cal.plot, simnames, refGRP = 7) {
  quantauc <- quantile(pk.cal.plot[pk.cal.plot$GRP == refGRP, ]$AUC, probs = c(0.05, 0.5, 0.95))
  lendt <- nrow(pk.cal.plot)
  uniqgrp <- length(unique(pk.cal.plot$GRP))

  auc.box <- ggplot(pk.cal.plot, aes(x = factor(GRP), y = AUC, fill = AGEC)) +
    stat_boxplot(geom = "errorbar", width = 0.6) +
    geom_ribbon(aes(x = seq(0, uniqgrp + 1, length.out = lendt), ymin = quantauc[1], ymax = quantauc[3]), fill = "red", alpha = 0.2) +
    geom_hline(yintercept = quantauc[2], color = "red", linetype = 2) +
    # need to before geom_boxplot
    geom_boxplot(show.legend = F, outlier.shape = NA) +
    # stat_summary(fun=mean, geom="point", shape=18, size=3, color="#cccccc") +
    labs(title = "AUC", y = "Guselkumab AUC (µg*day/mL)", x = "") +
    geom_point(data = observedauc %>% filter(GRP != 7), position = position_jitterdodge(seed = 4087), color = "#555555", shape = 1, size = 2.5) +
    # geom_point(data = observedauc %>% filter(GRP == 7), position = position_jitterdodge(), color = "#CCCCCC", shape = 1, size = 2.5) +
    theme(axis.text.x = element_text(angle = 0, hjust = 1)) +
    guides(fill = "none") +
    theme1 +
    po.nopanel
  # ggsave(file = paste(filepath, "/", simnames, "-auc-overlay.box.png", sep = ""), width = 7, height = 5, auc.box)

  return(list(auc.box))
}

roundf <- function(num, to = 2) {
  format(round(num, digits = to), nsmall = to)
}

roundf2 <- function(num, to = 2) {
  sprintf(paste0("%.", to, "f"), num)
}

boxplot.fun.all <- function(pk.cal.plot, title = c("AUC", "Cmax", "Ctrough"), refGRP = 7, excl.grp = NULL) {
  # information for the target range shade
  quantauc <- quantile(pk.cal.plot[pk.cal.plot$GRP == refGRP, ]$AUC, probs = c(0.05, 0.5, 0.95))
  quantcmax <- quantile(pk.cal.plot[pk.cal.plot$GRP == refGRP, ]$Cmax, probs = c(0.05, 0.5, 0.95))
  quantctr <- quantile(pk.cal.plot[pk.cal.plot$GRP == refGRP, ]$Ctrough, probs = c(0.05, 0.5, 0.95))

  # exclude group if not needed
  if (not.null(excl.grp)) pk.cal.plot <- pk.cal.plot %>% filter(GRP %nin% excl.grp)

  # compute length and unique groups
  lendt <- nrow(pk.cal.plot)
  uniqgrp <- length(unique(pk.cal.plot$GRP))

  # get median values for labels
  medgrp1 <- pk.cal.plot %>% group_by(GRPC, AGEC)
  mediauc <- medgrp1 %>% summarise(med = signif(median(AUC), 3), yaxis = (function(x) {
    j <- quantile(x, probs = c(0.5, 0.75))
    j[1] + (0.4 * (j[2] - j[1]))
  })(AUC))
  medicmax <- medgrp1 %>% summarise(med = format(round(median(Cmax), 2), nsmall = 2), yaxis = (function(x) {
    j <- quantile(x, probs = c(0.5, 0.75))
    j[1] + (0.4 * (j[2] - j[1]))
  })(Cmax))
  medictr <- medgrp1 %>% summarise(med = format(round(median(Ctrough), 2), nsmall = 2), yaxis = (function(x) {
    j <- quantile(x, probs = c(0.5, 0.75))
    j[1] + (0.4 * (j[2] - j[1]))
  })(Ctrough))


  # make plots
  auc.box <- ggplot(pk.cal.plot, aes(x = factor(GRPC), y = AUC, fill = AGEC)) +
    stat_boxplot(geom = "errorbar", width = 0.6) +
    geom_ribbon(aes(x = seq(0, uniqgrp + 1, length.out = lendt), ymin = quantauc[1], ymax = quantauc[3]), fill = "red", alpha = 0.2) +
    geom_hline(yintercept = quantauc[2], color = "red", linetype = 2) +
    geom_boxplot(show.legend = F) +
    # stat_summary(fun=mean, geom="point", shape=18, size=3, color="#cccccc") +
    geom_text(data = mediauc, aes(x = factor(GRPC), y = yaxis, label = med)) +
    # coord_cartesian(ylim = c(0, 1000)) +
    labs(title = title[1], y = "Guselkumab AUC (µg*day/mL)", x = "") +
    theme(axis.text.x = element_text(angle = 45, hjust = 0.5)) +
    theme1 +
    po.nopanel
  # ggsave(file = paste(filepath, "/", simnames, "auc.box.png", sep = ""), width = 4, height = 5, auc.box)

  Cmax.box <- ggplot(pk.cal.plot, aes(x = factor(GRPC), y = Cmax, fill = AGEC)) +
    stat_boxplot(geom = "errorbar", width = 0.6) +
    geom_ribbon(aes(x = seq(0, uniqgrp + 1, length.out = lendt), ymin = quantcmax[1], ymax = quantcmax[3]), fill = "red", alpha = 0.2) +
    geom_hline(yintercept = quantcmax[2], color = "red", linetype = 2) +
    geom_boxplot(show.legend = F) +
    # stat_summary(fun=mean, geom="point", shape=18, size=3, color="#cccccc") +
    geom_text(data = medicmax, aes(x = factor(GRPC), y = yaxis, label = med)) +
    labs(title = title[2], y = "Guselkumab Cmax (µg/mL)", x = "") +
    theme(axis.text.x = element_text(angle = 45, hjust = 0.5)) +
    theme1 +
    po.nopanel
  # ggsave(file = paste(filepath, "/", simnames, "Cmax.box.png", sep = ""), width = 4, height = 5, Cmax.box)

  Ctrough.box <- ggplot(pk.cal.plot, aes(x = factor(GRPC), y = Ctrough, fill = AGEC)) +
    stat_boxplot(geom = "errorbar", width = 0.6) +
    geom_ribbon(aes(x = seq(0, uniqgrp + 1, length.out = lendt), ymin = quantctr[1], ymax = quantctr[3]), fill = "red", alpha = 0.2) +
    geom_hline(yintercept = quantctr[2], color = "red", linetype = 2) +
    geom_boxplot(show.legend = F) +
    # stat_summary(fun=mean, geom="point", shape=18, size=3, color="#cccccc") +
    geom_text(data = medictr, aes(x = factor(GRPC), y = yaxis, label = med)) +
    labs(title = title[3], y = "Guselkumab Ctrough (µg/mL)", x = "") +
    theme(axis.text.x = element_text(angle = 45, hjust = 0.5)) +
    theme1 +
    po.nopanel
  # ggsave(file = paste(filepath, "/", simnames, "Ctrough.box.png", sep = ""), width = 4, height = 5, Ctrough.box)

  return(list(auc.box, Cmax.box, Ctrough.box))
}

boxplot.fun.all.style2 <- function(pk.cal.plot, title = c("AUC", "Cmax", "Ctrough"), refGRP = 7, excl.grp = NULL) {

  # exclude group if not needed
  if (not.null(excl.grp)) pk.cal.plot <- pk.cal.plot %>% filter(GRP %nin% excl.grp)

  # compute length and unique groups
  lendt <- nrow(pk.cal.plot)
  uniqgrp <- length(unique(pk.cal.plot$GRP))



  # make plots
  auc.box <- ggplot(pk.cal.plot, aes(x = factor(GRPC), y = AUC, fill = AGEC)) +
    stat_boxplot(geom = "errorbar", width = 0.6) +
    geom_boxplot(show.legend = F) +
    labs(title = title[1], y = bquote(AUC (µgxday / mL)), x = "") +
    theme(axis.text.x = element_text(angle = 45, hjust = 0.5)) +
    theme1 +
    po.nopanel

  Cmax.box <- ggplot(pk.cal.plot, aes(x = factor(GRPC), y = Cmax, fill = AGEC)) +
    stat_boxplot(geom = "errorbar", width = 0.6) +
    geom_boxplot(show.legend = F) +
    labs(title = title[2], y = bquote(Cmax (µg / mL)), x = "") +
    theme(axis.text.x = element_text(angle = 45, hjust = 0.5)) +
    theme1 +
    po.nopanel

  Ctrough.box <- ggplot(pk.cal.plot, aes(x = factor(GRPC), y = Ctrough, fill = AGEC)) +
    stat_boxplot(geom = "errorbar", width = 0.6) +
    geom_boxplot(show.legend = F) +
    labs(title = title[3], y = bquote(Ctrough (µg / mL)), x = "") +
    theme(axis.text.x = element_text(angle = 45, hjust = 0.5)) +
    theme1 +
    po.nopanel

  return(list(auc.box, Cmax.box, Ctrough.box))
}


boxplot.fun.wtband <- function(pk.cal.plot, title = c("AUC", "Cmax", "Ctrough"), refGRP = 28, below70Grp = 29,
                               excl.grp = NULL,
                               colormx = c("red", "white", "black"), prefix.ylab = "Guselkumab ") {
  # information for the target range = all adults
  quantauc <- quantile(pk.cal.plot[pk.cal.plot$GRP == refGRP, ]$AUC, probs = c(0.05, 0.5, 0.95))
  quantcmax <- quantile(pk.cal.plot[pk.cal.plot$GRP == refGRP, ]$Cmax, probs = c(0.05, 0.5, 0.95))
  quantctr <- quantile(pk.cal.plot[pk.cal.plot$GRP == refGRP, ]$Ctrough, probs = c(0.05, 0.5, 0.95))

  # information for the target range shade = adults < 70kg
  quantauc2 <- quantile(pk.cal.plot[pk.cal.plot$GRP == below70Grp, ]$AUC, probs = c(0.05, 0.5, 0.95))
  quantcmax2 <- quantile(pk.cal.plot[pk.cal.plot$GRP == below70Grp, ]$Cmax, probs = c(0.05, 0.5, 0.95))
  quantctr2 <- quantile(pk.cal.plot[pk.cal.plot$GRP == below70Grp, ]$Ctrough, probs = c(0.05, 0.5, 0.95))

  # exclude group if not needed
  if (not.null(excl.grp)) pk.cal.plot <- pk.cal.plot %>% filter(GRP %nin% excl.grp)

  xlab1 <- "Body Weight Groups (kg)"

  # get median values for labels
  medgrp1 <- pk.cal.plot %>% group_by(GRPC, AGEC)
  mediauc <- medgrp1 %>% summarise(med = signif(median(AUC), 3), yaxis = (function(x) {
    j <- quantile(x, probs = c(0.5, 0.75))
    j[1] + (0.4 * (j[2] - j[1]))
  })(AUC))
  medicmax <- medgrp1 %>% summarise(med = format(round(median(Cmax), 2), nsmall = 2), yaxis = (function(x) {
    j <- quantile(x, probs = c(0.5, 0.75))
    j[1] + (0.4 * (j[2] - j[1]))
  })(Cmax))
  medictr <- medgrp1 %>% summarise(med = format(round(median(Ctrough), 2), nsmall = 2), yaxis = (function(x) {
    j <- quantile(x, probs = c(0.5, 0.75))
    j[1] + (0.4 * (j[2] - j[1]))
  })(Ctrough))

  # compute length and unique groups
  lendt <- nrow(pk.cal.plot)
  uniqgrp <- length(unique(pk.cal.plot$GRP))
  # make plots
  auc.box <- ggplot(pk.cal.plot, aes(x = factor(GRPC), y = AUC, fill = TRT2)) +
    geom_boxplot() +
    geom_hline(yintercept = quantauc2[3], color = "blue", linetype = 2) + # 95%
    geom_hline(yintercept = quantauc2[1], color = "blue", linetype = 2) + # 5%
    geom_hline(yintercept = quantauc[3], color = "gray", linetype = 4) + # 95%
    geom_hline(yintercept = quantauc[1], color = "gray", linetype = 4) + # 5%
    scale_fill_manual(values = colormx) +
    guides(fill = guide_legend(ncol = 2)) +
    labs(title = title[1], y = paste0(prefix.ylab, "AUC (µg*day/mL)"), x = xlab1, fill = "Cutoff:") +
    theme(axis.text.x = element_text(angle = 45, hjust = 0.5)) +
    theme1 +
    po.nopanel

  Cmax.box <- ggplot(pk.cal.plot, aes(x = factor(GRPC), y = Cmax, fill = TRT2)) +
    geom_boxplot() +
    geom_hline(yintercept = quantcmax2[3], color = "blue", linetype = 2) + # 95%
    geom_hline(yintercept = quantcmax2[1], color = "blue", linetype = 2) + # 5%
    geom_hline(yintercept = quantcmax[3], color = "gray", linetype = 4) + # 95%
    geom_hline(yintercept = quantcmax[1], color = "gray", linetype = 4) + # 5%
    scale_fill_manual(values = colormx) +
    guides(fill = guide_legend(ncol = 2)) +
    labs(title = title[2], y = paste0(prefix.ylab, "Cmax (µg/mL)"), x = xlab1, fill = "Cutoff:") +
    theme(axis.text.x = element_text(angle = 45, hjust = 0.5)) +
    theme1 +
    po.nopanel
  # ggsave(file = paste(filepath, "/", simnames, "Cmax.box.png", sep = ""), width = 4, height = 5, Cmax.box)

  Ctrough.box <- ggplot(pk.cal.plot, aes(x = factor(GRPC), y = Ctrough, fill = TRT2)) +
    geom_boxplot() +
    geom_hline(yintercept = quantctr2[3], color = "blue", linetype = 2) + # 95%
    geom_hline(yintercept = quantctr2[1], color = "blue", linetype = 2) + # 5%
    geom_hline(yintercept = quantctr[3], color = "gray", linetype = 4) + # 95%
    geom_hline(yintercept = quantctr[1], color = "gray", linetype = 4) + # 5%
    scale_fill_manual(values = colormx) +
    guides(fill = guide_legend(ncol = 2)) +
    labs(title = title[3], y = paste0(prefix.ylab, "Ctrough (µg/mL)"), x = xlab1, fill = "Cutoff:") +
    theme(axis.text.x = element_text(angle = 45, hjust = 0.5)) +
    theme1 +
    po.nopanel

  return(list(auc.box, Cmax.box, Ctrough.box))
}
