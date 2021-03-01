# ~Parameter analysis---------------------------------
#* Set drive---------------------
#* from labtop -----------------
setwd("C:/MinGW/msys/1.0/home/chimka/Perc/48/43p")
library(reshape2)
library(ggplot2)
library(ggridges)
library(gridExtra)
library(grid)
library(png)
### **Combined parameter estimates**
#### Densities of prior and posterior parameter uncertainty distributions using random 5000 simulations
#Population parameters ------------
#*~ Pop.mean---------------------
#* Import prior mc.out------------
mc.48.out = read.delim("perc.mouse.48strains.43p.mc.out")
M48 <- mc.48.out[,c(1,2:44)]
#* Import posterior mcmc.out------------
sim.out.m = read.delim("perc.mouse.48strains.43p.mcmc.random5000.out")
mcmc.out <- sim.out.m[,c(1,2:44)]
#** Priors **--------------------
M48$Distribution <- "prior - current study"
colnames(M48) <- c("iter","lnQCC","lnVPRC","QGutC","QSlwC","VFatC","VRapC","VKidC","lnkTSD","lnkAS","lnkAD","lnkASAq","lnkTSDAq",
                   "lnkADAq","PBC","PFatC","lnPLivC","lnPRapC","lnPRespC","lnPKidC","lnPRBCPlasTCAC",
                   "lnPKidTCAC", "lnPBodTCAC","lnPLivTCAC","lnPLivTCVGC","lnPKidTCVGC","lnPBodTCVCC","lnPLivTCVCC",
                   "lnPKidTCVCC","lnPBodNATC","lnPLivNATC","lnPKidNATC","lnkDissocC","lnBMaxkDC","lnKMC","lnClC",
                   "lnClTCVGC","lnCl2OxC","lnkUrnTCAC","lnkMetTCAC","lnkKidTCVCC","lnkKidNATC","lnkDCAC","lnkUrnNATC",
                   "Distribution")#
mc.melt <- melt(M48, id = c("iter", "Distribution"))
names(mc.melt)
#** Posteriors **-----------------
mcmc.out$Distribution <- "posterior - current study"
colnames(mcmc.out) <- c("lnQCC","lnVPRC","QGutC","QSlwC","VFatC","VRapC","VKidC","lnkTSD","lnkAS","lnkAD","lnkASAq",
                        "lnkTSDAq","lnkADAq","PBC","PFatC","lnPLivC","lnPRapC","lnPRespC","lnPKidC","lnPRBCPlasTCAC",
                        "lnPKidTCAC", "lnPBodTCAC","lnPLivTCAC","lnPLivTCVGC","lnPKidTCVGC","lnPBodTCVCC","lnPLivTCVCC",
                        "lnPKidTCVCC","lnPBodNATC","lnPLivNATC","lnPKidNATC","lnkDissocC","lnBMaxkDC","lnKMC","lnClC",
                        "lnClTCVGC","lnCl2OxC","lnkUrnTCAC","lnkMetTCAC","lnkKidTCVCC","lnkKidNATC","lnkDCAC","lnkUrnNATC",
                        "Distribution")#"iter",
mcmc.melt <- melt(mcmc.out, id = c("iter", "Distribution"))
#*~ Old.model------------------------
#---------------** Import 3-diet posterior mcmc.out **------------------------------
setwd("C:/MinGW/msys/1.0/home/chimka/Perc/3-diet/terra/27p")
sim.out.27 = read.delim("perc.mouse.3strains.3diet.27p.s.mcmc.random5000.out")
names(sim.out.27)
mcmc.27.out <- sim.out.27[,c(1:28)]
mcmc.27.out$Distribution <- "posterior - Dalaijamts et al. (2020)"
colnames(mcmc.27.out) <- c("iter","lnVPRC","lnkTSD","lnkAS","lnkAD",
                           "lnkASAq","lnkTSDAq","lnkADAq",
                           "lnPBrnC","lnPKidTCAC","lnPBrnTCAC",
                           "lnPBodTCVGC","lnPLivTCVGC","lnPKidTCVGC",
                           "lnPBodTCVCC","lnPLivTCVCC","lnPKidTCVCC",
                           "lnPBodNATC","lnPLivNATC","lnPKidNATC",
                           "lnKMC","lnClC","lnClTCVGC","lnCl2OxC",
                           "lnkKidTCVCC","lnkKidNATC","lnkDCAC",
                           "lnkUrnNATC","Distribution")
