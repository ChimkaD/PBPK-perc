#-------------Set drive------------------------------------
setwd("C:/MinGW/msys/1.0/home/wchiulab/mcsim-5.6.5/ChiuGinsbergPercModelFiles/GSA")
setwd("C:/MinGW/msys/1.0/home/chimka/Perc/GSA")
#-------------Call required packages------------------------------------
install.packages("devtools")
install.packages("glue") #rlang
install.packages("tibble")
install.packages("ggtext")
devtools::install_github("nanhung/pksensi")
library(glue)
library(pksensi)
library(reshape2)
library(EnvStats)
library(ggplot2)
library(ggtext)
#-------------Input Parameter distributions------------------------------------
source("perc.58.posterior.param.dist.1.R")
source("perc.58.posterior.ci95.R")
source("perc.C5.58.posterior.param.dist.R")
#*--------------------------------------------------*---------------------
#-------------Set GSA parameters------------------------------------
#-------------* Set factors = params------------------------------------
factors <- c("lnQCC","lnVPRC","QFatC","QGutC","QLivC","QSlwC","QKidC","FracPlasC",
             "VFatC","VGutC","VLivC" ,"VRapC","VRespLumC","VRespEffC","VKidC","VBldC","lnkTSD",
             "lnkAS","lnkASAq","lnkAD","lnkTSDAq","lnkADAq","PBC","PFatC","lnPGutC","lnPLivC",
             "lnPRapC","lnPRespC","lnPKidC","lnPSlwC","lnPBrnC","lnPRBCPlasTCAC","lnPKidTCAC","lnPBrnTCAC",
             "lnPBodTCAC" ,"lnPLivTCAC","lnkDissocC","lnBMaxkDC","lnPBodTCVGC",
             "lnPLivTCVGC","lnPKidTCVGC" ,"lnPBodTCVCC","lnPLivTCVCC","lnPKidTCVCC","lnPBodNATC",
             "lnPLivNATC","lnPKidNATC","lnKMC","lnClC","lnCl2OxC","lnFracOtherC",
             "lnkUrnTCAC","lnkMetTCAC","lnClTCVGC","lnkKidTCVCC","lnkKidNATC","lnkDCAC","lnkUrnNATC")
#-------------* Set model------------------------------------
q <- c("qnormTrunc","qnormTrunc","qlnormTrunc", "qlnormTrunc","qlnormTrunc","qlnormTrunc",
       "qlnormTrunc", "qlnormTrunc","qlnormTrunc","qlnormTrunc",
       "qlnormTrunc", "qlnormTrunc","qlnormTrunc","qlnormTrunc",
       "qlnormTrunc", "qlnormTrunc", "qnormTrunc", "qnormTrunc", "qnormTrunc",
       "qnormTrunc", "qnormTrunc", "qnormTrunc","qlnormTrunc","qlnormTrunc",
       "qnormTrunc","qnormTrunc","qnormTrunc","qnormTrunc",
       "qnormTrunc","qnormTrunc","qnormTrunc","qnormTrunc","qnormTrunc",
       "qnormTrunc","qnormTrunc","qnormTrunc","qnormTrunc",
       "qnormTrunc","qnormTrunc","qnormTrunc","qnormTrunc",
       "qnormTrunc","qnormTrunc","qnormTrunc","qnormTrunc",
       "qnormTrunc","qnormTrunc","qnormTrunc","qnormTrunc", "qnormTrunc", 
       "qnormTrunc","qnormTrunc", "qnormTrunc","qnormTrunc", 
       "qnormTrunc", "qnormTrunc","qnormTrunc", "qnormTrunc")
