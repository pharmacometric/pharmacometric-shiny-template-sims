#########################################################################################
#########################################################################################
##
##  Document Path: ~/ShinyApps/collective4/modules/oxycodone/sim/sim.R
##
##
##  Written by oobianom on 2024-09-18
##
##  R version 4.2.0 (2022-04-22)
##
#########################################################################################
#########################################################################################


mod <- mread("sim", project=file.path(this.path,"sim"))
modparms <- param(mod)
#mod <- update(mod, end = 120, delta = 4, param = list(CL = 19.1))

data(exidata)
data(extran1)

data1 = extran1 %>% mutate(WT = rnorm(n(), mean = 70, sd = 15))

out <- NULL

observeEvent(input$runsimbutton,{
  out <- mod %>% data_set(data1) %>% idata_set(exidata) %>%
  ev(amt=100,ii=24,addl=10) %>%
  mrgsim(obsonly=T, delta = 1, carry_out=c("WT","KOUT","IC50")) %>%
    as.data.frame() %>% mutate(ID = paste0("ID = ",ID))


output$distPlot <- renderPlot({
  if(not.null(out))
  ggplot(data = out) +
    geom_line(aes(x = time, y = IPRED, color = ID)) +
    facet_wrap(ID~., ncol = 3) + theme_bw() + po.nopanel0
})


})





# # New facet label names for dose variable
# dose.labs <- c("D0.5", "D1", "D2")
# names(dose.labs) <- c("0.5", "1", "2")
#
# # New facet label names for supp variable
# supp.labs <- c("Orange Juice", "Vitamin C")
# names(supp.labs) <- c("OJ", "VC")
#
# # Create the plot
# p + facet_grid(
#   dose ~ supp,
#   labeller = labeller(dose = dose.labs, supp = supp.labs)
# )
#
#