head(mcmc.27.out)
mcmc.27.melt <- melt(mcmc.27.out, id = c("iter", "Distribution"))
head(mcmc.27.melt)
#---------------** Import 3-strain posterior mcmc.out **------------------------------
setwd("C:/MinGW/msys/1.0/home/chimka/Perc/3-diet/terra")
sim.out.3s = read.delim("perc.mouse.mcmc.3strains.random5000.out")
names(sim.out.3s)
strains3.out <- sim.out.3s[,c(1:28)]
strains3.out$Distribution <- "posterior - Dalaijamts et al. (2018)"
colnames(strains3.out) <- c("iter","lnVPRC","lnkTSD","lnkAS","lnkAD",
                            "lnkASAq","lnkTSDAq","lnkADAq",
                            "lnPBrnC","lnPKidTCAC","lnPBrnTCAC",
                            "lnPBodTCVGC","lnPLivTCVGC","lnPKidTCVGC",
                            "lnPBodTCVCC","lnPLivTCVCC","lnPKidTCVCC",
                            "lnPBodNATC","lnPLivNATC","lnPKidNATC",
                            "lnKMC","lnClC","lnClTCVGC","lnCl2OxC",
                            "lnkKidTCVCC","lnkKidNATC","lnkDCAC",
                            "lnkUrnNATC","Distribution")
names(strains3.out)
melt.27 <- melt(strains3.out, id = c("iter", "Distribution"))
head(melt.27)
#* Combine prior and posteriors--------------------------
mix <- rbind(M48, mcmc.out)
mix.melt <- rbind(mc.melt, mcmc.melt, mcmc.27.melt, melt.27) #
mix.melt$Distribution <- factor(mix.melt$Distribution, 
                              levels = c("prior - current study", "posterior - Dalaijamts et al. (2018)","posterior - Dalaijamts et al. (2020)","posterior - current study"), ordered=TRUE)

#* Melt data ---------------
mix.melt <- melt(mix, id = "Distribution")
#* Reverse order 43p -------------------------------
mix.melt$variable <- factor(mix.melt$variable, 
                            levels = c("lnkUrnNATC","lnkDCAC","lnkKidNATC","lnkKidTCVCC","lnkMetTCAC","lnkUrnTCAC",
                                       "lnCl2OxC","lnClTCVGC","lnClC","lnKMC","lnBMaxkDC","lnkDissocC","lnPKidNATC",
                                       "lnPLivNATC","lnPBodNATC","lnPKidTCVCC","lnPLivTCVCC","lnPBodTCVCC","lnPKidTCVGC",
                                       "lnPLivTCVGC","lnPLivTCAC","lnPBodTCAC","lnPKidTCAC","lnPRBCPlasTCAC","lnPKidC",
                                       "lnPRespC","lnPRapC","lnPLivC","PFatC","lnPBrnC","PBC","lnkADAq","lnkTSDAq","lnkASAq","lnkAD",
                                       "lnkAS","lnkTSD","VKidC","VRapC","VFatC","QSlwC","QGutC","lnVPRC","lnQCC"), ordered=TRUE)