# q <- rep("qnormTrunc", 52)
#-------------* Set q.arg------------------------------------
q.arg <- list(list(M_lnQCC, sd_lnQCC, min_lnQCC, max_lnQCC),
              list(M_lnVPRC, sd_lnVPRC, min_lnVPRC, max_lnVPRC),
              list(M_QFatC, sd_QFatC, min_QFatC, max_QFatC),
              list(M_QGutC, sd_QGutC, min_QGutC, max_QGutC),
              list(M_QLivC, sd_QLivC, min_QLivC, max_QLivC),
              list(M_QSlwC, sd_QSlwC, min_QSlwC, max_QSlwC),
              list(M_QKidC, sd_QKidC, min_QKidC, max_QKidC),
              list(M_FracPlasC, sd_FracPlasC, min_FracPlasC, max_FracPlasC),
              list(M_VFatC, sd_VFatC, min_VFatC, max_VFatC),
              list(M_VGutC, sd_VGutC, min_VGutC, max_VGutC),
              list(M_VLivC, sd_VLivC, min_VLivC, max_VLivC),
              list(M_VRapC, sd_VRapC, min_VRapC, max_VRapC),
              list(M_VRespLumC, sd_VRespLumC, min_VRespLumC, max_VRespLumC),
              list(M_VRespEffC, sd_VRespEffC, min_VRespEffC, max_VRespEffC),
              list(M_VKidC, sd_VKidC, min_VKidC, max_VKidC),
              list(M_VBldC, sd_VBldC, min_VBldC, max_VBldC),
              list(M_lnkTSD, sd_lnkTSD, min_lnkTSD, max_lnkTSD),
              list(M_lnkAS, sd_lnkAS, min_lnkAS, max_lnkAS),
              list(M_lnkASAq, sd_lnkASAq, min_lnkASAq, max_lnkASAq),
              list(M_lnkAD, sd_lnkAD, min_lnkAD, max_lnkAD),
              list(M_lnkTSDAq, sd_lnkTSDAq, min_lnkTSDAq, max_lnkTSDAq),
              list(M_lnkADAq, sd_lnkADAq, min_lnkADAq, max_lnkADAq),
              list(M_PBC, sd_PBC, min_PBC, max_PBC),
              list(M_PFatC, sd_PFatC, min_PFatC, max_PFatC),
              list(M_lnPGutC, sd_lnPGutC, min_lnPGutC, max_lnPGutC),
              list(M_lnPLivC, sd_lnPLivC, min_lnPLivC, max_lnPLivC),
              list(M_lnPRapC, sd_lnPRapC, min_lnPRapC, max_lnPRapC),
              list(M_lnPRespC, sd_lnPRespC, min_lnPRespC, max_lnPRespC),
              list(M_lnPKidC, sd_lnPKidC, min_lnPKidC, max_lnPKidC),
              list(M_lnPSlwC, sd_lnPSlwC, min_lnPSlwC, max_lnPSlwC),
              list(M_lnPBrnC, sd_lnPBrnC, min_lnPBrnC, max_lnPBrnC),
              list(M_lnPRBCPlasTCAC, sd_lnPRBCPlasTCAC, min_lnPRBCPlasTCAC, max_lnPRBCPlasTCAC),
              list(M_lnPKidTCAC, sd_lnPKidTCAC, min_lnPKidTCAC, max_lnPKidTCAC),
              list(M_lnPBrnTCAC, sd_lnPBrnTCAC, min_lnPBrnTCAC, max_lnPBrnTCAC),
              list(M_lnPBodTCAC, sd_lnPBodTCAC, min_lnPBodTCAC, max_lnPBodTCAC),
              list(M_lnPLivTCAC, sd_lnPLivTCAC, min_lnPLivTCAC, max_lnPLivTCAC),
              list(M_lnkDissocC, sd_lnkDissocC, min_lnkDissocC, max_lnkDissocC),
              list(M_lnBMaxkDC, sd_lnBMaxkDC, min_lnBMaxkDC, max_lnBMaxkDC),
              list(M_lnPBodTCVGC, sd_lnPBodTCVGC, min_lnPBodTCVGC, max_lnPBodTCVGC), 
              list(M_lnPLivTCVGC, sd_lnPLivTCVGC, min_lnPLivTCVGC, max_lnPLivTCVGC),
              list(M_lnPKidTCVGC, sd_lnPKidTCVGC, min_lnPKidTCVGC, max_lnPKidTCVGC),
              list(M_lnPBodTCVCC, sd_lnPBodTCVCC, min_lnPBodTCVCC, max_lnPBodTCVCC),
              list(M_lnPLivTCVCC, sd_lnPLivTCVCC, min_lnPLivTCVCC, max_lnPLivTCVCC),
              list(M_lnPKidTCVCC, sd_lnPKidTCVCC, min_lnPKidTCVCC, max_lnPKidTCVCC), 
              list(M_lnPBodNATC, sd_lnPBodNATC, min_lnPBodNATC, max_lnPBodNATC), 
              list(M_lnPLivNATC, sd_lnPLivNATC, min_lnPLivNATC, max_lnPLivNATC), 
              list(M_lnPKidNATC, sd_lnPKidNATC, min_lnPKidNATC, max_lnPKidNATC),
              list(M_lnKMC, sd_lnKMC, min_lnKMC, max_lnKMC),
              list(M_lnClC, sd_lnClC, min_lnClC, max_lnClC),
              list(M_lnCl2OxC, sd_lnCl2OxC, min_lnCl2OxC, max_lnCl2OxC),
              list(M_lnFracOtherC, sd_lnFracOtherC, min_lnFracOtherC, max_lnFracOtherC),
              list(M_lnkUrnTCAC, sd_lnkUrnTCAC, min_lnkUrnTCAC, max_lnkUrnTCAC),
              list(M_lnkMetTCAC, sd_lnkMetTCAC, min_lnkMetTCAC, max_lnkMetTCAC),
              list(M_lnClTCVGC, sd_lnClTCVGC, min_lnClTCVGC, max_lnClTCVGC),
              list(M_lnkKidTCVCC, sd_lnkKidTCVCC, min_lnkKidTCVCC, max_lnkKidTCVCC),
              list(M_lnkKidNATC, sd_lnkKidNATC, min_lnkKidNATC, max_lnkKidNATC),
              list(M_lnkDCAC, sd_lnkDCAC, min_lnkDCAC, max_lnkDCAC),
              list(M_lnkUrnNATC, sd_lnkUrnNATC, min_lnkUrnNATC, max_lnkUrnNATC))
