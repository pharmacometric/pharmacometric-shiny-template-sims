server <- function(input, output, session) {
  for (server_each in c(
    "includes/header",
    "includes/body",
    "includes/footer"
  )) {
    source.part(
      path = server_each,
      which = "server",
      input, output, session
    )
  }


}
