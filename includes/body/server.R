for(e in list.files(file.path(this.path,"sim/"), pattern = ".R$"))
  source(file.path(this.path,"sim", e), local = TRUE)



output$tracksimulations <- renderText({
  if(is.null(GLOBAL$lastsim)){
    "No simulations have been run."
  }
})



observeEvent(input$runsimbutton,{
  disableSims()
  #Sys.sleep(2)
  GLOBAL$start.sim <- TRUE
})


output$summaryrestbl = renderDT(
  data01() %>% select(Group,ID,time,WT,Dose,cmt,ii,addl), options = list(lengthChange = FALSE)#,dom = 't'
)

output$rawrestbl = renderDT(
  summary01(), options = list(lengthChange = FALSE), filter = list(position = "top")
)



output$rhstable1 <- renderRHandsontable({
  rhandsontable(regimenDT, width = "100%") %>%
    hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE)
})




