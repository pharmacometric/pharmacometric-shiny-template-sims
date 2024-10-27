message(this.path)
observeEvent(input$aboutproject, {
  showModal(modalDialog(
    title = "About this app",
    "This simulation app was created by William 2024. Use freely."
  ))
})
