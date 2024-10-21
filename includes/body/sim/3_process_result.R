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
  dataa <- GLOBAL$lastsim
  if (nrow(dataa)) {
    dataa %>% mutate(Group = "all") %>% group_by(Group, time) %>%
      summarise(
        IPRED_mean = mean(IPRED),
        IPRED_med = median(IPRED),
        sd = sd(IPRED),
        sem = sd(IPRED)/sqrt(length((IPRED))),
        q95 = quantile(IPRED,probs = 0.95),
        q05 = quantile(IPRED,probs = 0.05),
        q975 = quantile(IPRED,probs = 0.975),
        q025 = quantile(IPRED,probs = 0.025))
  }
})

data02_group <- reactive({
  dataa <- GLOBAL$lastsim
  if (nrow(dataa)) {
    dataa %>% group_by(Group,Group2, time) %>%
      summarise(
        IPRED_mean = mean(IPRED),
        IPRED_med = median(IPRED),
        sd = sd(IPRED),
        sem = sd(IPRED)/sqrt(length((IPRED))),
        q95 = quantile(IPRED,probs = 0.95),
        q05 = quantile(IPRED,probs = 0.05),
        q975 = quantile(IPRED,probs = 0.975),
        q025 = quantile(IPRED,probs = 0.025))
  }
})