mix.melt$Distribution <- factor(mix.melt$Distribution, levels = c("prior","posterior"), ordered=TRUE)
head(mix.melt)
mix.melt1 <- subset(mix.melt, variable != "NA")
mix.melt <- subset(mix.melt1, variable != "lnPBrnC")
#* Plot Pop.mean ** ---------------------------
p1 <-
  ggplot(data=mix.melt, aes(x = value, y = variable)) + 
  geom_density_ridges2(aes(fill = Distribution, colour = Distribution),
                       alpha = .7, size = 0.5, scale = 3.5, rel_min_height = .01) + 
  # geom_point(data=mle.m, aes(x = median, y = parameters, colour=Distribution), shape=19, size = 3) +
  theme_ridges(grid = FALSE, font_size = 10) + 
  labs(x = "", y = "Parameters", title = "(A)") +
  scale_y_discrete() +
  scale_colour_manual(values=c("turquoise3","pink","orchid3","orchid3")) + #"black","deeppink2","springgreen4"
  scale_fill_manual(values = c("turquoise1","pink",NA,"orchid1")) + #,"hotpink","springgreen"azure2
  theme_ridges(grid = FALSE) + #, font_size = 11
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.y = element_text(hjust = 0.5,size=11),
        axis.text.y = element_text(size=9),
        legend.position=c(-0.2, -0.06), #none, "bottom",
        legend.direction="horizontal",
        legend.text  = element_text(size=10),
        legend.title = element_text(size=10,face = "bold"),
        legend.background = element_rect(fill="white"), 
        # size=0.5, linetype="solid")
        plot.margin = unit(c(0,0,0,0), "cm"),
        panel.grid.major.y = element_line(colour = "black", size=0.2),
        panel.grid.major.x = element_blank())

#*~ Pop.variability---------------------
#** Prior **----------------
V <- mc.48.out[,c(45:87)]
sd <- data.frame(sqrt(V))
sd$Distribution <- "prior"
colnames(sd) <- c("lnQCC","lnVPRC","QGutC","QSlwC","VFatC","VRapC","VKidC","lnkTSD","lnkAS","lnkAD","lnkASAq","lnkTSDAq",
                  "lnkADAq","PBC","PFatC","lnPLivC","lnPRapC","lnPRespC","lnPKidC","lnPRBCPlasTCAC",
                  "lnPKidTCAC", "lnPBodTCAC","lnPLivTCAC","lnPLivTCVGC","lnPKidTCVGC","lnPBodTCVCC","lnPLivTCVCC",
                  "lnPKidTCVCC","lnPBodNATC","lnPLivNATC","lnPKidNATC","lnkDissocC","lnBMaxkDC","lnKMC","lnClC",
                  "lnClTCVGC","lnCl2OxC","lnkUrnTCAC","lnkMetTCAC","lnkKidTCVCC","lnkKidNATC","lnkDCAC","lnkUrnNATC",
                  "Distribution")
#** Posterior**----------------
mcmc.v <- sim.out.m[,c(45:87)]
mcmc.sd <- data.frame(sqrt(mcmc.v))
mcmc.sd$Distribution <- "posterior"
colnames(mcmc.sd) <- c("lnQCC","lnVPRC","QGutC","QSlwC","VFatC","VRapC","VKidC","lnkTSD","lnkAS","lnkAD","lnkASAq","lnkTSDAq",
                       "lnkADAq","PBC","PFatC","lnPLivC","lnPRapC","lnPRespC","lnPKidC","lnPRBCPlasTCAC",
                       "lnPKidTCAC", "lnPBodTCAC","lnPLivTCAC","lnPLivTCVGC","lnPKidTCVGC","lnPBodTCVCC","lnPLivTCVCC",
                       "lnPKidTCVCC","lnPBodNATC","lnPLivNATC","lnPKidNATC","lnkDissocC","lnBMaxkDC","lnKMC","lnClC",
                       "lnClTCVGC","lnCl2OxC","lnkUrnTCAC","lnkMetTCAC","lnkKidTCVCC","lnkKidNATC","lnkDCAC","lnkUrnNATC",
                       "Distribution")
#* Combine sd prior + poster-------------------------
mix.v <- rbind(sd, mcmc.sd)
mix.melt.v <- melt(mix.v, id = "Distribution")
#* Reverse order 43p -------------------------------
mix.melt.v$variable <- factor(mix.melt.v$variable, 
                              levels = c("lnkUrnNATC","lnkDCAC","lnkKidNATC","lnkKidTCVCC","lnkMetTCAC","lnkUrnTCAC",
                                         "lnCl2OxC","lnClTCVGC","lnClC","lnKMC","lnBMaxkDC","lnkDissocC","lnPKidNATC",
                                         "lnPLivNATC","lnPBodNATC","lnPKidTCVCC","lnPLivTCVCC","lnPBodTCVCC","lnPKidTCVGC",
                                         "lnPLivTCVGC","lnPLivTCAC","lnPBodTCAC","lnPKidTCAC","lnPRBCPlasTCAC","lnPKidC",
                                         "lnPRespC","lnPRapC","lnPLivC","PFatC","PBC","lnkADAq","lnkTSDAq","lnkASAq","lnkAD",
                                         "lnkAS","lnkTSD","VKidC","VRapC","VFatC","QSlwC","QGutC","lnVPRC","lnQCC"),
                              ordered=TRUE)
