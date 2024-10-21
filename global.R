#########################################################################################
#########################################################################################
##
##  Document Path: global.R
##
##  R version: 4.2.0 (2022-04-22)
##
##  Program purpose: Global library loads and variables
##
#########################################################################################
#########################################################################################


# load libraries and print their versions

library(shiny)
library(shinyjs)
library(rhandsontable)
library(DT)
library(flextable)
library(nlme)
library(markdown)
library(card.pro)
library(dplyr)
library(ggplot2)
library(magrittr)
library(mrgsolve)
library(quickcode)
library(patchwork)

# clear console, set dir, load libs and load files
quickcode::clean(source = c(
  "utils.R"
))

# add all individual utils
for (ui_each in c(
  "includes/header",
  "includes/body",
  "includes/footer"
)) {
  this.path = ui_each
  source(file.path(ui_each,"libs.R"), local = T)
}



GLOBAL<- reactiveValues()
GLOBAL$lastsim <- NULL
GLOBAL$start.sim <- FALSE
seed.val <- 67772
