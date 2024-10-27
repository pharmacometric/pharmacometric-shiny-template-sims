############################################################################
############################################################################
##  Document Path: includes/body/libs.R
##
##  Description: Data and additional functions for the body
##
##  R version 4.4.1 (2024-06-14 ucrt)
##
#############################################################################
#############################################################################



# initial data
set.seed(number(1))
regimenDT = data.frame(
  Group = rep(LETTERS[1:3],each = 2),
  Dose = sample(seq(10,500,50),6),
  Frequency = sample(1:5,6, replace = T),
  Additional = sample(0:4,6, replace = T),
  Route = rep(sample(c("IV","SC")),3),
  WT = 70,
  stringsAsFactors = FALSE
)