mix.melt.v$Distribution <- factor(mix.melt.v$Distribution, levels = c("prior","posterior"), ordered=TRUE)
#* Plot Pop.sd **---------------
p2 <-
  ggplot(data=mix.melt.v, aes(x = value, y = variable)) + 
  geom_density_ridges(aes(fill = Distribution, colour = Distribution),
                      alpha = .7, size = 0.5, scale = 3.5, rel_min_height = .025) + 
  theme_ridges(grid = FALSE) + 
  labs(x = "", y = "", title = "(B)") +
  scale_y_discrete(position = "left") +
  scale_x_continuous(limits = c(-0.1, 3)) +
  scale_colour_manual(values=c("turquoise3","orchid3")) + #"black","deeppink2","springgreen4"
  scale_fill_manual(values = c("turquoise1","orchid1")) + #,"hotpink","springgreen"
  theme_ridges(grid = FALSE) +
  theme(plot.title = element_text(hjust = 0.5, vjust = 4.5),
        axis.title.y = element_blank(),#axis.title.y = element_text(hjust = 0.5),
        axis.text.y = element_blank(),
        legend.position= "none",#c(0.7,0.5),
        legend.background=element_rect(fill = "white"),
        plot.margin = unit(c(0.45,0.2,0,0), "cm"),
        panel.grid.major.y = element_line(colour = "black", size=0.2),
        panel.grid.major.x = element_blank())
#~/~ Plot Pop.Mean & sd **---------------
jpeg(filename = "C:/Users/chimka/Documents/TAMU/PERC/Manuscript_CC45/New figs&Tables/Fig. S-8.jpg",
     width = 10, height = 8, units = "in", pointsize = 8,
     bg = "white", res = 300)
grid.arrange(p1, p2, widths =c(1.2/2,0.8/2), ncol=2, bottom = "parameter values")
dev.off()

#SS parameters----------------------------
mcmc.out <- sim.out.m[,c(1,112:2175)]
output.dat <- melt(mcmc.out, id = "iter")
output.dat$conc.time <-as.character(levels(output.dat$variable))[output.dat$variable]
output.dat$variable <- NULL
Conc1.splt <- data.frame(output.dat$iter, output.dat$value, 
                         do.call("rbind",strsplit(output.dat$conc.time,"\\.")))
rm(Conc1.splt)
colnames(Conc1.splt) <- c("iter" ,"conc", "parameter", "N","strain")
Conc1.splt$N <- NULL
out.dat <- Conc1.splt[c(1,4,3,2)]
out.dat$strain <-as.numeric(out.dat$strain)
#* Reverse order 43p -------------------------------
out.dat$parameter <- factor(out.dat$parameter, 
                         levels =c("lnQCC","lnVPRC","QGutC","QSlwC","VFatC","VRapC","VKidC","lnkTSD","lnkAS","lnkAD",
                                   "lnkASAq","lnkTSDAq","lnkADAq","PBC","PFatC","lnPLivC","lnPRapC","lnPRespC","lnPKidC",
                                   "lnPRBCPlasTCAC","lnPKidTCAC","lnPBodTCAC","lnPLivTCAC",
                                   "lnPLivTCVGC","lnPKidTCVGC","lnPBodTCVCC","lnPLivTCVCC","lnPKidTCVCC","lnPBodNATC",
                                   "lnPLivNATC","lnPKidNATC","lnkDissocC","lnBMaxkDC","lnKMC","lnClC","lnClTCVGC",
                                   "lnCl2OxC","lnkUrnTCAC","lnkMetTCAC","lnkKidTCVCC","lnkKidNATC","lnkDCAC",
                                   "lnkUrnNATC"), ordered=TRUE)
