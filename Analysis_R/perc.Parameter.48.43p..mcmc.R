# ~Parameter analysis---------------------------------
#* Set drive---------------------

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
setwd("C:/MinGW/msys/1.0/home/~")
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
setwd("C:/MinGW/msys/1.0/home/~")
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
jpeg(filename = "~/Fig. S-8.jpg",
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
jpeg(filename = "~/Fig. S-9.jpg",
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
