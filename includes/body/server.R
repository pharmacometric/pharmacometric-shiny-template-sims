for(e in list.files(file.path(this.path,"sim/"), pattern = ".R$"))
  source(file.path(this.path,"sim", e), local = TRUE)





# tracking simulations
lastsimulation = reactiveVal(0)


output$tracksimulations <- renderText({
  if(!lastsimulation()){
    "No simulations have been run."
  }
})



observeEvent(input$runsimbutton,{
  disableSims()
  GLOBAL$start.sim <- TRUE
})


output$subrestbl = renderDT(
  data01(), options = list(lengthChange = FALSE,dom = 't')
)

output$summaryrestbl = renderDT(
  data.frame(Treatment = letters[1:3],AUC = number(3), Cmax = number(3)), options = list(lengthChange = FALSE,dom = 't')
)

output$rawrestbl = renderDT(
  iris, options = list(lengthChange = FALSE), filter = list(position = "top")
)



output$rhstable1 <- renderRHandsontable({
  rhandsontable(regimenDT, width = "100%") %>%
    hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE)
})


#identical(rTable_content(),input$rTable)

GLOBAL$lastregimen <- data.frame()

finalregimen <- reactive({
  if (!is.null(input$rhstable1)){
    GLOBAL$lastregimen <- as.data.frame(hot_to_r(input$rhstable1))
  }
  GLOBAL$lastregimen
})