#-------------* Set outputs------------------------------------
outputs <- c("CVen.1",	#"Blood Perc-LFD",
             "CLiv.1",	
             "CKid.1",	
             "CFat.1",	
             "CPlasTCA.1", 	
             "CLivTCA.1", 	
             "CKidTCA.1",	
             "CBldTCVG.2",
             "CLivTCVG.2",
             "CKidTCVG.2",
             "CBldTCVC.2",
             "CLivTCVC.2",
             "CKidTCVC.2",
             "CBldNAT.2",
             "CLivNAT.2",
             "CKidNAT.2",
             "CLiv.3",	
             "CKid.3",	
             "CPlasTCA.3", 	
             "CLivTCA.3", 	
             "CKidTCA.3",	
             "CBldTCVG.3",
             "CLivTCVG.3",
             "CKidTCVG.3",
             "CBldTCVC.4",
             "CLivTCVC.4",
             "CKidTCVC.4",
             "CBldNAT.4",
             "CLivNAT.4",
             "CKidNAT.4")

outputs <- c("Blood Perc-1",	#"Blood Perc-LFD",
             "Liver Perc-1",	
             "Kidney Perc-1",	
             "Fat Perc-1",	
             "Plasma TCA-1", 	
             "Liver TCA-1", 	
             "Kidney TCA-1",	
             "Blood TCVG-1",
             "Liver TCVG-1",
             "Kidney TCVG-1",
             "Blood TCVC-1",
             "Liver TCVC-1",
             "Kidney TCVC-1",
             "Blood NAcTCVC-1",
             "Liver NAcTCVC-1",
             "Kidney NAcTCVC-1",
             "Liver Perc-2",	
             "Kidney Perc-2",	
             "Plasma TCA-2", 	
             "Liver TCA-2", 	
             "Kidney TCA-2",	
             "Blood TCVG-2",
             "Liver TCVG-2",
             "Kidney TCVG-2",
             "Blood TCVC-2",
             "Liver TCVC-2",
             "Kidney TCVC-2",
             "Blood NAcTCVC-2",
             "Liver NAcTCVC-2",
             "Kidney NAcTCVC-2")
#-------------* Set model------------------------------------
mName <- "perc.v3.4"
#-------------* Set time points------------------------------------
times <- c(1,2,4,12) #,24
#*--------------------------------------------------*---------------------
#-------- eFast analysis ---------------------
set.seed(1234)
n <- 10000 #2^9 #5000  sample number
#--------* without random-phase shift------------------------------------------
# x<-rfast99(params = factors, n = n, q = q, q.arg = q.arg)
#* with random-phase shift ----------------------------------------------------
#*** "replicate" is used to do random-phase shift *** @But it might take long time if you use larger number
x <- rfast99(params = factors, n = n, q = q, q.arg = q.arg, rep = 5)
# dim(x$a)
#*--------------------------------------------------*---------------------
#----------- Generate dat file for setpoint ------------------------------------------
X <- cbind(1, apply(x$a, 3L, c))
write.table(X, file="perc.f.58p.3strains.ci95.10k.4t.dat", row.names=F, sep="\t") # generate "perc.f.58p.dat"
#*--------------------------------------------------*---------------------
#-----------Solve PK Model Through GNU MCSim--------------------------
y<-solve_mcsim(x, mName = mName, params = factors, 
               infile.name = "perc.GSA.setpoint.f.58p.in",
               setpoint.name = "perc.f.58p.3strains.ci95.10k.4t.dat",
               outfile.name = "perc.f.58p.3strains.ci95.10k.4t.out",
               vars = outputs, 
               time = times, generate.infile = F)
