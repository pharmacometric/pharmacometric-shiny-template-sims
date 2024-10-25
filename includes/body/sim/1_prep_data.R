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

GLOBAL$mod <- mread("sim", project = file.path(this.path, "sim"))

# mod <- update(mod, end = 120, delta = 4, param = list(CL = 19.1))

GLOBAL$x1exec <- TRUE
observe({
  GLOBAL$sim.parameters <- param(GLOBAL$mod)
  simparameters <- indexed(names(GLOBAL$sim.parameters))

  if (GLOBAL$x1exec) {
    output$mrgsolveparms <- renderText({
      HTML(paste0("<b>Model Parameters</b>: ", length(GLOBAL$sim.parameters)))
    })

    for (upi in simparameters) {
      insertUI(
        selector = "#mrgsolveparms",
        where = "afterEnd",
        ui = sliderInput(paste0("parm", upi$key),
          upi$value,
          min = as.numeric(GLOBAL$sim.parameters[upi$value]) / 1000,
          max = 100 + as.numeric(GLOBAL$sim.parameters[upi$value]) * 10,
          value = as.numeric(GLOBAL$sim.parameters[upi$value]),
          width = "100%"
        )
      )
    }
    GLOBAL$x1exec <- FALSE
  } else {
    # configure the model to update when parameters are updated
    dfparm <- data.frame(Init = 0)
    for (upi in simparameters) {
      dfparm[, upi$value] <- input[[paste0("parm", upi$key)]]
    }
    GLOBAL$mod <- update(GLOBAL$mod, param = as.list(dfparm))
  }
})




#identical(rTable_content(),input$rTable)

# no data
GLOBAL$lastregimen <- data.frame()

#fetch regimen
finalregimen <- reactive({
  if (!is.null(input$rhstable1)){
    d <- as.data.frame(hot_to_r(input$rhstable1))
    d[is.empty(d)] = NA
    GLOBAL$lastregimen <- d[complete.cases(d),]
  }
  GLOBAL$lastregimen
})


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

    lbl1 <- unique(d1$Group)
    lbl2 <- setNames(0:{
      length(lbl1) - 1
    }, lbl1)

    merge(d1, data.frame(ONUM = 1:input$samplesize)) %>%
      mutate(Group2 = lbl2[Group], ID = ONUM + (Group2 * input$samplesize)) %>%
      arrange(Group, ID) %>%
      group_by(Group, ID) %>%
      mutate(
        WT = round(rnorm(n(), mean = WT[1], sd = 15), 2),
        time = ifelse(Frequency>1,c(0, pop_off(cumsum(Frequency * 7))), Frequency)
      ) %>%
      ungroup()
  }
})