#* Rename strains -------------
out.dat$strains[out.dat$strain==1] <- "B6C3F1"
out.dat$strains[out.dat$strain==2] <- "SW"
out.dat$strains[out.dat$strain==3] <- "C57Bl/6J"
# remove 1st 3 strains
out.data1 <- subset(out.dat, !strain < 4)
out.data1$strains <- out.data1$strain - 3
out.data2 <- subset(out.dat, strain == 1)
out.data3 <- subset(out.dat, strain == 2)
out.data4 <- subset(out.dat, strain == 3)
rm(out.dat)
# Insert Legend of 3 strains to the SS plot
img <- png::readPNG("Legend.png")
g_pic <- rasterGrob(img, x = 0.25, y = 0.09, w=.09, interpolate=FALSE) # width = 2, height = 2, x=1:1.5, y=1:1.5,
#-------------~/~ Plot 3 + 45 strains***--------
jpeg(filename = "C:/Users/chimka/Documents/TAMU/PERC/Manuscript_CC45/New figs&Tables/Fig. S-9.jpg",
     width = 10, height = 8, units = "in", pointsize = 8,
     bg = "white", res = 300)
ggplot(data=out.data1, aes(x = conc)) +  
  geom_density(aes(fill = factor(strains), colour = factor(strains)), alpha = .4, adjust = 3, trim = TRUE) + 
  labs(x = "", y = "Density", title = "",fill = "CC mouse strains",colour = "CC mouse strains") +
  geom_density(data=out.data2, colour = "darkslateblue", fill = "darkslateblue", alpha = .4, adjust = 3, size=0.8, trim = TRUE) + #mediumpurple4
  geom_density(data=out.data3, colour = "cyan", fill = "cyan", alpha = .4, adjust = 3, size=0.8, trim = TRUE) +
  facet_wrap(~parameter, scales = "free", ncol = 6, dir="h", strip.position = "top") +
  # annotation_custom(rasterGrob(img, interpolate=FALSE), xmin=0.15, xmax=1.5, ymin=0.05, ymax=0.2) +
  guides(fill = guide_legend(direction = "horizontal", title.position = "top", ncol = 15),
         colour = guide_legend(direction = "horizontal", title.position = "top", ncol = 15)) +
  theme_ridges(grid = FALSE, font_size = 10) +
  theme(plot.title = element_text(hjust = 0.5),
        strip.text.y = element_text(),#hjust = 0.5, 
        strip.background = element_rect(fill="white", colour="white"),
        axis.title.y = element_text(hjust = 0.5),
        axis.text = element_text(size=6),
        axis.line.x = element_line(colour = "black"),#element_blank(),
        legend.title = element_text(size=11),
        legend.text = element_text(size=9),
        legend.position=c(0.3, 0.05),
        panel.grid.major.x = element_blank())
# Add legend to 3 strains:
print(grid.draw(g_pic), newpage=FALSE)
dev.off()

rm(y4)
gc()
names(out.dat)
#* Summarize SS-parameter--------------------
out.dat$gm <- exp(out.dat$conc)
head(out.dat)
GM.sum = ddply(out.dat, .(strain, parameter), function(out.dat){
  median=median(out.dat$gm, na.rm = TRUE)})
head(GM.sum)
colnames(GM.sum) <- c("strain", "parameter","median")
library(plyr)
#** Move rows to columns-----------------------
Sum.SS <-reshape(GM.sum,timevar="strain",idvar="parameter",direction="wide")
#** Summarize min/max--------------------
SS.sum = ddply(GM.sum, .(parameter), function(GM.sum){
  c(min=min(GM.sum$median, na.rm = TRUE),
    max=max(GM.sum$median, na.rm = TRUE),
    diff=m)})
SS.sum$diff <- SS.sum$max/SS.sum$min
head(SS.sum)
write.csv(GM.sum, 
          file = "Sum.SS.csv")
#* Combine tables---------------------
SS <- cbind(Sum.SS,SS.sum)
write.csv(SS, 
          file = "Sum.SS.csv")