#*--------------------------------------------------*---------------------
#-----------Plot and Check the Parameter Sensitivity--------------------------
tell2(x, y)
print(y)
check(y)
#-----------* Plot combined SIs--------------------------
plot(y, vars = outputs[1])
#, SI.cutoff = 0.5, params=="lnQCC"
#*---------------------------------------------------------------------*---------------------
#-----------* Plot Heatmap-SI --------------------------
#-----------** Plot First order--------------------------
heat_check(y, order = "first order",
           vars = NULL, times = NULL, SI.cutoff = c(0.01, 0.05, 0.3), #
           CI.cutoff = c(0.05, 0.1),
           index = "CI", level = T, text = F)
#-----------** Plot Total order--------------------------
heat_check(y, order = "total order",
           vars = NULL, times = NULL, SI.cutoff = c(0.05, 0.3), #0.01, 
           CI.cutoff = c(0.05, 0.1),
           index = "CI", level = T, text = F)
#-----------** Plot interaction --------------------------
heat_check(y, order = "interaction",
           vars = NULL, times = NULL, SI.cutoff = c(0.05, 0.3), #0.01, 
           CI.cutoff = c(0.05, 0.1),
           index = "CI", level = T, text = F)
#*---------------------------------------------------------------------*---------------------
#-----------~|~ Plot Ranking--------------------------
#-----------~/~ Total effect--------------------------
#-----------*** Select SI--------------------------
tSI <- apply(y$tSI, 2, max)
names(tSI)
#-----------*** Melt --------------------------
tSI.melt <- melt(tSI, id = "")
#-----------*** Set cut-off--------------------------
tSI.melt$cutoff[tSI.melt$value < 0.05] <- "<0.05"
tSI.melt$cutoff[tSI.melt$value >= 0.05 & tSI.melt$value < 0.1] <- "0.05-0.1"
tSI.melt$cutoff[tSI.melt$value >= 0.1 & tSI.melt$value < 0.3] <- "0.1-0.3"
tSI.melt$cutoff[tSI.melt$value >= 0.3] <- ">0.3"
#-----------*** Order cut-off--------------------------
tSI.melt$cutoff <- factor(tSI.melt$cutoff, levels = c("<0.05","0.05-0.1","0.1-0.3",">0.3"), ordered=TRUE)
tSI.melt
#-----------*** Change class of cut-off--------------------------
class(tSI.melt$cutoff)
tSI.melt$cutoff <- as.factor(tSI.melt$cutoff)
#-----------*** Set color for cut-off--------------------------
a = c("seagreen3","cornflowerblue", "indianred1")[tSI.melt$cutoff]
a <- colorRampPalette(c("green","blue","red"))(n = 3)
a <- ifelse(tSI.melt$value < 0.5, "grey", "black")

tSI.melt$col[tSI.melt$cutoff=="<0.05"] <- "seagreen3"
tSI.melt$col[tSI.melt$cutoff=="0.05-0.3"] <- "cornflowerblue"
tSI.melt$col[tSI.melt$cutoff==">0.3"] <- "indianred1"
tSI.melt$col <- factor(tSI.melt$col, levels = c("seagreen3","cornflowerblue","indianred1"), ordered=TRUE)
#-----------*** Plot Ranking-------------------------
ggplot(data=tSI.melt, aes(x=value, y=reorder(rownames(tSI.melt), value), label=round(value, digits = 3))) +
  scale_fill_manual(values=c("seagreen3","cornflowerblue", "indianred1")) + #"grey","grey",
  scale_colour_manual(values=c("seagreen3","cornflowerblue", "indianred1")) +
  geom_point(stat = "identity") + #, fill="black", size=6
  geom_segment(aes(y = rownames(tSI.melt), x = 0, yend =rownames(tSI.melt),
                   xend = value), color = "black", linetype = "dotted") +
  geom_text(aes(label=rownames(tSI.melt), color=cutoff), check_overlap = TRUE, nudge_x = 0.2, size=3) +
  xlim(0,1) +
  geom_label(aes(fill =cutoff), colour = "white", size=2) +
  labs(y="Parameters", x="Total order Sensitivity index") + #hr days weeks position = c(1,0), nudge_x=0.01, 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        # axis.text.y = element_text(colour = a), #
        panel.background = element_rect(fill="white", colour="black"))
