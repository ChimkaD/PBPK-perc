#---------------------------------- Dosimetry strain-specific model---------------------------------------------------
#* Packages----------------
install.packages("ggExtra")
# install.packages("ggstance")
library(reshape2)
library(ggridges)
library(ggplot2)
library(scales)
library(ggExtra)
library(EnvStats)
library(plyr)
library(tidyverse)
library(data.table)
library(rstan)
library(bayesplot)
library(ggpubr)
library(ggrepel)
library(cowplot)
library(gridExtra)
library(pksensi)
library(bayestestR)
library(grid)
#*-------------------------------------------------------------------------------------------------*---------------------
#---------------------------------* Set drive------------------------------------------------------
#******************************************************************************************
###                   1. AUC                            ####
#******************************************************************************************
#*-------------------------------------------------------------------------------------------------*---------------------
#--------1.1.~ CC-45 ----------
#*-------------------------------------------------------------------------------------------------*---------------------
#1.1.1. -------------------------------------------------------------------------------------------------*---------------------
#MCSim.R modeling-------------------------------
source("MCSim/function.R")
#* Make and call model-------------------------------
makemod()
model <- "perc.48strains.model.R"
makemcsim(model)
#1.1.2.-------------------------------------------------------------------------------------------------*---------------------
#-------------------------------------* Create for loop for 100 AUC Setpoints--------------------------------------
#* for 1000 mg
AUC.in <- read.delim("modeling/perc.mouse.48strains.43p.AUC.set.in.R", header = FALSE) #, quote = ""
head(AUC.in)
for(i in 1:100){
  AUC.in[5,] <-paste0('"perc.mouse.48strains.43p.random.',i,'.AUC.set.out"', sep = ",")
  as.character(AUC.in[5,])
  AUC.in[6,] <-paste0('"perc.mouse.48strains.43p.random',i,'.500.out"', sep = ",")
  write.table(AUC.in,file= paste0("modeling/perc.mouse.48strains.43p.AUC.set.",i,".in.R"), 
              quote = F, sep = "\t", col.names = F, row.names = F)
  system(paste0("./mcsim.perc.48strains.model.R.exe  modeling/perc.mouse.48strains.43p.AUC.set.",i,".in.R"))
}
#* for 10 mg------------
AUC.in <- read.delim("modeling/perc.mouse.48strains.43p.AUC.set.in.R", header = FALSE) #, quote = ""
head(Met.in) 
for(i in 1:100){
  AUC.in[5,] <-paste0('"perc.mouse.48strains.43p.random.100mg.',i,'.AUC.set.out"', sep = ",")
  as.character(AUC.in[5,])
  AUC.in[6,] <-paste0('"perc.mouse.48strains.43p.random',i,'.500.out"', sep = ",")
  write.table(AUC.in,file= paste0("modeling/perc.mouse.48strains.43p.AUC.set.100mg.",i,".in.R"), 
              quote = F, sep = "\t", col.names = F, row.names = F)
  system(paste0("./mcsim.perc.48strains.model.R.exe  modeling/perc.mouse.48strains.43p.AUC.set.100mg.",i,".in.R"))
}
# mcsim("perc.48strains.model.R", "perc.mouse.48strains.43p.AUC.set.in.R")
#1.1.3.-------------------------------------------------------------------------------------------------*---------------------
#------------------------------AUC Setpoint results------------------------------------
#------------------------------* Get the file list with------------------------------------
temp = list.files(pattern="100mg.*.AUC.set.out")
#---------------------------------* Read them all in-------------------
myfiles = lapply(temp, read.delim) #, fread
#----------------------------------* Create for loop for repeating functions--------------------------------------------------
#* Add Number column to each of 100 files of AUC.out -------------------------
for (i in 1:length(myfiles)[[1]]) {
  myfiles[[i]]$N <- seq(myfiles)[i]
}
#-------------------------------------* Rbind them into a data frame--------------------------------------
data.all <- do.call("rbind", myfiles)
names(data.all)
#-------------------------------------* Select AUC outputs --------------------
output <- data.all[,c(1,132:148)]
names(output)
output.melt <- melt(output, id = c("Iter","N"))
class(output.melt$variable)
output.melt$variable <-as.character(levels(output.melt$variable))[output.melt$variable]
output.melt[1:3,]
#---------------* Split the column 2 in to 3 columns##-----------------
output.split <- data.frame(output.melt$Iter, output.melt$N, output.melt$value, 
                           do.call("rbind",strsplit(output.melt$variable, "_")))
# names(output.split)
output.split$X2 <- NULL
# output.split[1:3,]
colnames(output.split) <- c("iter" ,"N","value", "variable")
output.split[1:3,]
#---------------* Add variables of chemical & tissue-----------------
output.split$chemical[output.split$variable == "AUCCBld"] <- "Perc"
output.split$chemical[output.split$variable == "AUCCLiv"] <- "Perc"
output.split$chemical[output.split$variable == "AUCCKid"] <- "Perc"
output.split$chemical[output.split$variable == "AUCCPlasTCA"] <- "TCAfree"
output.split$chemical[output.split$variable == "AUCCPlasTCAFree"] <- "TCA"
output.split$chemical[output.split$variable == "AUCCLivTCA"] <- "TCA"
output.split$chemical[output.split$variable == "AUCCKidTCA"] <- "TCA"
output.split$chemical[output.split$variable == "AUCCBldTCVG"] <- "TCVG"
output.split$chemical[output.split$variable == "AUCCLivTCVG"] <- "TCVG"
output.split$chemical[output.split$variable  == "AUCCKidTCVG"] <- "TCVG"
output.split$chemical[output.split$variable  == "AUCCBldTCVC"] <- "TCVC"
output.split$chemical[output.split$variable == "AUCCLivTCVC"] <- "TCVC"
output.split$chemical[output.split$variable == "AUCCKidTCVC"] <- "TCVC"
output.split$chemical[output.split$variable == "AUCCBldNAT"] <- "NAcTCVC"
output.split$chemical[output.split$variable == "AUCCLivNAT"] <- "NAcTCVC"
output.split$chemical[output.split$variable == "AUCCKidNAT"] <- "NAcTCVC"

