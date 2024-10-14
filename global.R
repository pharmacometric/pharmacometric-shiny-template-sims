#########################################################################################
#########################################################################################
##
##  Document Path: ~/ShinyApps/collective4/modules/template/global.R
##
##
##  Written by oobianom on 2024-09-16
##
##  R version 4.2.0 (2022-04-22)
##
#########################################################################################
##
##  Program purpose: Global library loads and variables
##
##
##
#########################################################################################
#########################################################################################


# clear console, set dir, load libs and load files
quickcode::clean(clearPkgs = TRUE, source = c(
  "utils.R"
))

# load libraries and print their versions
library(shiny)
library(shinyjs)
library(rhandsontable)
library(DT)
library(card.pro)
library(dplyr)
library(ggplot2)
library(magrittr)
library(mrgsolve)



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
