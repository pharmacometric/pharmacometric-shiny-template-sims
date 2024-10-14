#########################################################################################
#########################################################################################
##
##  Document Path: pharmacometric-shiny-template-main/includes/body/sim/prep_data.R
##
##
##  R version 4.2.0 (2022-04-22)
##
#########################################################################################
#########################################################################################

mod <- mread("sim", project = file.path(this.path, "sim"))
modparms <- param(mod)
# mod <- update(mod, end = 120, delta = 4, param = list(CL = 19.1))


set.seed(seed.val)


data01 <- reactive({
  dataa <- finalregimen()
  if (nrow(dataa)) {
    d1 <- dataa %>% mutate(
      amt = Dose,
      addl = Additional,
      ii = Frequency * 7,
      cmt = ifelse(tolower(Route) == "iv", 2, 1),
      evid = 1
    )

    lbl1 = unique(d1$Group)
    lbl2 = setNames(0:{length(lbl1)-1},lbl1)

    merge(d1, data.frame(ONUM = 1:input$samplesize)) %>%
      mutate(Group2 = lbl2[Group], ID = ONUM+(Group2*input$samplesize)) %>%
      arrange(Group, ID) %>%
      group_by(Group, ID) %>%
      mutate(
        WT = round(rnorm(n(), mean = WT[1], sd = 15),2),
        time = c(0, pop_off(cumsum(Frequency * 7)))
      ) %>%
      ungroup()
  }
})