#*---------------------------------------------------------------------*--------------
#-----------*** Select CI--------------------------
tCI <- apply(y$tCI, 2, max)
names(tSI)
#-----------*** Melt --------------------------
tCI.melt <- melt(tCI, id = "")
#-----------*** Set cut-off--------------------------
tCI.melt$cutoff[tCI.melt$value < 0.05] <- "<0.05"
tCI.melt$cutoff[tCI.melt$value >= 0.05 & tCI.melt$value < 0.1] <- "0.05-0.1"
tCI.melt$cutoff[tCI.melt$value >= 0.1] <- ">0.1"
#-----------*** Order cut-off--------------------------
tCI.melt$cutoff <- factor(tCI.melt$cutoff, levels = c("<0.05","0.05-0.1",">0.1"), ordered=TRUE)
tCI.melt
#-----------*** Change class of cut-off--------------------------
class(tCI.melt$cutoff)
tCI.melt$cutoff <- as.factor(tCI.melt$cutoff)
#-----------*** Set color for cut-off--------------------------
a = c("seagreen3","cornflowerblue", "indianred1")[tCI.melt$cutoff]
a <- colorRampPalette(c("green","blue","red"))(n = 3)
a <- ifelse(tCI.melt$value < 0.5, "grey", "black")
#-----------*** Plot Ranking-------------------------
ggplot(data=tCI.melt, aes(x=value, y=reorder(rownames(tCI.melt), value), label=round(value, digits = 3))) +
  scale_fill_manual(values=c("grey","pink", "indianred1")) +
  scale_colour_manual(values=c("grey","pink", "indianred1")) +
  geom_point(stat = "identity") + #, fill="black", size=6
  geom_segment(aes(y = rownames(tCI.melt), x = 0, yend =rownames(tCI.melt),
                   xend = value), color = "black", linetype = "dotted") +
  geom_text(aes(label=rownames(tCI.melt), color=cutoff), check_overlap = TRUE, nudge_x = 0.02, size=3) +
  xlim(0,0.15) +
  geom_label(aes(fill =cutoff), colour = "white", size=2) +
  labs(y="Parameters", x="Total order convergence index") + #hr days weeks position = c(1,0), nudge_x=0.01, 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        # axis.text.y = element_text(colour = a), #
        panel.background = element_rect(fill="white", colour="black"))
#*---------------------------------------------------------------------*--------------
#-----------~/~ First effect--------------------------
#-----------** Select SI--------------------------
mSI <- apply(y$mSI, 2, max)
names(mSI)
#-----------*** Melt --------------------------
mSI.melt <- melt(mSI, id = "")
#-----------*** Set cut-off--------------------------
mSI.melt$cutoff[mSI.melt$value < 0.01] <- "<0.01"
mSI.melt$cutoff[mSI.melt$value >= 0.01 & mSI.melt$value < 0.05] <- "0.01-0.05"
mSI.melt$cutoff[mSI.melt$value >= 0.05 & mSI.melt$value < 0.1] <- "0.05-0.1"
mSI.melt$cutoff[mSI.melt$value >= 0.1 & mSI.melt$value < 0.3] <- "0.1-0.3"
mSI.melt$cutoff[mSI.melt$value >= 0.3] <- ">0.3"
#-----------*** Order cut-off--------------------------
mSI.melt$cutoff <- factor(mSI.melt$cutoff, levels = c("<0.01","0.01-0.05","0.05-0.1","0.1-0.3",">0.3"), ordered=TRUE)
mSI.melt
#-----------*** Change class of cut-off--------------------------
class(mSI.melt$cutoff)
mSI.melt$cutoff <- as.factor(mSI.melt$cutoff)
#-----------*** Set color for cut-off--------------------------
a = c("grey","grey50","seagreen3","cornflowerblue", "indianred1")[tSI.melt$cutoff]
a <- colorRampPalette(c("green","blue","red"))(n = 3)
a <- ifelse(tSI.melt$value < 0.5, "grey", "black")