output.split$tissue[output.split$variable == "AUCCBld"] <- "blood"
output.split$tissue[output.split$variable == "AUCCLiv"] <- "liver"
output.split$tissue[output.split$variable == "AUCCKid"] <- "kidney"
output.split$tissue[output.split$variable == "AUCCPlasTCA"] <- "blood"
output.split$tissue[output.split$variable == "AUCCPlasTCAFree"] <- "blood"
output.split$tissue[output.split$variable == "AUCCLivTCA"] <- "liver"
output.split$tissue[output.split$variable == "AUCCKidTCA"] <- "kidney"
output.split$tissue[output.split$variable == "AUCCBldTCVG"] <- "blood"
output.split$tissue[output.split$variable == "AUCCLivTCVG"] <- "liver"
output.split$tissue[output.split$variable == "AUCCKidTCVG"] <- "kidney"
output.split$tissue[output.split$variable == "AUCCBldTCVC"] <- "blood"
output.split$tissue[output.split$variable == "AUCCLivTCVC"] <- "liver"
output.split$tissue[output.split$variable == "AUCCKidTCVC"] <- "kidney"
output.split$tissue[output.split$variable == "AUCCBldNAT"] <- "blood"
output.split$tissue[output.split$variable == "AUCCLivNAT"] <- "liver"
output.split$tissue[output.split$variable == "AUCCKidNAT"] <- "kidney"
#---------------* Convert unit to Molar-----------------
# output.split$molar[output.split$chemical == "Perc"] <- output.split$value[output.split$chemical == "Perc"] / 165.83 * 1000
# output.split$molar[output.split$chemical == "TCA"] <- output.split$value[output.split$chemical == "TCA"] / 163.39 * 1000
# output.split$molar[output.split$chemical == "TCAfree"] <- output.split$value[output.split$chemical == "TCAfree"] / 163.39 * 1000
# output.split$molar[output.split$chemical == "TCVG"] <- output.split$value[output.split$chemical == "TCVG"] / 436.68 * 1000
# output.split$molar[output.split$chemical == "TCVC"] <- output.split$value[output.split$chemical == "TCVC"] / 250.53 * 1000
# output.split$molar[output.split$chemical == "NAcTCVC"] <- output.split$value[output.split$chemical == "NAcTCVC"] / 292.57 * 1000
#* Reorder variables for Plotting the Density of AUCs---------------------------------------
# output.split$tissue <- factor(output.split$tissue, levels = c("blood","liver","kidney"), ordered=TRUE) 
# output.split$chemical <- factor(output.split$chemical, levels = c("Perc","TCA","TCAfree","TCVG","TCVC","NAcTCVC"), ordered=TRUE)
# head(output.split)
#1.1.4.---------------------------*----------------------------------------------------------------------
#----------------------------------- Summary of AUC ***--------------------------------------------
#-----------------------------------* Variability - 500 ***--------------------------------------------
# AUC.100 = ddply(output.split, .(N,chemical,tissue), function(output.split){
#   c(GM=geoMean(output.split$molar, na.rm = TRUE),
#     GSD=geoSD(output.split$molar, na.rm = TRUE),
#     median=median(output.split$molar, na.rm = TRUE),
#     low = quantile(output.split$molar, 0.01, na.rm = TRUE),
#     low = quantile(output.split$molar, 0.025, na.rm = TRUE),
#     low = quantile(output.split$molar, 0.05, na.rm = TRUE),
#     up = quantile(output.split$molar, 0.95, na.rm = TRUE),
#     up = quantile(output.split$molar, 0.975, na.rm = TRUE),
#     up = quantile(output.split$molar, 0.99, na.rm = TRUE))
# })
AUC.100 = ddply(output.split, .(N,chemical,tissue), function(output.split){
  c(GM=geoMean(output.split$value, na.rm = TRUE),
    GSD=geoSD(output.split$value, na.rm = TRUE),
    median=median(output.split$value, na.rm = TRUE),
    low = quantile(output.split$value, 0.01, na.rm = TRUE),
    low = quantile(output.split$value, 0.025, na.rm = TRUE),
    low = quantile(output.split$value, 0.05, na.rm = TRUE),
    up = quantile(output.split$value, 0.95, na.rm = TRUE),
    up = quantile(output.split$value, 0.975, na.rm = TRUE),
    up = quantile(output.split$value, 0.99, na.rm = TRUE))
})
#* Rename variables------------------------
colnames(AUC.100) <- c("N","chemical","tissue","GM","GSD","median","low001","low0025","low005","up095", "up0975", "up099")
# ------------------------* Compute TKVF ---------------------------------------
AUC.100$TKVF95 <- AUC.100$up095 / AUC.100$median
AUC.100$TKVF99 <- AUC.100$up099 / AUC.100$median
# ------------------------* Uncertainty-100-------------
# ------------------------** P1-------------
AUC.sum = ddply(AUC.100, .(chemical,tissue), function(AUC.100){
  c(GM.m=median(AUC.100$GM, na.rm = TRUE),
    GM.low =quantile(AUC.100$GM, 0.025, na.rm = TRUE),
    GM.up = quantile(AUC.100$GM, 0.975, na.rm = TRUE),
    GSD.m=median(AUC.100$GSD, na.rm = TRUE),
    GSD.low =quantile(AUC.100$GSD, 0.025, na.rm = TRUE),
    GSD.up = quantile(AUC.100$GSD, 0.975, na.rm = TRUE),
    med.m=median(AUC.100$median), 
    med.low = quantile(AUC.100$median, 0.025),
    med.up = quantile(AUC.100$median, 0.975),
    low001.m=median(AUC.100$low001),
    low001.low = quantile(AUC.100$low001, 0.025),
    low001.up = quantile(AUC.100$low001, 0.975),
    low0025.m=median(AUC.100$low0025),
    low0025.low = quantile(AUC.100$low0025, 0.025),
    low0025.up = quantile(AUC.100$low0025, 0.975),
    low005.m = median(AUC.100$low005),
    low005.low = quantile(AUC.100$low005, 0.025),
    low005.up = quantile(AUC.100$low005, 0.975),
    up095.m = median(AUC.100$up095),
    up095.low = quantile(AUC.100$up095, 0.025),
    up095.up = quantile(AUC.100$up095, 0.975),
    up0975.m = median(AUC.100$up0975),
    up0975.low = quantile(AUC.100$up0975, 0.025),
    up0975.up = quantile(AUC.100$up0975, 0.975),
    up099.m=median(AUC.100$up099), 
    up099.low = quantile(AUC.100$up099, 0.025),
    up99.up = quantile(AUC.100$up099, 0.975),
    TKVF95.m=median(AUC.100$TKVF95), 
    TKVF95.low = quantile(AUC.100$TKVF95, 0.025),
    TKVF95.up = quantile(AUC.100$TKVF95, 0.975),
    TKVF99.m=median(AUC.100$TKVF99), 
    TKVF99.low = quantile(AUC.100$TKVF99, 0.025),
    TKVF99.up = quantile(AUC.100$TKVF99, 0.975))
})
colnames(AUC.sum) <- c("chemical","tissue","GM.m","GM.low","GM.up","GSD.m","GSD.low","GSD.up",
                       "med.m", "med.low","med.up","low01.m","low01.low","low01.up",
                       "low025.m","low025.low","low025.up","low05.m","low05.low","low05.up",
                       "up95.m", "up95.low","up95.up","up975.m", "up975.low","up975.up",
                       "up99.m","up99.low","up99.up","TKVF95.m","TKVF95.low","TKVF95.up",
                       "TKVF99.m","TKVF99.low","TKVF99.up")
