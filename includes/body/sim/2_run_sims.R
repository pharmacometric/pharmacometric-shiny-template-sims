#########################################################################################
#########################################################################################
##
##  Document Path: pharmacometric-shiny-template-main/includes/body/sim/run_sims.R
##
##  R version 4.2.0 (2022-04-22)
##
#########################################################################################
#########################################################################################

observe({
  if (GLOBAL$start.sim) {

    updateSimStatus("Preparing data...")
    dataa <- data01()


    updateSimStatus("Running simulations...")
    GLOBAL$lastsim <- mod %>%
      data_set(dataa) %>% # idata_set(exidata) %>% ev(amt = 100, ii = 24, addl = 10) %>%
      mrgsim(
        end = 7 * input$enddoseat,
        obsonly = T,
        delta = input$samplingfrequency,
        carry_out = c("WT", "KOUT", "IC50", "Group2", "Dose"),
        atol = 1e-6,
        output = "df"
      ) %>%
      mutate(ID = paste0("ID ", ID)) %>%
      left_join(dataa %>% select(Group, Group2) %>% distinct())

    updateSimStatus("Simulations completed...")
    GLOBAL$start.sim <- FALSE
    GLOBAL$start.plot <- TRUE
    disableSims('false')
  }
})


