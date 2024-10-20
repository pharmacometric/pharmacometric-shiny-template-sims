body.main <- moveable(
  card.pro(
    title = "Model Information", width = 12,
    header.bg = "blue",
    removebtn = FALSE,
    colorbtn = FALSE,
    expandbtn = FALSE,
    editbtn = FALSE,
    collapsed = TRUE,
    shadow = FALSE,
    includeMarkdown(file.path(this.path, "model_information.md"))
  ),
  primePanel(
    width = 4,
    card.pro(
      title = "Simulation setup",
      removebtn = FALSE,
      colorbtn = FALSE,
      expandbtn = FALSE,
      editbtn = TRUE,
      "This section allows initiation of the runs, edit of general parameters and monitoring of progress",
      tabs = list(
        tabEntry("Main",
                 numericInput("samplesize","Number of participants (per arm)",100, width = "100%"),
                 numericInput("enddoseat","Treatment duration (wks)",30, width = "100%"),
                 numericInput("samplingfrequency","Sampling frequency (hr)",1, width = "100%"),
                 numericInput("simulationseed","Simulation seed",1320, width = "100%"),
                 actionButton("runsimbutton", "Start simulation", icon = icon("running"))
                 ),
        tabEntry("Parameters", uiOutput("mrgsolveparms"))
      ),
      footer = textOutput("tracksimulations")
    ),
    card.pro(
      title = "Regimen setup",
      removebtn = FALSE,
      colorbtn = FALSE,
      expandbtn = FALSE,
      editbtn = TRUE,
      collapsed = FALSE,
      rHandsontableOutput("rhstable1"),
      # rhandsontable(regimenDT, width = "100%") %>%
      #   hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE),

      footer = "Legend: Group - treatment group, Dose - dose in mg, Frequency - dosing frequency as integer, Additional - number of additional doses, Route - route of administration, F1 - bioavilability for the group"
    )
  ),
  primePanel(
    card.pro(
      title = "Plot graph",
      header.bg = "yellow",
      xtra.header.content = textOutput("reportgraphstatus"),
      plotOutput("distPlot", height = 600),
      sidebar = div(
        tags$label("Graph settings"),
        selectInput("graphtype","Graph type",choices = c(
          "Combined","Facet by ID","Facet by Group","Facet by Dose"
        ), selected = "Combined"),
        conditionalPanel(
          condition = "input.graphtype == 'Combined' | input.graphtype == 'Facet by Group'",
        selectInput("graphtype2","Statistic",choices = c(
          "Mean","Mean ± SD", "Mean ± SEM","Median","Median ± 90% PI"
        ), selected = "Mean")),
        textInput("labely", "Y-label", "Predicted Concentration (μg/ml)"),
        textInput("labelx", "X-label", "Time after first dose (days)"),
        selectInput("graphfont","Font type",choices = c(
          "Times","Verdana","Arial","Courier","Comic Sans MS"
        ), selected = "Arial"),
        sliderInput("fontxytitle",
                    "Font-size title",
                    min = 1,
                    max = 50,
                    value = 14
        ),
        sliderInput("fontxyticks",
                    "Font-size ticks",
                    min = 1,
                    max = 50,
                    value = 12
        ),
        sliderInput("fontxystrip",
                    "Font-size strip",
                    min = 1,
                    max = 50,
                    value = 12
        ),
        textInput("labely1", "W-label", "Counts by Histogram"),
        textInput("labelx1", "Q-label", "X laboratory"),
        textInput("labely1", "V-label", "Counts by Histogram"),
        textInput("labelx1", "Z-label", "X laboratory")
      )
    ),
    card.pro(
      title = "Tables",
      editbtn = TRUE,
      tabs = list(
        tabEntry("Summary",
                 DTOutput('summaryrestbl')
        ),
        tabEntry("Raw result",
                 DTOutput('rawrestbl'))
      )
    )
  )
)
