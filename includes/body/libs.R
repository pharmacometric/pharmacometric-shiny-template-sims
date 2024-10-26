regimenDT = data.frame(
  Group = rep(LETTERS[1:3],each = 2),
  Dose = rep(sample(c(50,10,100,200),2),3),
  Frequency = rep(sample(1:3,2),3),
  Additional = 3,
  Route = rep(sample(c("IV","SC")),3),
  WT = 70,
  stringsAsFactors = FALSE
)
