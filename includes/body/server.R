print("just here...server...body")
print(this.path)


source(file.path(this.path,"sim/sim.R"), local = TRUE)



# tracking simulations
lastsimulation = reactiveVal(0)


output$tracksimulations <- renderText({
  if(!lastsimulation()){
    "No simulations have been run."
  }
})



observeEvent(input$runsimbutton,{
  updateSimStatus("Running simulations...")
  updateGraphStatus()
  #output$tracksimulations <- renderText({"Running simulations..."})
})


output$summaryrestbl = renderDT(
  regimenDT, options = list(lengthChange = FALSE,dom = 't')
)

output$rawrestbl = renderDT(
  iris, options = list(lengthChange = FALSE), filter = list(position = "top")
)
