print("just here...server...header")
print(this.path)
observeEvent(input$aboutproject, {
  showModal(modalDialog(
    title = "About this app",
    "This simulation app was created by Bill. 2024. Use  freely."
  ))
})
