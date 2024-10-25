summary01 <- reactive({
  dataa <- GLOBAL$lastsim
  if (length(dataa) & not.null(dataa)) {
    if (nrow(dataa)) {
      #joooooooooooo<<-((dataa))
      return(dataa %>%
        filter(between(time,input$selectedrangesumm[1], input$selectedrangesumm[2])) %>%
        group_by(Group, ID) %>%
        summarise(
          AUC = calculate_auc(time, IPRED),
          Ctrough = round(min(IPRED),2),
          Cmax = round(max(IPRED),2)
        ))
    }
  }

  data.frame(
    Group = "A",
    ID = 1,
    AUC = 0,
    Ctrough = 0,
    Cmax = 0
  )
})


summary02 <- reactive({
  dataa <- summary01()
  if (length(dataa)) {
    if (nrow(dataa)) {
      return(table1(~ AUC + Ctrough + Cmax | as.factor(Group), data = dataa, overall=,
                    render.continuous=c(.="Mean (CV%)", .="Median [Min, Max]","Geo. mean (Geo. CV%)"="GMEAN (GCV%)")))
    }
  }

  data.frame(
    Group = 1,
    AUC = 0,
    Ctrough = 0,
    Cmax = 0
  )
})

output$summaryexptbl <- renderTable(
  summary02(),
  options = list(lengthChange = FALSE, dom = "t")
)



observe({
  updateSliderInput(
    session = session,
    "selectedrangesumm",
    value = c(0, input$enddoseat * 7), max = input$enddoseat * 7
  )
})
