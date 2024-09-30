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
                 numericInput("samplingfrequency","Sampling frequency (hr)",100, width = "100%"),
                 actionButton("runsimbutton", "Start simulation", icon = icon("running"))
                 ),
        tabEntry("Parameters", "First tab")
      ),
      footer = textOutput("tracksimulations")
    ),
    card.pro(
      title = "Regimen setup",
      removebtn = FALSE,
      colorbtn = FALSE,
      expandbtn = FALSE,
      editbtn = TRUE,
      collapsed = TRUE,
      rhandsontable(regimenDT, width = "100%") %>%
        hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE),

      footer = "Legend: Group - treatment group, Dose - dose in mg, Frequency - dosing frequency as integer, Additional - number of additional doses, Route - route of administration, F1 - bioavilability for the group"
    )
  ),
  primePanel(
    card.pro(
      title = "Plot graph",
      header.bg = "yellow",
      xtra.header.content = textOutput("reportgraphstatus"),
      plotOutput("distPlot"),
      sidebar = div(
        textInput("labely", "Y-label", "Counts by Histogram"),
        sliderInput("bins",
                    "Number of bins:",
                    min = 1,
                    max = 50,
                    value = 30
        ),
        textInput("labely1", "Y-label", "Counts by Histogram"),
        textInput("labelx1", "X-label", "X laboratory"),
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
                 tableOutput('summaryrestbl')
        ),
        tabEntry("Raw result",
                 DTOutput('rawrestbl'))
      )
    )
  )
)