#_____________________________________________________________________________________________________
#--------Summarize Posterior distribution----------
library(plyr)
mcmc.out <- sim.out.m[,c(1:87)]
output.dat <- melt(mcmc.out, id = "iter")
output.dat$conc.time <-as.character(levels(output.dat$variable))[output.dat$variable]
output.dat$variable <- NULL
Conc1.splt <- data.frame(output.dat$iter, output.dat$value, 
                         do.call("rbind",strsplit(output.dat$conc.time,"\\.")))
head(Conc1.splt)
colnames(Conc1.splt) <- c("iter" ,"conc", "parameter", "N")
Conc1.splt$N <- NULL

Conc.splt <- data.frame(Conc1.splt$iter, Conc1.splt$conc, 
                        do.call("rbind",strsplit(as.character(Conc1.splt$parameter),'_',fixed=TRUE)))
colnames(Conc.splt) <- c("iter" ,"conc", "pop", "parameter")
out.dat <- Conc.splt[c(1,3,4,2)]
out.dat$pop[out.dat$pop=="M"] <- "Population mean"
out.dat$pop[out.dat$pop=="V"] <- "Population SD"
#* Reverse order 43p -------------------------------
out.dat$parameter <- factor(out.dat$parameter, 
                            levels =c("lnQCC","lnVPRC","QGutC","QSlwC","VFatC","VRapC","VKidC","lnkTSD","lnkAS","lnkAD",
                                      "lnkASAq","lnkTSDAq","lnkADAq","PBC","PFatC","lnPLivC","lnPRapC","lnPRespC","lnPKidC",
                                      "lnPRBCPlasTCAC","lnPKidTCAC","lnPBodTCAC","lnPLivTCAC",
                                      "lnPLivTCVGC","lnPKidTCVGC","lnPBodTCVCC","lnPLivTCVCC","lnPKidTCVCC","lnPBodNATC",
                                      "lnPLivNATC","lnPKidNATC","lnkDissocC","lnBMaxkDC","lnKMC","lnClC","lnClTCVGC",
                                      "lnCl2OxC","lnkUrnTCAC","lnkMetTCAC","lnkKidTCVCC","lnkKidNATC","lnkDCAC",
                                      "lnkUrnNATC"), ordered=TRUE)

tail(out.dat)
#Summarize original data
Out.sum = ddply(out.dat, .(strain, tissue), function(out.dat){
  c(median=median(out.dat$conc, na.rm = TRUE), 
    low = quantile(out.dat$conc, 0.025, na.rm = TRUE),
    up = quantile(out.dat$conc, 0.975, na.rm = TRUE))
})
head(Out.sum)
write.csv(Out.sum, 
          file = "Sampling coef.43p.sum.csv")