mSI.melt$col[mSI.melt$cutoff=="<0.01"] <- "grey"
mSI.melt$col[mSI.melt$cutoff=="0.01-0.05"] <- "grey50"
mSI.melt$col[mSI.melt$cutoff=="0.05-0.3"] <- "seagreen3"
mSI.melt$col[mSI.melt$cutoff=="0.05-0.3"] <- "cornflowerblue"
mSI.melt$col[mSI.melt$cutoff==">0.3"] <- "indianred1"
mSI.melt$col <- factor(mSI.melt$col, levels = c("grey","seagreen3","cornflowerblue","indianred1"), ordered=TRUE)
#-----------*** Plot Ranking-------------------------
ggplot(data=mSI.melt, aes(x=value, y=reorder(rownames(mSI.melt), value), label=round(value, digits = 3))) +
  scale_fill_manual(values=c("grey","grey50","seagreen3","cornflowerblue", "indianred1")) +
  scale_colour_manual(values=c("grey","grey50","seagreen3","cornflowerblue", "indianred1")) +
  geom_point(stat = "identity") + #, fill="black", size=6
  geom_segment(aes(y = rownames(mSI.melt), x = 0, yend =rownames(mSI.melt),
                   xend = value), color = "black", linetype = "dotted") +
  geom_text(aes(label=rownames(mSI.melt), color=cutoff), check_overlap = TRUE, nudge_x = 0.2, size=3) +
  xlim(-0.05,0.8) +
  geom_label(aes(fill =cutoff), colour = "white", size=2) +
  labs(y="Parameters", x="First order Sensitivity index") + #hr days weeks position = c(1,0), nudge_x=0.01, 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        # axis.text.y = element_text(colour = a), #
        panel.background = element_rect(fill="white", colour="black"))
#*---------------------------------------------------------------------*--------------------------------------------
#-----------** Select CI--------------------------
mCI <- apply(y$mCI, 2, max)
names(mCI)
#-----------*** Melt --------------------------
mCI.melt <- melt(mCI, id = "")
#-----------*** Set cut-off--------------------------
mCI.melt$cutoff[mCI.melt$value < 0.05] <- "<0.05"
mCI.melt$cutoff[mCI.melt$value >= 0.05 & mCI.melt$value < 0.1] <- "0.05-0.1"
mCI.melt$cutoff[mCI.melt$value >= 0.1] <- ">0.1"
#-----------*** Order cut-off--------------------------
mCI.melt$cutoff <- factor(mCI.melt$cutoff, levels = c("<0.05","0.05-0.1",">0.1"), ordered=TRUE)
mCI.melt
#-----------*** Change class of cut-off--------------------------
class(mCI.melt$cutoff)
mCI.melt$cutoff <- as.factor(mCI.melt$cutoff)
#-----------*** Set color for cut-off--------------------------
a = c("grey","grey50","seagreen3","cornflowerblue", "indianred1")[tSI.melt$cutoff]
a <- colorRampPalette(c("green","blue","red"))(n = 3)
a <- ifelse(tSI.melt$value < 0.5, "grey", "black")
#-----------*** Plot Ranking-------------------------
ggplot(data=mCI.melt, aes(x=value, y=reorder(rownames(mCI.melt), value), label=round(value, digits = 3))) +
  scale_fill_manual(values=c("grey","pink", "indianred1")) +
  scale_colour_manual(values=c("grey","pink", "indianred1")) +
  geom_point(stat = "identity") + #, fill="black", size=6
  geom_segment(aes(y = rownames(mCI.melt), x = 0, yend =rownames(mCI.melt),
                   xend = value), color = "black", linetype = "dotted") +
  geom_text(aes(label=rownames(mCI.melt), color=cutoff), check_overlap = TRUE, nudge_x = 0.008, size=3) +
  # xlim(0,0.8) +
  geom_label(aes(fill =cutoff), colour = "white", size=2) +
  labs(y="Parameters", x="First order Convergence index") + #hr days weeks position = c(1,0), nudge_x=0.01, 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        # axis.text.y = element_text(colour = a), #
        panel.background = element_rect(fill="white", colour="black"))
