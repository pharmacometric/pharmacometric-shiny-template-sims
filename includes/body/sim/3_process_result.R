#########################################################################################
#########################################################################################
##
##  Document Path: pharmacometric-shiny-template-main/includes/body/sim/process_result.R
##
##
##  R version 4.2.0 (2022-04-22)
##
#########################################################################################
#########################################################################################

data01_all <- reactive({
  dataa <- data01()
  if (nrow(dataa)) {
    dataa %>% mutate(type = "all") %>% group_by(type, time) %>%
      summarise(
        IPRED_mean = mean(IPRED),
        IPRED_med = median(IPRED),
        sd = sd(IPRED),
        sem = sd(IPRED)/sqrt(length((IPRED))),
        q95 = quantile(IPRED,probs = 0.95),
        q05 = quantile(IPRED,probs = 0.05))
  }
})

data02_group <- reactive({
  dataa <- data01()
  if (nrow(dataa)) {
    dataa %>% group_by(Group,Group2, time) %>%
      summarise(
        IPRED_mean = mean(IPRED),
        IPRED_med = median(IPRED),
        sd = sd(IPRED),
        sem = sd(IPRED)/sqrt(length((IPRED))),
        q95 = quantile(IPRED,probs = 0.95),
        q05 = quantile(IPRED,probs = 0.05))
  }
})
