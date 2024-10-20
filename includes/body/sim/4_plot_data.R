#########################################################################################
#########################################################################################
##
##  Document Path: ~/ShinyApps/collective4/modules/pharmacometric-shiny-template-main/includes/body/sim/plot_data.R
##
##  R version 4.2.0 (2022-04-22)
#########################################################################################
#########################################################################################

output$distPlot <- renderPlot({
  plot(1:100,
       1:100,
       xlab = "sample x",
       type = "l",
       ylab = "sample y"
  )
  text(50, 50, "Click 'Start simulation' to run simulations and display results", cex = 1.2, pos = 3, col = "red")
})



observe({
  if (not.null(GLOBAL$lastsim) & not.na(GLOBAL$start.sim))
  output$distPlot <- renderPlot({

    updateGraphStatus("Preparing plots...")


    if (not.null(GLOBAL$lastsim) & not.na(GLOBAL$start.sim)) {
      gplo1 <- ggplot(data = GLOBAL$lastsim %>% mutate(byID = paste0("Group ",Group,": ", ID))) +
        geom_line(aes(x = time, y = IPRED, color = Group)) +
        labs(
          #title = "Total US population over time",
          #subtitle = "Population in thousands",
          x = input$labelx,
          y = input$labely
        ) +
        theme_bw() +
        potheme +
        theme(
          text = element_text(family = input$graphfont),
          axis.text = element_text(
            size = input$fontxyticks,
            family = input$graphfont
          ),
          axis.title = element_text(
            size = input$fontxytitle,
            family = input$graphfont
          ),
          strip.text = element_text(
            size = input$fontxystrip,
            family = input$graphfont
          ),
          legend.text = element_text(family = input$graphfont),
          legend.title = element_text(family = input$graphfont),
          title = element_text(family = input$graphfont)
        )

      if (input$graphtype == "Facet by ID") {
        gplo1 <- gplo1 + aes(color = ID) + facet_wrap(byID ~ ., ncol = 3)
      }
      if (input$graphtype == "Facet by Group") {
        gplo1 <- gplo1 + facet_wrap(Group ~ ., ncol = 3)
      }
      if (input$graphtype == "Facet by Dose") {
        gplo1 <- gplo1 + facet_wrap(Dose ~ ., ncol = 3)
      }

      updateGraphStatus("Plots completed.")
      gplo1
    }
  })
})

