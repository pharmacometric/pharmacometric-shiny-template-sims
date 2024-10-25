
summar01 <- reactive({
data.frame(
  Group = 0,
  AUC = 0,
  Ctrough = 0,
  Cmax = 0
  )

})

output$summaryexptbl <- renderDT(
  summar01(), options = list(lengthChange = FALSE)
)



observe({
  updateSliderInput(
    session = session,
    "selectedrangesumm",
              "Select range for summary",
    value = c(0, input$enddoseat * 7), max = input$enddoseat * 7
  )


})