#*---------------------------------------------------------------------*--------------------------------------------
#-----------~/~ Interaction--------------------------
#-----------*** Select SI--------------------------
iSI <- apply(y$iSI, 2, max)
names(iSI)
#-----------*** Melt --------------------------
iSI.melt <- melt(iSI, id = "")
#-----------*** Set cut-off--------------------------
iSI.melt$cutoff[iSI.melt$value < 0.05] <- "<0.05"
iSI.melt$cutoff[iSI.melt$value >= 0.05 & iSI.melt$value < 0.1] <- "0.05-0.1"
iSI.melt$cutoff[iSI.melt$value >= 0.1 & iSI.melt$value < 0.3] <- "0.1-0.3"
iSI.melt$cutoff[iSI.melt$value >= 0.3] <- ">0.3"
#-----------*** Order cut-off--------------------------
iSI.melt$cutoff <- factor(iSI.melt$cutoff, levels = c("<0.05","0.05-0.1","0.1-0.3",">0.3"), ordered=TRUE)
iSI.melt
#-----------*** Change class of cut-off--------------------------
class(iSI.melt$cutoff)
iSI.melt$cutoff <- as.factor(iSI.melt$cutoff)
#-----------*** Set color for cut-off--------------------------
a = c("seagreen3","cornflowerblue", "indianred1")[iSI.melt$cutoff]
a <- colorRampPalette(c("green","blue","red"))(n = 3)
a <- ifelse(iSI.melt$value < 0.5, "grey", "black")

iSI.melt$col[iSI.melt$cutoff=="<0.05"] <- "seagreen3"
iSI.melt$col[iSI.melt$cutoff=="0.05-0.3"] <- "cornflowerblue"
iSI.melt$col[iSI.melt$cutoff==">0.3"] <- "indianred1"
iSI.melt$col <- factor(iSI.melt$col, levels = c("seagreen3","cornflowerblue","indianred1"), ordered=TRUE)
#-----------*** Plot Ranking-------------------------
ggplot(data=iSI.melt, aes(x=value, y=reorder(rownames(iSI.melt), value), label=round(value, digits = 3))) +
  scale_fill_manual(values=c("seagreen3","cornflowerblue", "indianred1")) + #"grey",
  scale_colour_manual(values=c("seagreen3","cornflowerblue", "indianred1")) +
  geom_point(stat = "identity") + #, fill="black", size=6
  geom_segment(aes(y = rownames(iSI.melt), x = 0, yend =rownames(iSI.melt),
                   xend = value), color = "black", linetype = "dotted") +
  geom_text(aes(label=rownames(iSI.melt), color=cutoff), check_overlap = TRUE, nudge_x = 0.08, size=3) +
  xlim(0,0.4) +
  geom_label(aes(fill =cutoff), colour = "white", size=2) +
  labs(y="Parameters", x="Interaction Sensitivity index") + #hr days weeks position = c(1,0), nudge_x=0.01, 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        # axis.text.y = element_text(colour = a), #
        panel.background = element_rect(fill="white", colour="black"))
#*---------------------------------------------------------------------*--------------------------------------------
#-----------** Select CI--------------------------
iCI <- apply(y$iCI, 2, max)
names(iCI)
#-----------*** Melt --------------------------
iCI.melt <- melt(iCI, id = "")
#-----------*** Set cut-off--------------------------
iCI.melt$cutoff[iCI.melt$value < 0.05] <- "<0.05"
iCI.melt$cutoff[iCI.melt$value >= 0.05 & iCI.melt$value < 0.1] <- "0.05-0.1"
iCI.melt$cutoff[iCI.melt$value >= 0.1] <- ">0.1"
#-----------*** Order cut-off--------------------------
iCI.melt$cutoff <- factor(iCI.melt$cutoff, levels = c("<0.05","0.05-0.1",">0.1"), ordered=TRUE)
iCI.melt
#*---------------------------------------------------------------------*--------------
#----------- Combine Maximums-------------------------
#-----------* Add Cat.name-------------------------
tSI.melt$cat <- "tSI"
tCI.melt$cat <- "tCI"
mSI.melt$cat <- "mSI"
mCI.melt$cat <- "mCI"
iSI.melt$cat <- "iSI"
iCI.melt$cat <- "iCI"
#-----------* Rbind-------------------------
Combined.maxRank <- rbind(mSI.melt,mCI.melt, tSI.melt, tCI.melt, iSI.melt, iCI.melt)
#-----------* Write file-------------------------

write.csv(Combined.maxRank, 
          file = "perc.f.58p.3strains.ci95.10k.4t.maxRank.csv")
