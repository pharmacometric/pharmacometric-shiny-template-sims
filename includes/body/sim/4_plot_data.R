#########################################################################################
#########################################################################################
##
##  Document Path: ~/ShinyApps/collective4/modules/pharmacometric-shiny-template-main/includes/body/sim/plot_data.R
##
##  R version 4.2.0 (2022-04-22)
#########################################################################################
#########################################################################################

# sample plot as placeholder
output$distPlot <- renderPlot({
  plot(1:100,
       1:100,
       xlab = "sample x",
       type = "l",
       ylab = "sample y"
  )
  text(50, 50, "Click 'Start simulation' to run simulations and display results", cex = 1.2, pos = 3, col = "red")
})






# plot when simulation finishes
observe({
  if (not.null(GLOBAL$lastsim))
  output$distPlot <- renderPlot({

    updateGraphStatus("Preparing plots...")


    if (not.null(GLOBAL$lastsim) & not.na(GLOBAL$start.sim)) {

      # get data based on selection
      datatoplot <- switch (input$graphtype,
        "Combined" = data01_all(),
        "Combined_group" = data02_group(),
        "Facet by ID" = GLOBAL$lastsim %>% mutate(byID = paste0("Group ",Group,": ", ID)),
        "Facet by Group" = data02_group(),
        "Facet by Dose" = GLOBAL$lastsim
      )

      # create a ggplot object
      rgplot <- ggplot(data = datatoplot, aes(x = time))+
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
        )+
        labs(
          x = input$labelx,
          y = input$labely
        )



      # plot needed metrics
      if(input$graphtype %in% c("Combined","Combined_group","Facet by Group")){
        #"Mean","Mean ± SD", "Mean ± SEM",
        if(input$graphtype2 %in% c("Mean","Mean ± SD", "Mean ± SEM"))
          rgplot <-  rgplot + geom_line(aes(y = IPRED_mean, color = Group))

        #"Median","Median ± 90% PI","Median ± 95% PI"
        if(input$graphtype2 %in% c("Median","Median ± 90% PI","Median ± 95% PI"))
          rgplot <-  rgplot + geom_line(aes(y = IPRED_med, color = Group))


        if(input$graphtype2 == "Mean ± SD")
          rgplot <-  rgplot + geom_ribbon(aes(ymin=IPRED_mean - sd, ymax= IPRED_mean  + sd, fill = Group), alpha = 0.3)
        if(input$graphtype2 == "Mean ± SEM")
          rgplot <-  rgplot + geom_ribbon(aes(ymin=IPRED_mean - sem, ymax= IPRED_mean  + sem, fill = Group), alpha = 0.3)

        if(input$graphtype2 == "Median ± 90% PI")
          rgplot <-  rgplot + geom_ribbon(aes(ymin=q05, ymax= q95, fill = Group), alpha = 0.3)

        if(input$graphtype2 == "Median ± 95% PI")
          rgplot <-  rgplot + geom_ribbon(aes(ymin=q025, ymax= q975, fill = Group), alpha = 0.3)

      }


      # Facets
      if (input$graphtype == "Facet by ID") {
        rgplot <- rgplot + aes(color = ID) + facet_wrap(byID ~ ., ncol = 3)
      }
      if (input$graphtype == "Facet by Group") {
        rgplot <- rgplot + facet_wrap(Group ~ ., ncol = 3)
      }
      if (input$graphtype == "Facet by Dose") {
        rgplot <- rgplot + facet_wrap(Dose ~ ., ncol = 3)
      }

      # Semi-log or linear
      if(input$loglinear == "Semi-Log")
        rgplot <-  rgplot + scale_y_log10()


      updateGraphStatus("Plots completed.")
      rgplot
    }
  })
})