#Summarize GM data
out.dat$gm <- exp(out.dat$conc)
head(out.dat)
GM.sum = ddply(out.dat, .(pop, parameter), function(out.dat){
  c(median=median(out.dat$gm, na.rm = TRUE), 
    low = quantile(out.dat$gm, 0.025, na.rm = TRUE),
    up = quantile(out.dat$gm, 0.975, na.rm = TRUE))
})
head(GM.sum)
colnames(GM.sum) <- c("pop", "parameter","median" ,"low", "up")
#--------/~/ Create combined table----------
GM.sum$low1 <- paste("(",format(GM.sum$low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
GM.sum$up1 <- paste(format(GM.sum$up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
GM.sum$CI <- paste(GM.sum$low1,GM.sum$up1, sep =", ")
GM.sum$Comb <- paste(format(GM.sum$median, digits = 2, scientific = TRUE),GM.sum$CI)
#Combine original format
GM.sum$low2 <- paste("(",round(GM.sum$low, 2),sep = "",collapse = NULL)
GM.sum$up2 <- paste(round(GM.sum$up, 2), ")",sep = "",collapse = NULL)
GM.sum$CI1 <- paste(GM.sum$low2,GM.sum$up2, sep =", ")
GM.sum$Comb1 <- paste(round(GM.sum$median, 2),GM.sum$CI1)

AUC.sum$GM.low <- paste("(",format(AUC.sum$GM.low, digits = 2, scientific = TRUE),sep = "",collapse = NULL)
AUC.sum$GM.up <- paste(format(AUC.sum$GM.up, digits = 2, scientific = TRUE), ")",sep = "",collapse = NULL)
AUC.sum$CI1 <- paste(AUC.sum$GM.low,AUC.sum$GM.up, sep =", ")
AUC.sum$GM <- paste(format(AUC.sum$GM.m, digits = 2, scientific = TRUE), AUC.sum$CI1)
AUC.sum1 <- subset(AUC.sum, select = c(chemical, tissue, GM))

names(GM.sum)
write.csv(GM.sum[,c(1,2,13)], 
          file = "Sum.GM.csv")
#_______________________________________________________________________________________________________________________
#Convergence - Gelman diagnosis -  original 60k + restarted 60k---------------------
install.packages("coda")
library(coda)
# Read MCMC chains
x1 = as.mcmc(read.table(file="perc.mouse.48strains.43p.mcmc.1.60.out", header=T)[3001:12001,])
x2 = as.mcmc(read.table(file="perc.mouse.48strains.43p.mcmc.2.60.out", header=T)[3001:12001,])
x3 = as.mcmc(read.table(file="perc.mouse.48strains.43p.mcmc.3.60.out", header=T)[3001:12001,])
x4 = as.mcmc(read.table(file="perc.mouse.48strains.43p.mcmc.4.60.out", header=T)[3001:12001,])
#* Pop.mean--------------
x1m <- x1[,2:44, drop=FALSE]
x2m <- x2[,2:44, drop=FALSE]
x3m <- x3[,2:44, drop=FALSE]
x4m <- x4[,2:44, drop=FALSE]
combinedchains = mcmc.list(x1m, x2m, x3m, x4m)
gelman.diag(combinedchains)

rm(list=c("out1", "out2", "out3", "out4", "df"))
#* Pop.sd--------------
x1v <- x1[,45:87, drop=FALSE]
x2v <- x2[,45:87, drop=FALSE]
x3v <- x3[,45:87, drop=FALSE]
x4v <- x4[,45:87, drop=FALSE]
combinedchainsv = mcmc.list(x1v, x2v, x3v, x4v)
gelman.diag(combinedchainsv)

#_______________________________________________________________________________________________________________________
#----------- Residual error input from posterior mcmc.out----------------------------------------------------------------
#_______________________________________________________________________________________________________________________
names(sim.out.m)
Ve <- sim.out.m[,c(1,88:111)]
names(Ve)
SD.Ve <- data.frame(sqrt(Ve))
GSD.Ve <- data.frame(exp(SD.Ve))
GSD.Ve <- data.frame(exp(Ve))
#_______________________________________________________________________________________________________________________
names(GSD.Ve)
colnames(GSD.Ve) <- c("iter","Inhaled.Perc.conc","Blood.Perc","Blood.TCA","Plasma.TCA","Plasma.TCA.free","Retained.dose",
                      "Frac.Ret.dose.metabolized","Perc.Exhal.Rate","Fat.Perc","Liver.Perc","Kidney.Perc",
                      "Brain.Perc","Liver.TCA","Kidney.TCA","Brain.TCA","Blood.TCVG","Liver.TCVG","Kidney.TCVG",
                      "Blood.TCVC","Liver.TCVC","Kidney.TCVC","Blood.NATCVC","Liver.NATCVC","Kidney.NATCVC")

colnames(GSD.Ve) <- c("iter","Blood.Perc","Blood.TCA","Plasma.TCA","Fat.Perc","Liver.Perc","Kidney.Perc",
                      "Brain.Perc","Liver.TCA","Kidney.TCA","Brain.TCA","Blood.TCVG","Liver.TCVG","Kidney.TCVG",
                      "Blood.TCVC","Liver.TCVC","Kidney.TCVC","Blood.NATCVC","Liver.NATCVC","Kidney.NATCVC")

melt.Ve <- melt(GSD.Ve, id = "iter")
melt.Ve$variable <- factor(melt.Ve$variable, 
                           levels = c("Kidney.NATCVC","Liver.NATCVC","Blood.NATCVC","Kidney.TCVC","Liver.TCVC",
                                      "Blood.TCVC","Kidney.TCVG","Liver.TCVG","Blood.TCVG","Brain.TCA","Kidney.TCA",
                                      "Liver.TCA","Plasma.TCA.free","Plasma.TCA","Blood.TCA","Brain.Perc","Fat.Perc",
                                      "Kidney.Perc","Liver.Perc","Blood.Perc","Perc.Exhal.Rate",
                                      "Frac.Ret.dose.metabolized","Retained.dose","Inhaled.Perc.conc"), ordered=TRUE)
head(melt.Ve)
names(melt.Ve)
#plot Density
jpeg(filename = "C:/Users/CDalaijamts/Documents/Lab/PERC/Manuscript_45/Fig. 6b.jpg",
     width = 5, height = 6, units = "in", pointsize = 8,
     bg = "white", res = 300)
ggplot(data=melt.Ve, aes(x = value, y = variable)) + 
  geom_density_ridges(alpha = 1, size = 0.6, scale = 3, rel_min_height = .025) +
  # geom_point(data=mle.Ve, aes(x = median, y = parameters), shape=19, size = 2) +
  geom_vline(xintercept = 3, col="red", linetype="dashed") +
  labs(x = "GSD distribution", y = "Tissue chemicals", title = "(B)") +
  scale_y_discrete() +
  scale_x_continuous(limits = c(1, 3)) +#
  # scale_colour_manual(values=c("deeppink2")) +
  # scale_fill_manual(values = c("deeppink")) +
  theme_ridges(grid = FALSE, font_size = 11) +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 18),
        axis.title.y = element_text(hjust = 0.5),
        axis.title.x = element_text(hjust = 0.5),
        axis.text.y = element_text(size=10),
        panel.grid.major.y = element_line(colour = "black"),
        panel.grid.major.x = element_blank())
dev.off()
#_______________________________________________________________________________________________________________________

post.Ve <- do.call(data.frame, 
                   list(mean = apply(GSD.Ve, 2, mean),
                        sd = apply(GSD.Ve, 2, sd),
                        Q.025 = apply(GSD.Ve, 2, quantile, probs=0.025),
                        median = apply(GSD.Ve, 2, median),
                        Q.975 = apply(GSD.Ve, 2, quantile, probs=0.975),
                        min = apply(GSD.Ve, 2, min),
                        max = apply(GSD.Ve, 2, max)))
post.Ve <- do.call(data.frame, 
                   list(mean = apply(Ve, 2, mean),
                        sd = apply(Ve, 2, sd),
                        Q.025 = apply(Ve, 2, quantile, probs=0.025),
                        median = apply(Ve, 2, median),
                        Q.975 = apply(Ve, 2, quantile, probs=0.975),
                        min = apply(Ve, 2, min),
                        max = apply(Ve, 2, max)))
post.Ve$parameters <- c("CInhPPM","CVen","CBldTCA","CPlasTCA","CPlasTCAfree","RetDose","FracRetMetab","zRAExh","CFat",
                        "CLiv","CKid","CBrn","CLivTCA","CKidTCA","CBrnTCA","CBldTCVG","CLivTCVG","CKidTCVG","CBldTCVC",
                        "CLivTCVC","CKidTCVC","CBldNAT","CLivNAT","CKidNAT")

post.Ve$parameters <- c("Inhaled.Perc.conc","Blood.Perc","Blood.TCA","Plasma.TCA","Plasma.TCA.free","Retained.dose",
                        "Frac.Ret.dose.metabolized","Perc.Exhal.Rate","Fat.Perc","Liver.Perc","Kidney.Perc",
                        "Brain.Perc","Liver.TCA","Kidney.TCA","Brain.TCA","Blood.TCVG","Liver.TCVG","Kidney.TCVG",
                        "Blood.TCVC","Liver.TCVC","Kidney.TCVC","Blood.NATCVC","Liver.NATCVC","Kidney.NATCVC")
post.Ve$Distribution <- "posterior"

write.csv(post.Ve, 
          file = "c:/MinGW/msys/1.0/home/wchiulab/mcsim-5.6.5/ChiuGinsbergPercModelFiles/perc.v3.3/perc.mouse.mcmc.3strains.GSD.Ve.csv")