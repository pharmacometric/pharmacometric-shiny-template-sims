header.main <- titlePanel(tags$div(
  tags$img(src="logo.jpg")," ",
  "Simulation of XYZ Profiles Based on ABC Model",
  tags$div(class = "hidden-mobile hidden-tablet pull-right",
             actionButton("aboutproject", "", icon = icon("question")))
), windowTitle = "Simulation based on ABC Model")
