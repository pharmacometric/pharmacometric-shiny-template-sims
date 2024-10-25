summar01 <- reactive({
  dataa <- GLOBAL$lastsim
  if (length(dataa) & not.null(dataa)) {
    if (nrow(dataa)) {
      #joooooooooooo<<-((dataa))
      return(dataa %>%
        filter(between(time,input$selectedrangesumm[1], input$selectedrangesumm[2])) %>%
        group_by(Group, ID) %>%
        summary(
          AUC = calculate_auc(time, IPRED),
          Ctrough = min(IPRED),
          Cmax = max(IPRED)
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


summar02 <- reactive({
  dataa <- summar01()

  if (length(dataa)) {
    if (nrow(dataa)) {
      return(table1(~ AUC + Ctrough + Cmax | as.factor(Group), data = dataa))
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
  summar02(),
  options = list(lengthChange = FALSE, dom = "t")
)



observe({
  updateSliderInput(
    session = session,
    "selectedrangesumm",
    "Select range for summary",
    value = c(0, input$enddoseat * 7), max = input$enddoseat * 7
  )
})