AUC.sum$tissue <- factor(AUC.sum$tissue, levels = c("kidney","liver","blood"), ordered=TRUE) 
AUC.sum$chemical <- factor(AUC.sum$chemical, levels = c("TCAfree","Perc","TCA","TCVG","TCVC","NAcTCVC"), ordered=TRUE)
head(AUC.sum)
names(AUC.sum)
#* Write Summary of AUC file  -----------------------------
write.csv(AUC.sum, file = "AUC.sum.100mg.csv")
# AUC.sum2 <- subset(AUC.sum, chemical != "TCA" | tissue != "blood")
# AUC.sum2$chemical[AUC.sum2$chemical == "TCAfree"] <- "TCA"
#1.1.5. -------------------------------------------------------------------------------------------------*---------------------
#--------* Create Table----------
AUC.sum = read.csv("AUC.sum.100mg.csv")
tail(AUC.sum)
#** GM-----------------
AUC.sum$GM.low <- paste("(",format(AUC.sum$GM.low, digits = 3,scientific = TRUE),sep = "",collapse = NULL)
AUC.sum$GM.up <- paste(format(AUC.sum$GM.up, digits = 3, scientific = TRUE), ")",sep = "",collapse = NULL)
AUC.sum$CI1 <- paste(AUC.sum$GM.low,AUC.sum$GM.up, sep =", ")
AUC.sum$GM <- paste(format(AUC.sum$GM.m, digits = 3, scientific = TRUE), AUC.sum$CI1)
AUC.sum1 <- subset(AUC.sum, select = c(chemical, tissue, GM))
#** GSD-----------------
AUC.sum$GSD.low <- paste("(",format(AUC.sum$GSD.low, digits = 2),sep = "",collapse = NULL)
AUC.sum$GSD.up <- paste(format(AUC.sum$GSD.up, digits = 2), ")",sep = "",collapse = NULL)
AUC.sum$CI <- paste(AUC.sum$GSD.low,AUC.sum$GSD.up, sep =", ")
AUC.sum1$GSD <- paste(format(AUC.sum$GSD.m, digits = 2), AUC.sum$CI)
#** P50-----------------
AUC.sum$med.low <- paste("(",format(AUC.sum$med.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
AUC.sum$med.up <- paste0(format(AUC.sum$med.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
AUC.sum$CI <- paste(AUC.sum$med.low,AUC.sum$med.up, sep =", ")
AUC.sum1$P50 <- paste(format(AUC.sum$med.m, digits = 2, scientific = TRUE), AUC.sum$CI)
#** P1-----------------
AUC.sum$low01.low <- paste("(",format(AUC.sum$low01.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
AUC.sum$low01.up <- paste0(format(AUC.sum$low01.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
AUC.sum$CI <- paste(AUC.sum$low01.low,AUC.sum$low01.up, sep =", ")
AUC.sum1$P1 <- paste(format(AUC.sum$low01.m, digits = 2, scientific = TRUE), AUC.sum$CI)
#** P2.5-----------------
AUC.sum$low025.low <- paste("(",format(AUC.sum$low025.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
AUC.sum$low025.up <- paste0(format(AUC.sum$low025.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
AUC.sum$CI <- paste(AUC.sum$low025.low,AUC.sum$low025.up, sep =", ")
AUC.sum1$P2.5 <- paste(format(AUC.sum$low025.m, digits = 2, scientific = TRUE), AUC.sum$CI)
#** P5-----------------
AUC.sum$low05.low <- paste("(",format(AUC.sum$low05.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
AUC.sum$low05.up <- paste0(format(AUC.sum$low05.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
AUC.sum$CI <- paste(AUC.sum$low05.low,AUC.sum$low05.up, sep =", ")
AUC.sum1$P5 <- paste(format(AUC.sum$low05.m, digits = 2, scientific = TRUE), AUC.sum$CI)
#** P95-----------------
AUC.sum$up95.low <- paste("(",format(AUC.sum$up95.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
AUC.sum$up95.up <- paste0(format(AUC.sum$up95.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
AUC.sum$CI <- paste(AUC.sum$up95.low,AUC.sum$up95.up, sep =", ")
AUC.sum1$P95 <- paste(format(AUC.sum$up95.m, digits = 2, scientific = TRUE), AUC.sum$CI)
#** P97.5-----------------
AUC.sum$up975.low <- paste("(",format(AUC.sum$up975.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
AUC.sum$up975.up <- paste0(format(AUC.sum$up975.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
AUC.sum$CI <- paste(AUC.sum$up975.low,AUC.sum$up975.up, sep =", ")
AUC.sum1$P97.5 <- paste(format(AUC.sum$up975.m, digits = 2, scientific = TRUE), AUC.sum$CI)

AUC.sum$up99.low <- paste("(",format(AUC.sum$up99.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
AUC.sum$up99.up <- paste0(format(AUC.sum$up99.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
AUC.sum$CI <- paste(AUC.sum$up99.low,AUC.sum$up99.up, sep =", ")
AUC.sum1$P99 <- paste(format(AUC.sum$up99.m, digits = 2, scientific = TRUE), AUC.sum$CI)

AUC.sum$TKVF95.low <- paste("(",format(AUC.sum$TKVF95.low, digits = 2),sep = "",collapse = NULL)
AUC.sum$TKVF95.up <- paste0(format(AUC.sum$TKVF95.up, digits = 2), ")",sep = "",collapse = NULL)
AUC.sum$CI <- paste(AUC.sum$TKVF95.low,AUC.sum$TKVF95.up, sep =", ")
AUC.sum1$TKVF95 <- paste(format(AUC.sum$TKVF95.m, digits = 2), AUC.sum$CI)

AUC.sum$TKVF99.low <- paste("(",format(AUC.sum$TKVF99.low, digits = 2),sep = "",collapse = NULL)
AUC.sum$TKVF99.up <- paste0(format(AUC.sum$TKVF99.up, digits = 2), ")",sep = "",collapse = NULL)
AUC.sum$CI <- paste(AUC.sum$TKVF99.low,AUC.sum$TKVF99.up, sep =", ")
AUC.sum1$TKVF99 <- paste(format(AUC.sum$TKVF99.m, digits = 2), AUC.sum$CI)
head(AUC.sum1)

write.table(format(AUC.sum1, digits = 3), file = "AUC.sum100.txt", row.names = FALSE, col.names = TRUE, sep="\t")

#*-------------------------------------------------------------------------------------------------*---------------------
#*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~------------------
#--------2. Metabolism ----------
#*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~------------------
#*-------------------------------------------------------------------------------------------------*---------------------
#--------2.1. ~ CC-45 ----------
#* from labtop Thinkpad-----------------
#* for Metabolism MCSim run------------------------------
setwd("~")
#2.1.1. -------------------------------------------------------------------------------------------------*---------------------
#MCSim modeling-------------------------------
source("MCSim/function.R")
#* Make and call model-------------------------------
makemod()
model <- "perc.48strains.model.R"
makemcsim(model)
#2.1.2.-------------------------------------------------------------------------------------------------*---------------------
#-------------------------------------* Create for loop for 100 Met Setpoints --------------------------------------
Met.in <- read.delim("modeling/perc.mouse.48strains.43p.met.set.in.R", header = FALSE) #, quote = ""
head(Met.in) 
for(i in 1:100){
  Met.in[5,] <-paste0('"perc.mouse.48strains.43p.random.100mg.',i,'.met.set.out"', sep = ",")
  as.character(Met.in[5,])
  Met.in[6,] <-paste0('"perc.mouse.48strains.43p.random',i,'.500.out"', sep = ",")
  write.table(Met.in,file= paste0("modeling/perc.mouse.48strains.43p.met.set.100mg.",i,".in.R"), 
              quote = F, sep = "\t", col.names = F, row.names = F)
  system(paste0("./mcsim.perc.48strains.model.R.exe  modeling/perc.mouse.48strains.43p.met.set.100mg.",i,".in.R"))
}
#2.1.3.-------------------------------------------------------------------------------------------------*---------------------
#------------------------------Metabolism Setpoint results------------------------------------
#------------------------------* Get the file list with------------------------------------
temp = list.files(pattern="10mg.*.met.set.out")
temp = list.files(pattern="100mg.*.met.set.out")
#---------------------------------* Read them all in-------------------
myfiles = lapply(temp, read.delim) 
#----------------------------------* Create for loop for repeating functions--------------------------------------------------
#* Add Number column to each of 100 files of Met.out -------------------------
for (i in 1:length(myfiles)[[1]]) {
  myfiles[[i]]$N <- seq(myfiles)[i]
}
#-------------------------------------* Rbind them into a data frame--------------------------------------
data.all <- do.call("rbind", myfiles)
names(data.all)
#-------------------------------* Select Metabolism outputs --------------------------------------
output <- data.all[,c(1,c(132:141))]
#* Compute Perc excreted-------------------
output$Perc.excreted <- output$TotDoseBW34_1.1 - output$TotTissueBW34_1.1 - output$TotMetabBW34_1.1
names(output)
output.melt <- melt(output, id = c("Iter","N"))
output.melt[1:3,]
tail(output.melt)
class(output.melt$variable)
output.melt$variable <-as.character(levels(output.melt$variable))[output.melt$variable]
output.melt[1:3,]
#* split the column 2 in to 3 columns---------------------------------------------------
output.met <- data.frame(output.melt$Iter, output.melt$N, output.melt$value, 
                         do.call("rbind",strsplit(output.melt$variable, "_")))
output.met$X2 <- NULL
output.met[1:3,]
colnames(output.met) <- c("iter" ,"N","value", "variable")
tail(output.met)

#* Rename rows of chemical---------------------------------------------------
output.met$chemical[output.met$variable == "TotDoseBW34"] <- "Absorbed oral dose"
output.met$chemical[output.met$variable == "TotTissueBW34"] <- "Unchanged perc in tissue"
output.met$chemical[output.met$variable == "TotMetabBW34"] <- "Perc metabolized"
output.met$chemical[output.met$variable == "Perc.excreted"] <- "Perc excreted"
output.met$chemical[output.met$variable == "TotOxMetabBW34"] <- "Total oxidation"
output.met$chemical[output.met$variable == "AMetLiv1BW34"] <- "Oxidation in liver"
output.met$chemical[output.met$variable == "TotTCAInBW34"] <- "Total TCA produced"
output.met$chemical[output.met$variable == "AMetGSHBW34"] <- "Total GSH conjugation"
output.met$chemical[output.met$variable == "AMetLiv2BW34"] <- "TCVG produced in liver"
output.met$chemical[output.met$variable == "AMetKid2BW34"] <- "TCVG produced in kidney"
output.met$chemical[output.met$variable == "AMetKidTCVCBW34"] <- "TCVC produced in kidney"
#* Order chemical---------------------------------------------------
output.met$chemical <- factor(output.met$chemical, 
                              levels = c("Absorbed oral dose","Unchanged perc in tissue","Perc metabolized",
                                         "Perc excreted","Total oxidation","Oxidation in liver","Total TCA produced",
                                         "Total GSH conjugation","TCVG produced in liver","TCVG produced in kidney",
                                         "TCVC produced in kidney"), 
                              ordered=TRUE)
#-------------------------------* Summarize Metabolism--------------------------------------------
# #-------------------------------** Uncertainty Med, 95%CI--------------------------------------------/
# Met.500 = ddply(output.met, .(iter,chemical), function(output.met){
#   c(
#     median=median(output.met$value, na.rm = TRUE),
#     low = quantile(output.met$value, 0.025, na.rm = TRUE),
#     up = quantile(output.met$value, 0.975, na.rm = TRUE))
# })
# tail(Met.500)
# colnames(Met.500) <- c("iter","chemical","median","low025","up975")
# #-------------------------------** Variability GM,GSD,Med,95th,99th--------------------------------------------/
# Met.100 = ddply(Met.500, .(chemical), function(Met.500){
#   c(GM=geoMean(Met.500$median, na.rm = TRUE),
#     GSD=geoSD(Met.500$median, na.rm = TRUE),
#     median=median(Met.500$median, na.rm = TRUE),
#     low = quantile(Met.500$median, 0.01, na.rm = TRUE),
#     # low = quantile(Met.500$median, 0.025, na.rm = TRUE),
#     low = quantile(Met.500$median, 0.05, na.rm = TRUE),
#     up = quantile(Met.500$median, 0.95, na.rm = TRUE),
#     # up = quantile(Met.500$median, 0.975, na.rm = TRUE),
#     up = quantile(Met.500$median, 0.99, na.rm = TRUE))
# })
# head(Met.100)
#-------------------------------** Variability GM,GSD,Med,95th,99th--------------------------------------------
Met.100 = ddply(output.met, .(N,chemical), function(output.met){
  c(GM=geoMean(output.met$value, na.rm = TRUE),
    GSD=geoSD(output.met$value, na.rm = TRUE),
    median=median(output.met$value, na.rm = TRUE),
    low = quantile(output.met$value, 0.01, na.rm = TRUE),
    low = quantile(output.met$value, 0.025, na.rm = TRUE),
    low = quantile(output.met$value, 0.05, na.rm = TRUE),
    up = quantile(output.met$value, 0.95, na.rm = TRUE),
    up = quantile(output.met$value, 0.975, na.rm = TRUE),
    up = quantile(output.met$value, 0.99, na.rm = TRUE))
})
# head(Met.100)
colnames(Met.100) <- c("N","chemical","GM","GSD","median","low01","low025","low05","up95","up975","up99")
#-------------------------* Compute Toxicokinetic variability factor--------------------
Met.100$TKVF95 <- Met.100$up95 / Met.100$median
Met.100$TKVF99 <- Met.100$up99 / Met.100$median
#2.1.4.-------------------------------------------------------------------------------------------------*---------------------
#------------------------* Summarize TKVF--------------------------------
#-------------------------------** Uncertainty Med, 95%CI--------------------------------------------
Met.sum = ddply(Met.100, .(chemical), function(Met.100){
  c(GM.m=median(Met.100$GM, na.rm = TRUE),
    GM.low =quantile(Met.100$GM, 0.025, na.rm = TRUE),
    GM.up = quantile(Met.100$GM, 0.975, na.rm = TRUE),
    GSD.m=median(Met.100$GSD, na.rm = TRUE),
    GSD.low =quantile(Met.100$GSD, 0.025, na.rm = TRUE),
    GSD.up = quantile(Met.100$GSD, 0.975, na.rm = TRUE),
    med.m=median(Met.100$median), 
    med.low = quantile(Met.100$median, 0.025),
    med.up = quantile(Met.100$median, 0.975),
    low01.m=median(Met.100$low01),
    low01.low = quantile(Met.100$low01, 0.025),
    low01.up = quantile(Met.100$low01, 0.975),
    low025.m=median(Met.100$low025),
    low025.low = quantile(Met.100$low025, 0.025),
    low025.up = quantile(Met.100$low025, 0.975),
    low05.m = median(Met.100$low05),
    low05.low = quantile(Met.100$low05, 0.025),
    low05.up = quantile(Met.100$low05, 0.975),
    up95.m = median(Met.100$up95),
    up95.low = quantile(Met.100$up95, 0.025),
    up95.up = quantile(Met.100$up95, 0.975),
    up975.m = median(Met.100$up975),
    up975.low = quantile(Met.100$up975, 0.025),
    up975.up = quantile(Met.100$up975, 0.975),
    up99.m=median(Met.100$up99), 
    up99.low = quantile(Met.100$up99, 0.025),
    up99.up = quantile(Met.100$up99, 0.975),
    TKVF95.m=median(Met.100$TKVF95), 
    TKVF95.low = quantile(Met.100$TKVF95, 0.025),
    TKVF95.up = quantile(Met.100$TKVF95, 0.975),
    TKVF99.m=median(Met.100$TKVF99), 
    TKVF99.low = quantile(Met.100$TKVF99, 0.025),
    TKVF99.up = quantile(Met.100$TKVF99, 0.975))
})
colnames(Met.sum) <- c("chemical","GM.m","GM.low","GM.up","GSD.m","GSD.low","GSD.up",
                       "med.m", "med.low","med.up","low01.m","low01.low","low01.up",
                       "low025.m","low025.low","low025.up","low05.m","low05.low","low05.up",
                       "up95.m", "up95.low","up95.up","up975.m", "up975.low","up975.up",
                       "up99.m","up99.low","up99.up","TKVF95.m","TKVF95.low","TKVF95.up",
                       "TKVF99.m","TKVF99.low","TKVF99.up")
head(Met.sum)
#* Write Summary of Perc disposition file  -----------------------------
write.csv(Met.sum, file = "Met.sum.100mg.csv")
#* Call TKVF.Met.csv-----------------------------
Met.sum = read.csv("Met.sum.100mg.csv")
names(Met.sum)
#2.1.5.-------------------------------------------------------------------------------------------------*---------------------
#--------* Create Table----------
Met.sum$GM.low <- paste("(",format(Met.sum$GM.low, digits = 3,scientific = TRUE),sep = "",collapse = NULL)
Met.sum$GM.up <- paste(format(Met.sum$GM.up, digits = 3, scientific = TRUE), ")",sep = "",collapse = NULL)
Met.sum$CI1 <- paste(Met.sum$GM.low,Met.sum$GM.up, sep =", ")
Met.sum$GM <- paste(format(Met.sum$GM.m, digits = 3, scientific = TRUE), Met.sum$CI1)
Met.sum1 <- subset(Met.sum, select = c(chemical, GM))

Met.sum$GSD.low <- paste("(",format(Met.sum$GSD.low, digits = 2),sep = "",collapse = NULL)
Met.sum$GSD.up <- paste(format(Met.sum$GSD.up, digits = 2), ")",sep = "",collapse = NULL)
Met.sum$CI <- paste(Met.sum$GSD.low,Met.sum$GSD.up, sep =", ")
Met.sum1$GSD <- paste(format(Met.sum$GSD.m, digits = 2), Met.sum$CI)

Met.sum$med.low <- paste("(",format(Met.sum$med.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
Met.sum$med.up <- paste0(format(Met.sum$med.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
Met.sum$CI <- paste(Met.sum$med.low,Met.sum$med.up, sep =", ")
Met.sum1$P50 <- paste(format(Met.sum$med.m, digits = 2, scientific = TRUE), Met.sum$CI)

Met.sum$low01.low <- paste("(",format(Met.sum$low01.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
Met.sum$low01.up <- paste0(format(Met.sum$low01.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
Met.sum$CI <- paste(Met.sum$low01.low,Met.sum$low01.up, sep =", ")
Met.sum1$P1 <- paste(format(Met.sum$low01.m, digits = 2, scientific = TRUE), Met.sum$CI)

Met.sum$low025.low <- paste("(",format(Met.sum$low025.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
Met.sum$low025.up <- paste0(format(Met.sum$low025.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
Met.sum$CI <- paste(Met.sum$low025.low,Met.sum$low025.up, sep =", ")
Met.sum1$P2.5 <- paste(format(Met.sum$low025.m, digits = 2, scientific = TRUE), Met.sum$CI)

Met.sum$low05.low <- paste("(",format(Met.sum$low05.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
Met.sum$low05.up <- paste0(format(Met.sum$low05.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
Met.sum$CI <- paste(Met.sum$low05.low,Met.sum$low05.up, sep =", ")
Met.sum1$P5 <- paste(format(Met.sum$low05.m, digits = 2, scientific = TRUE), Met.sum$CI)

Met.sum$up95.low <- paste("(",format(Met.sum$up95.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
Met.sum$up95.up <- paste0(format(Met.sum$up95.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
Met.sum$CI <- paste(Met.sum$up95.low,Met.sum$up95.up, sep =", ")
Met.sum1$P95 <- paste(format(Met.sum$up95.m, digits = 2, scientific = TRUE), Met.sum$CI)

Met.sum$up975.low <- paste("(",format(Met.sum$up975.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
Met.sum$up975.up <- paste0(format(Met.sum$up975.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
Met.sum$CI <- paste(Met.sum$up975.low,Met.sum$up975.up, sep =", ")
Met.sum1$P97.5 <- paste(format(Met.sum$up975.m, digits = 2, scientific = TRUE), Met.sum$CI)

Met.sum$up99.low <- paste("(",format(Met.sum$up99.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
Met.sum$up99.up <- paste0(format(Met.sum$up99.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
Met.sum$CI <- paste(Met.sum$up99.low,Met.sum$up99.up, sep =", ")
Met.sum1$P99 <- paste(format(Met.sum$up99.m, digits = 2, scientific = TRUE), Met.sum$CI)

Met.sum$TKVF95.low <- paste("(",format(Met.sum$TKVF95.low, digits = 2),sep = "",collapse = NULL)
Met.sum$TKVF95.up <- paste0(format(Met.sum$TKVF95.up, digits = 2), ")",sep = "",collapse = NULL)
Met.sum$CI <- paste(Met.sum$TKVF95.low,Met.sum$TKVF95.up, sep =", ")
Met.sum1$TKVF95 <- paste(format(Met.sum$TKVF95.m, digits = 2), Met.sum$CI)

Met.sum$TKVF99.low <- paste("(",format(Met.sum$TKVF99.low, digits = 2),sep = "",collapse = NULL)
Met.sum$TKVF99.up <- paste0(format(Met.sum$TKVF99.up, digits = 2), ")",sep = "",collapse = NULL)
Met.sum$CI <- paste(Met.sum$TKVF99.low,Met.sum$TKVF99.up, sep =", ")
Met.sum1$TKVF99 <- paste(format(Met.sum$TKVF99.m, digits = 2), Met.sum$CI)
head(Met.sum1)
#* Write Summary of Perc disposition file  -----------------------------
# write.csv(format(Met.sum1), file = "Met.sum.mol.csv")
write.table(Met.sum1, file = "Met.sum100.txt", row.names = FALSE, col.names = TRUE, sep="\t")

#*-------------------------------------------------------------------------------------------------*---------------------
#--------2.2. ~ 3-diet ----------
#*-------------------------------------------------------------------------------------------------*---------------------
#---------------------------------* Set drive------------------------------------------------------
#** from laptop-----------------------------
out.B6 <- fread("perc.mouse.3strains.3diet.27p.s.met.set1000.B6.out")
out.SW <- fread("perc.mouse.3strains.3diet.27p.s.met.set1000.SW.out") 
out.LFD <- fread("perc.mouse.3strains.3diet.27p.s.met.set1000.LFD.out")  
out.HFD <- fread("perc.mouse.3strains.3diet.27p.s.met.set1000.HFD.out")
out.MCD <- fread("perc.mouse.3strains.3diet.27p.s.met.set1000.MCD.out")
names(out.B6)
#** select Metabolism-----------------------------
out.B6 <- out.B6[,c(1,107:114)]
out.SW <- out.SW[,c(1,107:114)]
out.LFD <- out.LFD[,c(1,107:114)]
out.HFD <- out.HFD[,c(1,107:114)]
out.MCD <- out.MCD[,c(1,107:114)]
#** Add strain-----------------------------
out.B6$strain <- "B6C3F1/J"
out.SW$strain <- "SW"
out.LFD$strain <- "C57BL/6J-LFD"
out.HFD$strain <- "C57BL/6J-HFD"
out.MCD$strain <- "C57BL/6J-MCD"
#--------------------* Combine 5 strains *----------------------------------------------
output <- rbind(out.B6,out.SW, out.LFD, out.HFD, out.MCD)
#--------------------* Compute Perc excreted--------------------------
output$Perc.excreted <- output$TotDoseBW34_1.1 - output$TotTissueBW34_1.1 - output$TotMetabBW34_1.1
names(output)
# *** Melt for population prediction ***
output.dat <- melt(output, id = c("Iter","strain"))
class(output.dat$variable)
output.dat$conc.time <-as.character(levels(output.dat$variable))[output.dat$variable]
#split the columns for population prediction
Met.out <- data.frame(output.dat$Iter, output.dat$strain,output.dat$value, 
                      do.call("rbind",strsplit(output.dat$conc.time, "_")))
Met.out[1:3,]
Met.out$X2<- NULL
colnames(Met.out) <- c("iter" , "strain", "conc", "name")
Met.out[1:3,]
Met.out$strain <- factor(Met.out$strain, levels = c("B6C3F1/J","SW",
                                                    "C57BL/6J-LFD","C57BL/6J-HFD",
                                                    "C57BL/6J-MCD"), ordered=TRUE) 
#* Rename rows of chemical---------------------------------------------------
Met.out$chemical[Met.out$name == "TotDoseBW34"] <- "Absorbed oral dose"
Met.out$chemical[Met.out$name == "TotTissueBW34"] <- "Unchanged perc in tissue"
Met.out$chemical[Met.out$name == "TotMetabBW34"] <- "Perc metabolized"
Met.out$chemical[Met.out$name == "Perc.excreted"] <- "Perc excreted"
Met.out$chemical[Met.out$name == "TotOxMetabBW34"] <- "Total oxidation"
Met.out$chemical[Met.out$name == "AMetLiv1BW34"] <- "Oxidation in liver"
Met.out$chemical[Met.out$name == "TotTCAInBW34"] <- "Total TCA produced"
Met.out$chemical[Met.out$name == "AMetGSHBW34"] <- "Total GSH conjugation"
Met.out$chemical[Met.out$name == "AMetKid2BW34"] <- "TCVG produced in kidney"
Met.out$chemical[Met.out$name == "AMetKidTCVCBW34"] <- "TCVC produced in kidney"
#* Order chemical---------------------------------------------------
Met.out$chemical <- factor(Met.out$chemical, 
                              levels = c("Absorbed oral dose","Unchanged perc in tissue","Perc metabolized",
                                         "Perc excreted","Total oxidation","Oxidation in liver","Total TCA produced",
                                         "Total GSH conjugation","TCVG produced in kidney","TCVC produced in kidney"), 
                              ordered=TRUE)
#------------------------* Summarize Met.out-------------
Met.var = ddply(Met.out, .(strain, chemical), function(Met.out){ #
  c(median=median(Met.out$conc, na.rm = TRUE),
    low = quantile(Met.out$conc, 0.025, na.rm = TRUE),
    up = quantile(Met.out$conc, 0.975, na.rm = TRUE))
})
head(Met.var)
#** Rename variables------------------------
colnames(Met.var) <- c("strain","chemical","median","low025","up975")
# ------------------------* Compute TKVF ---------------------------------------
Met.var$TKVF95 <- Met.var$up095 / Met.var$median
Met.var$TKVF99 <- Met.var$up099 / Met.var$median
names(Met.var)
#* Write Summary of Perc disposition file  -----------------------------
write.csv(Met.var, file = "Met.strain1025.mg.csv")
#*-------------------------------------------------------------------------------------------------*---------------------
#* Call 3-diet Met.sum-----------------------------
Met.var = read.csv("Met.strain.mg.csv")
names(Met.var)
#*-------------------------------------------------------------------------------------------------*---------------------
#--------2.3. Met CC45+3diet Combined Plot  ----------
#* Call Met.sum.1029.csv-----------------------------
Met.sum = read.csv("Met.sum.1029.csv")
# Met.sum$strains <- factor(Met.sum$strains, levels = c("Population mean","Population distribution",
#                                                     "B6C3F1/J", "SW", "C57BL/6J-LFD", "C57BL/6J-HFD",
#                                                     "C57BL/6J-MCD"), ordered=TRUE)
#--------* Order rows----------
Met.sum$chemical <- factor(Met.sum$chemical,
                           levels = c("Absorbed oral dose","Unchanged perc in tissue","Perc metabolized",
                                      "Perc excreted","Total oxidation","Total TCA produced", #"Oxidation in liver",
                                      "Total GSH conjugation","TCVG produced in kidney","TCVC produced in kidney"),
                           ordered=TRUE)
Met.sum.sub <- subset(Met.sum, chemical == "Perc excreted" | chemical == "Total TCA produced" | chemical == "Total GSH conjugation")
Met.sum.sub$strains <- factor(Met.sum.sub$strains, levels = c("C57BL/6J-NASH","C57BL/6J-NAFL",
                                                    "C57BL/6J", "SW",  "B6C3F1/J",
                                                    "Population distribution","Population mean"), ordered=TRUE)
Met.sum.sub$Strain <- factor(Met.sum.sub$Strain, levels = c("C57BL/6J", "SW",  "B6C3F1/J",
                                                            "Population distribution","Population mean"), ordered=TRUE)
head(Met.sum.sub)
#*-------------------------------------------------------------------------------------------------*---------------------
#*Plot errorbar of Metabolism comparison ------------------------------
#--------* Free scales----------
#--------*~ pMet36----------
pMet36 <-
ggplot(data = Met.sum.sub, aes(y = strains, x = m, xmin=low, xmax=up, shape = Strain, fill = Diet)) + #colour = TKVF,
  scale_shape_manual(values=c(17,22,19,3,23)) + #values=c(3,19,17,18,15,22,0)
  scale_fill_manual(values=c(8,"white",1)) +
  geom_errorbar(width=0.3,cex=1) +  #aes(ymin=low, ymax=up),
  geom_pointrange(aes(shape = Strain, fill = Diet), size=0.7) + #, #fill = "white", pch = 22,#linetype = "dashed",, fatten = 3.2
  scale_x_log10() + #breaks = trans_breaks("log10", function(x) 10^x), limits = c(10^0,10^1.5), 
                # labels = trans_format("log10", math_format(10^.x))) +
  scale_y_discrete(position = "right") +
  labs(y="", x="Amount metabolized, mg", fill = "Diet:", shape = "Strain:") + 
  ggtitle("Total disposition") + #B.
  annotation_logticks(scaled = TRUE, sides="b") +
  facet_wrap(chemical ~ ., strip.position = "left", scales = "free", nrow = 3) + #switch = ,
  # coord_flip() +
  # guides(shape  = guide_legend(title.position = "left", direction = "horizontal", nrow = 2)) + #, label.position="bottom",
  theme_pubr() +
  theme(panel.grid.minor.y = element_blank(),
        panel.border = element_rect(colour = "black", fill=NA), #
        axis.text.x = element_text(size=10), #angle = 1, hjust=10,
        axis.text.y = element_blank(), #angle = 1, hjust=10,
        axis.ticks.y = element_blank(), 
        plot.title = element_text(size=14, face="bold"),
        plot.margin = unit(c(0,1,0.5,1), "cm"), #unit(c(0,1,0,2), "cm"),
        legend.position = "none",
        strip.text = element_text(size=10, colour="white", face = "bold"),
        # legend.title = element_text(face = "bold"),
        # legend.text = element_text(size=12))
        strip.background = element_rect(fill="navy")) #
#*-------------------------------------------------------------------------------------------------*---------------------
#--------1.2.~3-diet ----------
#*-------------------------------------------------------------------------------------------------*---------------------
#---------------------------------* Set drive------------------------------------------------------
#--------* Call outputs ----------
#** from laptop-----------------------------
out.B6 <- fread("perc.mouse.3strains.3diet.27p.s.AUC.set.1000.B6.out")
out.SW <- fread("perc.mouse.3strains.3diet.27p.s.AUC.set.1000.SW.out") 
out.LFD <- fread("perc.mouse.3strains.3diet.27p.s.AUC.set.1000.LFD.out")  
out.HFD <- fread("perc.mouse.3strains.3diet.27p.s.AUC.set.1000.HFD.out")
out.MCD <- fread("perc.mouse.3strains.3diet.27p.s.AUC.set.1000.MCD.out")
names(out.B6)
#** select AUC-----------------------------
out.B6 <- out.B6[,c(1,107:123)]
out.SW <- out.SW[,c(1,107:123)]
out.LFD <- out.LFD[,c(1,107:123)]
out.HFD <- out.HFD[,c(1,107:123)]
out.MCD <- out.MCD[,c(1,107:123)]
#** Add strain-----------------------------
out.B6$strain <- "B6C3F1/J"
out.SW$strain <- "SW"
out.LFD$strain <- "C57BL/6J-LFD"
out.HFD$strain <- "C57BL/6J-HFD"
out.MCD$strain <- "C57BL/6J-MCD"
#--------------------* Combine 5 strains *----------------------------------------------
output <- rbind(out.B6,out.SW, out.LFD, out.HFD, out.MCD)
head(output)
# *** Melt for population prediction ***
output.dat <- melt(output, id = c("Iter","strain"))
class(output.dat$variable)
output.dat$conc.time <-as.character(levels(output.dat$variable))[output.dat$variable]
#split the columns for population prediction
AUC.out <- data.frame(output.dat$Iter, output.dat$strain,output.dat$value, 
                      do.call("rbind",strsplit(output.dat$conc.time, "_")))
# AUC.out[1:3,]
AUC.out$X2<- NULL
colnames(AUC.out) <- c("iter" , "strain", "conc", "name")
# AUC.out[1:3,]
AUC.out$strain <- factor(AUC.out$strain, levels = c("B6C3F1/J","SW",
                                                    "C57BL/6J-LFD","C57BL/6J-HFD",
                                                    "C57BL/6J-MCD"), ordered=TRUE) 
AUC.out$chemical[AUC.out$name == "AUCBld"] <- "Perc"
AUC.out$chemical[AUC.out$name == "AUCLiv"] <- "Perc"
AUC.out$chemical[AUC.out$name == "AUCKid"] <- "Perc"
AUC.out$chemical[AUC.out$name == "AUCFat"] <- "Perc"
AUC.out$chemical[AUC.out$name == "AUCPlasTCA"] <- "TCAfree"
AUC.out$chemical[AUC.out$name == "AUCPlasTCAFree"] <- "TCA"
AUC.out$chemical[AUC.out$name == "AUCLivTCA"] <- "TCA"
AUC.out$chemical[AUC.out$name == "AUCKidTCA"] <- "TCA"
AUC.out$chemical[AUC.out$name == "AUCBldTCVG"] <- "TCVG"
AUC.out$chemical[AUC.out$name == "AUCLivTCVG"] <- "TCVG"
AUC.out$chemical[AUC.out$name == "AUCKidTCVG"] <- "TCVG"
AUC.out$chemical[AUC.out$name == "AUCBldTCVC"] <- "TCVC"
AUC.out$chemical[AUC.out$name == "AUCLivTCVC"] <- "TCVC"
AUC.out$chemical[AUC.out$name == "AUCKidTCVC"] <- "TCVC"
AUC.out$chemical[AUC.out$name == "AUCBldNAT"] <- "NAcTCVC"
AUC.out$chemical[AUC.out$name == "AUCLivNAT"] <- "NAcTCVC"
AUC.out$chemical[AUC.out$name == "AUCKidNAT"] <- "NAcTCVC"

AUC.out$tissue[AUC.out$name == "AUCBld"] <- "blood"
AUC.out$tissue[AUC.out$name == "AUCLiv"] <- "liver"
AUC.out$tissue[AUC.out$name == "AUCKid"] <- "kidney"
AUC.out$tissue[AUC.out$name == "AUCFat"] <- "fat"
AUC.out$tissue[AUC.out$name == "AUCPlasTCA"] <- "blood"
AUC.out$tissue[AUC.out$name == "AUCPlasTCAFree"] <- "blood"
AUC.out$tissue[AUC.out$name == "AUCLivTCA"] <- "liver"
AUC.out$tissue[AUC.out$name == "AUCKidTCA"] <- "kidney"
AUC.out$tissue[AUC.out$name == "AUCBldTCVG"] <- "blood"
AUC.out$tissue[AUC.out$name == "AUCLivTCVG"] <- "liver"
AUC.out$tissue[AUC.out$name == "AUCKidTCVG"] <- "kidney"
AUC.out$tissue[AUC.out$name == "AUCBldTCVC"] <- "blood"
AUC.out$tissue[AUC.out$name == "AUCLivTCVC"] <- "liver"
AUC.out$tissue[AUC.out$name == "AUCKidTCVC"] <- "kidney"
AUC.out$tissue[AUC.out$name == "AUCBldNAT"] <- "blood"
AUC.out$tissue[AUC.out$name == "AUCLivNAT"] <- "liver"
AUC.out$tissue[AUC.out$name == "AUCKidNAT"] <- "kidney"
AUC.out$chemical <- factor(AUC.out$chemical, levels = c("Perc","TCA","TCAfree","TCVG","TCVC","NAcTCVC"), ordered=TRUE)
AUC.out$tissue <- factor(AUC.out$tissue, levels = c("blood","liver","kidney", "fat"), ordered=TRUE)
head(AUC.out)
# ------------------------** AUC.sum.3d -------------
AUC.sum.3d = ddply(AUC.out, .(strain, chemical,tissue), function(AUC.out){ #
  c(#GM=geoMean(AUC.out$conc, na.rm = TRUE),
    # GSD=geoSD(AUC.out$conc, na.rm = TRUE),
    median=median(AUC.out$conc, na.rm = TRUE),
    # low = quantile(AUC.out$conc, 0.01, na.rm = TRUE),
    low = quantile(AUC.out$conc, 0.025, na.rm = TRUE),
    # low = quantile(AUC.out$conc, 0.05, na.rm = TRUE),
    # up = quantile(AUC.out$conc, 0.95, na.rm = TRUE),
    up = quantile(AUC.out$conc, 0.975, na.rm = TRUE))
    # up = quantile(AUC.out$conc, 0.99, na.rm = TRUE))
})
head(AUC.sum.3d)
#** Rename variables------------------------
colnames(AUC.sum.3d) <- c("strain","chemical","tissue","median","low025","up975") 
#--------* Remove Fat----------
AUC.summ <- subset(AUC.sum.3d, tissue != "fat" & chemical != "TCAfree")
head(AUC.summ)
#* Write Summary of AUC file  -----------------------------
write.csv(AUC.summ, file = "AUC.3-diet.1000.csv")
#*-------------------------------------------------------------------------------------------------*---------------------
#* Call Combined AUC file -----------------------------
Comb.AUC = fread("AUC.combined.1025.csv")
Comb.AUC$tissues[Comb.AUC$tissue == "blood"] <- "Blood"
Comb.AUC$tissues[Comb.AUC$tissue == "liver"] <- "Liver"
Comb.AUC$tissues[Comb.AUC$tissue == "kidney"] <- "Kidney"

Comb.AUC$chemical <- factor(Comb.AUC$chemical, levels = c("Perc","TCA","TCVG","TCVC","NAcTCVC"), ordered=TRUE) #"TCAfree",
Comb.AUC$tissue <- factor(Comb.AUC$tissues, levels = c("Blood","Liver","Kidney"), ordered=TRUE)
Comb.AUC$strains <- factor(Comb.AUC$strains, levels = c("C57BL/6J-NASH","C57BL/6J-NAFL",
                                                              "C57BL/6J", "SW",  "B6C3F1/J",
                                                              "Population distribution","Population mean"), ordered=TRUE)
Comb.AUC$Strain <- factor(Comb.AUC$Strain, levels = c("C57BL/6J", "SW",  "B6C3F1/J",
                                                            "Population distribution","Population mean"), ordered=TRUE)
#*-------------------------------------------------------------------------------------------------*---------------------
#*Plot errorbar of AUC comparison ------------------------------
#--------* Free scales----------
#--------~ pAUC----------
pAUC <-
ggplot(data = Comb.AUC, aes(y = strains, x = m, xmin=low, xmax=up, shape = strains,#Strain
                            fill = Diet, size=Strain)) + #
  scale_shape_manual(values=c(22,22,15,23,24,19,3)) + #values=c(3,19,17,18,15,22,0) ,23
  scale_fill_manual(values=c(8,"white",1)) +
  scale_colour_manual(values=c("white",1)) +
  scale_linetype_manual(values=c(0,1)) +
  scale_size_manual(values=c(2,2,2,2,2.3)) +
  geom_errorbar(aes(linetype = Uncertainty, colour = Uncertainty), width=0.3,cex=0.6) +  #aes(ymin=low, ymax=up),
  geom_point(stroke =0.7) + 
  scale_x_log10() + #breaks = trans_breaks("log10", function(x) 10^x), limits = c(10^0,10^1.5), 
  scale_y_discrete(position = "right") +
  labs(y="", x="AUC, concentration, mg * 36 hr/L or mg * 36 hr/kg") + #, fill = "Diet:", shape = "Strain:"
  ggtitle("") + #B.
  annotation_logticks(scaled = TRUE, sides="b") +
  facet_grid(tissue ~ chemical, switch="y", scales = "free") + #switch = , nrow = 3,strip.position = "left",
  theme_pubr() +
  theme(panel.grid.minor.y = element_blank(),
        strip.background = element_rect(fill="navy"), #
        panel.border = element_rect(colour = "black", fill=NA), #
        axis.text.x = element_text(size=10), #angle = 1, hjust=10,
        axis.text.y = element_text(size=10), #angle = 1, hjust=10,
        axis.title = element_text(size=10),
        # axis.ticks.y = element_blank(), 
        # plot.title = element_text(size=18, face="bold"),
        # plot.margin = unit(c(0,8,0,7), "cm"), #unit(c(0,1,0,2), "cm"),
        legend.position = "none",
        strip.text = element_text(size=12, colour="white", face = "bold"))
        
#--------~ pMet36----------
pMet36 <-
  ggplot(data = Met.sum.sub, aes(y = strains, x = m, xmin=low, xmax=up, shape = Strain, colour = Uncertainty,
                                 fill = Diet, size=Strain)) + 
  scale_shape_manual(values=c(22,18,17,19,3)) + 
  scale_fill_manual(values=c(8,"white",1)) + 
  scale_colour_manual(values=c("white",1)) +
  scale_linetype_manual(values=c(0,1)) +
  scale_size_manual(values=c(2,3,2.5,2,2)) +
  geom_errorbar(aes(linetype= Uncertainty), width=0.3, cex=0.7) +  #aes(ymin=low, ymax=up),
    # geom_pointrange(aes(shape = Strain, fill = Diet,linetype= Uncertainty), size=1) + #, #fill = "white", pch = 22,#linetype = "dashed",, fatten = 3.2
  geom_point(stroke =0.7) + #range, #fill = "white", pch = 22,#linetype = "dashed",, fatten = 3.2
  scale_x_log10() + #breaks = trans_breaks("log10", function(x) 10^x), limits = c(10^0,10^1.5), 
  # labels = trans_format("log10", math_format(10^.x))) +
  scale_y_discrete(position = "right") +
  labs(y="", x="Amount metabolized, mg", fill = "Diet:", shape = "Strain:") + 
  ggtitle("Total disposition") + #B.
  annotation_logticks(scaled = TRUE, sides="b") +
  facet_wrap(chemical ~ ., strip.position = "left", scales = "free", nrow = 3) + #switch = ,
  # coord_flip() +
  # guides(shape  = guide_legend(title.position = "left", direction = "horizontal", nrow = 2)) + #, label.position="bottom",
  theme_pubr() +
  theme(panel.grid.minor.y = element_blank(),
        panel.border = element_rect(colour = "black", fill=NA), #
        axis.text.x = element_text(size=8), #angle = 1, hjust=10,
        axis.text.y = element_blank(), #angle = 1, hjust=10,
        axis.ticks.y = element_blank(), 
        axis.title = element_text(size=10), #angle = 1, hjust=10,
        plot.title = element_text(size=12, face="bold"),
        plot.margin = unit(c(1,-0.5,0.3,1), "cm"), #unit(c(0,1,0,2), "cm"),
        legend.position = "none",
        strip.text = element_text(size=10, colour="white", face = "bold"),
        # legend.title = element_text(face = "bold"),
        # legend.text = element_text(size=12))
        strip.background = element_rect(fill="navy")) #

  plot_grid(pMet36, pAUC, rel_widths = c(0.16/2, 0.83/2))
#*-------------------------------------------------------------------------------------------------*---------------------
#*~/~ Combined AUC+Metabolism---------------
pdf(paste("~Figure 5.pdf",sep=""), 
     width = 15, height = 7, pointsize = 8, bg = "white")
plot_grid(pMet36, pAUC, labels = c("A.", "B."), rel_widths = c(0.16/2, 0.83/2))
dev.off()
#*-------------------------------------------------------------------------------------------------*---------------------
#3.-------------------------------------------------------------------------------------------------*---------------------
# --------3.1. TKVF-Met CC45+Luo19 Combined Plot  ----------
#*-------------------------------------------------------------------------------------------------*---------------------
#* Call TKVF.Met.csv-----------------------------
Met.sum = fread("Comb.TKVF.met.csv")
tail(Met.sum)
Met.sum$chemical <- factor(Met.sum$chemical,
                           levels = c("Perc excreted",#"Total oxidation","Oxidation in liver",
                                      "Total TCA produced","Total GSH conjugation"), 
                           ordered=TRUE)
Met.sum$Study <- factor(Met.sum$Study,
                        levels = c("Luo et al. (2019)", "This study"),
                        ordered=TRUE)
Met.sum$Study <- factor(Met.sum$Study,
                        levels = c("Luo et al. (2019)", "Cichocki et al. (2017b)","This study - PO=1000 mg", 
                                   "This study - PO=100 mg", "This study - PO=10 mg"),
                        ordered=TRUE)
#*-------------------------------------------------------------------------------------------------*---------------------
#*Plot errorbar of Metabolism comparison ------------------------------
#--------* Free scales----------
#--------*~ pMet.TKVF99----------
pMet.TKVF99 <-
  ggplot(data = Met.sum, aes(y = Study, x = TKVF99.m, xmin=TKVF99.low, xmax=TKVF99.up)) + #colour = TKVF,
  scale_shape_manual(values=c(23,0,19,21,21)) + #values=c(3,19,17,18,15,22,0)
  # scale_size_manual(values=c(4,3.2)) +
  scale_fill_manual(values=c(1,1,1,8,"white")) +
  geom_vline(xintercept=3.16, linetype="dashed", col = 2) + #10^0.5
  geom_errorbar(width=0.2, cex=.6) +  #aes(ymin=low, ymax=up),
  geom_point(aes(x = TKVF99.m, shape = Study, fill = Study), stroke = 1, size = 1.8) + #Study, , size=3, #"white", pch = 22,#linetype = "dashed",, fatten = 3.2
  scale_x_log10(breaks = c(1, 3.16, 10, 30), limits = c(10^0,30), label = c(1, 3.16, 10, 30)) +
  scale_y_discrete(position = "right") +
  labs(y="", x=expression("TKVF"[99])) + #, shape = "Study:"
  ggtitle("Total disposition") + #B.
  # annotation_logticks(scaled = TRUE, sides="b") +
  facet_wrap(chemical ~ ., strip.position = "left", nrow = 3) + #switch = ,
  # coord_flip() +
  # guides(shape  = guide_legend(title.position = "left", direction = "horizontal", nrow = 2)) + #, label.position="bottom",
  theme_pubr() +
  theme(panel.grid.minor.y = element_blank(),
        panel.border = element_rect(colour = "black", fill=NA), #
        axis.text.x = element_text(size=10), #angle = 1, hjust=10,
        axis.text.y = element_blank(), #angle = 1, hjust=10,
        axis.ticks.y = element_blank(),
        plot.title = element_text(size=10, face="bold"),
        # plot.margin = unit(c(1,0,0.3,1), "cm"), #unit(c(0,1,0,2), "cm"),
        plot.margin = unit(c(1,-0.5,0.3,1), "cm"), #unit(c(0,1,0,2), "cm"),
        legend.position = "none",
        strip.text = element_text(size=8, face = "bold", colour = "white"),
        # legend.title = element_text(face = "bold"),
        # legend.text = element_text(size=12))
        strip.background = element_rect(fill="navy")) #royalblue4, colour="white"
#*-------------------------------------------------------------------------------------------------*---------------------
#--------3.2. TKVF-AUC CC45+Luo, Cichock17b Combined Plot  ----------
#*-------------------------------------------------------------------------------------------------*---------------------
#* Call TKVF.AUC.csv-----------------------------
AUC.sum = read.csv("TKVF.comb.AUC.1025.csv")
AUC.sum = read.csv("TKVF.comb.AUC.10mg.csv")
AUC.sum = read.csv("TKVF99.comb.AUC.csv")
head(AUC.sum)
AUC.sum$tissues[AUC.sum$tissue == "blood"] <- "Blood"
AUC.sum$tissues[AUC.sum$tissue == "liver"] <- "Liver"
AUC.sum$tissues[AUC.sum$tissue == "kidney"] <- "Kidney"

AUC.sum$tissue <- factor(AUC.sum$tissues, levels = c("Blood","Liver","Kidney"), ordered=TRUE) 
AUC.sum$chemical <- factor(AUC.sum$chemical, levels = c("Perc","TCA","TCVG","TCVC","NAcTCVC"), ordered=TRUE)
AUC.sum$Study <- factor(AUC.sum$Study,
                        levels = c("Luo et al. (2019)", "Cichocki et al. (2017b)",
                                   "This study - PO=1000 mg","This study - PO=100 mg",
                                   "This study - PO=10 mg"),
                        ordered=TRUE)
#* for TKVF95----------
AUC.sum$Study <- factor(AUC.sum$Study,
                        levels = c("Luo et al. (2019)", #"Cichocki et al. (2017b)",
                                   "This study - PO=1000 mg","This study - PO=100 mg",
                                   "This study - PO=10 mg"),
                        ordered=TRUE)
#--------*~ pAUC.TKVF99----------
pAUC.TKVF99 <-
  ggplot(data = AUC.sum, aes(y = Study, x = m, xmin=low, xmax=up)) + #colour = TKVF,
  scale_shape_manual(values=c(5,0,21,21,21)) + #values=c(3,19,17,18,15,22,0)
  # scale_size_manual(values=c(2,2,1.8)) +
  scale_fill_manual(values=c(NA,NA,1,8,"white")) +
  geom_vline(xintercept=10^0.5, linetype="dashed", col = 2) +
  geom_errorbar(width=0.2, cex=0.6) +  #aes(ymin=low, ymax=up),
  geom_point(aes(x = m, shape = Study, fill = Study), size = 1.8, stroke=1) + #, size=3,
  # xlim(1, 30) +
  scale_x_log10(breaks = c(1, 3.16, 10, 30), limits = c(10^0,32), label = c(1, 3.16, 10, 30)) +
  scale_y_discrete(position = "right") +
  labs(y="", x=expression("AUC-TKVF"[99])) + #, shape = "Study:"
  ggtitle("") + #B.
  # annotation_logticks(scaled = TRUE, sides="b") +
  facet_grid(tissue ~ chemical, switch="y", scales = "free") + #switch = , nrow = 3,strip.position = "left",
  # coord_flip() +
  # guides(shape  = guide_legend(title.position = "left", direction = "horizontal", nrow = 2)) + #, label.position="bottom",
  theme_pubr() +
  theme(panel.grid.minor.y = element_blank(),
        panel.border = element_rect(colour = "black", fill=NA), #
        axis.text = element_text(size=10), #angle = 1, hjust=10,
        # axis.text.y = element_blank(), #angle = 1, hjust=10,
        # axis.ticks.y = element_blank(), 
        plot.title = element_text(size=14, face="bold"),
        # plot.margin = unit(c(0,1,0.5,1), "cm"), #unit(c(0,1,0,2), "cm"),
        legend.position = "none",
        strip.text = element_text(size=11, face = "bold", colour="white"),
        # legend.title = element_text(face = "bold"),
        # legend.text = element_text(size=12))
        strip.background = element_rect(fill="navy"))

#* Creat empty box---------------------
rect <- rectGrob(
  x = unit(0.36, "in"),
  y = unit(1.065, "npc") - unit(1, "in"),
  width = unit(1.96, "in"),
  height = unit(1.57, "in"),
  hjust = 0, vjust = 1,
  gp = gpar(fill = "white")
)
#* Add empty box to plot---------------------
pAUC.TKVF99.1 <- ggdraw(pAUC.TKVF99) +
  draw_grob(rect)
#3.3.-------------------------------------------------------------------------------------------------*---------------------
#*~/~ Combined 99% AUC+Metabolism---------------
plot_grid(pMet.TKVF99, pAUC.TKVF99, rel_widths = c(0.4/2, 1.1/2))
#* Fig 6---------------------
pdf(paste("~/Figure 6.upd1.pdf"),
    width = 12, height = 6,bg = "white") #, res = 300units = "in", pointsize = 8,
plot_grid(pMet.TKVF99, pAUC.TKVF99, labels = c("A.", "B."), rel_widths = c(0.16/2,0.83/2))#0.24/2, 1.1/2
dev.off()
#--------*~ pMet.TKVF95----------
pMet.TKVF95 <-
  ggplot(data = Met.sum, aes(y = Study, x = TKVF95.m, xmin=TKVF95.low, xmax=TKVF95.up)) + #colour = TKVF,
  scale_shape_manual(values=c(23,19,21, 21)) + #values=c(3,19,17,18,15,22,0)
  # scale_size_manual(values=c(4,3.2)) +
  scale_fill_manual(values=c(1,1,8,"white")) +
  geom_vline(xintercept=3.16, linetype="dashed") + #10^0.5
  geom_errorbar(width=0.2, cex=1) +  #aes(ymin=low, ymax=up),
  geom_point(aes(x = TKVF95.m, shape = Study, fill = Study), stroke = 1, size=2.7) + #, #, pch = 22,#linetype = "dashed",, fatten = 3.2
  scale_x_log10(breaks = c(1, 3.16, 10), limits = c(10^0,10), label = c(1, 3.16, 10)) +
  scale_y_discrete(position = "right") +
  labs(y="", x=expression("TKVF"[95])) + #, shape = "Study:"
  ggtitle("Total disposition") + #B.
  # annotation_logticks(scaled = TRUE, sides="b") +
  facet_wrap(chemical ~ ., strip.position = "left", nrow = 3) + #switch = ,
  # coord_flip() +
  # guides(shape  = guide_legend(title.position = "left", direction = "horizontal", nrow = 2)) + #, label.position="bottom",
  theme_pubr() +
  theme(panel.grid.minor.y = element_blank(),
        panel.border = element_rect(colour = "black", fill=NA), #
        axis.text.x = element_text(size=10), #angle = 1, hjust=10,
        axis.text.y = element_blank(), #angle = 1, hjust=10,
        axis.ticks.y = element_blank(),
        plot.title = element_text(size=14, face="bold"),
        plot.margin = unit(c(1,0,0.3,1), "cm"), #unit(c(0,1,0,2), "cm"),
        legend.position = "none",
        strip.text = element_text(size=8, face = "bold"),
        # legend.title = element_text(face = "bold"),
        # legend.text = element_text(size=12))
        strip.background = element_rect(fill="white")) #, colour="white"

#--------*~ pAUC.TKVF95----------
pAUC.TKVF95 <-
  ggplot(data = AUC.sum, aes(y = Study, x = m, xmin=low, xmax=up)) + #colour = TKVF,
  scale_shape_manual(values=c(5,19,21,21)) + #values=c(3,19,17,18,15,22,0)
  # scale_size_manual(values=c(2,2,2)) +
  scale_fill_manual(values=c(NA,1,8,"white")) +
  geom_vline(xintercept=3.16, linetype="dashed") +
  geom_errorbar(width=0.2, cex=1) +  #aes(ymin=low, ymax=up),
  geom_point(aes(x = m, shape = Study, fill = Study), size=2, stroke=1.5) + #size = Study, ,
  scale_x_log10(breaks = c(1, 3.16, 10), limits = c(10^0,12), label = c(1, 3.16, 10)) +
  scale_y_discrete(position = "right") +
  labs(y="", x=expression("AUC-TKVF"[95])) + #, shape = "Study:"
  ggtitle("") + #B.
  # annotation_logticks(scaled = TRUE, sides="b") +
  facet_grid(tissue ~ chemical, switch="y", scales = "free") + #switch = , nrow = 3,strip.position = "left",
  # coord_flip() +
  # guides(shape  = guide_legend(title.position = "left", direction = "horizontal", nrow = 2)) + #, label.position="bottom",
  theme_pubr() +
  theme(panel.grid.minor.y = element_blank(),
        panel.border = element_rect(colour = "black", fill=NA), #
        axis.text.x = element_text(size=10), #angle = 1, hjust=10,
        # axis.text.y = element_blank(), #angle = 1, hjust=10,
        # axis.ticks.y = element_blank(), 
        plot.title = element_text(size=14, face="bold"),
        # plot.margin = unit(c(0,1,0.5,1), "cm"), #unit(c(0,1,0,2), "cm"),
        legend.position = "none",
        strip.text = element_text(size=11, face = "bold"),
        # legend.title = element_text(face = "bold"),
        # legend.text = element_text(size=12))
        strip.background = element_rect(fill="white"))
#* Creat empty box---------------------
rect <- rectGrob(
  x = unit(0.36, "in"),
  y = unit(1.075, "npc") - unit(1, "in"),
  width = unit(1.68, "in"),
  height = unit(1.23, "in"),
  hjust = 0, vjust = 1,
  gp = gpar(fill = "white")
)
#* Creat empty box---------------------
rect <- rectGrob(
  x = unit(0.36, "in"),
  y = unit(1.065, "npc") - unit(1, "in"),
  width = unit(2.05, "in"),
  height = unit(1.37, "in"),
  hjust = 0, vjust = 1,
  gp = gpar(fill = "white")
)
#* Add empty box to plot---------------------
pAUC.TKVF95.1 <- ggdraw(pAUC.TKVF95) +
  draw_grob(rect)
#3.4. -------------------------------------------------------------------------------------------------*---------------------
#*~/~ Combined 95% AUC+Metabolism---------------;
plot_grid(pMet.TKVF95, pAUC.TKVF95.1, rel_widths = c(0.4/2, 1/2))
#* Fig S-15---------------------
pdf(paste("~/Fig. S-14.pdf"),
     width = 16, height = 5.5,bg = "white") #, res = 300units = "in", pointsize = 8,
plot_grid(pMet.TKVF95, pAUC.TKVF95.1, labels = c("A.", "B."), rel_widths = c(0.37/2, 1.7/2))
dev.off()
