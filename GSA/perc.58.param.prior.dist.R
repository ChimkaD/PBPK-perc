setwd("C:/MinGW/msys/1.0/home/wchiulab/mcsim-5.6.5/ChiuGinsbergPercModelFiles/GSA")
setwd("C:/MinGW/msys/1.0/home/chimka/Perc/GSA")

# Parameters setting
M_lnQCC <- 0.0  #0.152 #TruncNormal
sd_lnQCC <- 0.2#0.206 #
min_lnQCC <- -0.8#-0.668 #
max_lnQCC <- 0.8#0.972 #

M_lnVPRC <- -0.319 # TruncNormal
sd_lnVPRC  <- 0.27 
min_lnVPRC = -1.399 
max_lnVPRC = 0.761

# min_lnDRespC <- -11.513	 #Uniform
# max_lnDRespC <- 2.303

# ---Blood Flows to Tissues
M_QFatC <- 1.0#log(1.0)	# TruncNormal
sd_QFatC <- 0.46
min_QFatC <- 0.08#log(0.08)
max_QFatC <- 1.92#log(1.92)

M_QGutC <- 1.0#log(1.0)	# TruncNormal
sd_QGutC <- 0.17
min_QGutC <- 0.66#log(0.66)
max_QGutC <- 1.34#log(1.34)

M_QLivC <- 1.0#log(1.0)	# TruncNormal
sd_QLivC <- 0.17
min_QLivC <- 0.66#log()
max_QLivC <- 1.34#log()

M_QSlwC <- 1.0#log(1.0)	# TruncNormal
sd_QSlwC <- 0.29 
min_QSlwC <- 0.42#log()
max_QSlwC <- 1.58#log()

M_QKidC <- 1.0#log(1.0)	# TruncNormal
sd_QKidC <- 0.32
min_QKidC <- 0.36#log()
max_QKidC <- 1.64#log()

M_FracPlasC <- 0.87 #1.0#log(1.0)	# TruncNormal
sd_FracPlasC <- 0.0714 #0.2 #
min_FracPlasC <- 0.656 #0.4#log()
max_FracPlasC <- 1.084 #1.6#log()   # 1.0	0.2	0.4	1.6 # prior of TCE-2014

# ---Volumes
M_VFatC <- 1.0#log(1.0)	# TruncNormal
sd_VFatC <- 0.45
min_VFatC <- 0.1#log()
max_VFatC <- 1.9#log()

M_VGutC <- 1.0#log(1.0)	# TruncNormal
sd_VGutC <- 0.13
min_VGutC <- 0.74#log()
max_VGutC <- 1.26#log()

M_VLivC <- 1.0#log(1.0)	# TruncNormal
sd_VLivC <- 0.24
min_VLivC <- 0.52#log()
max_VLivC <- 1.48#log()

M_VRapC <- 1.0#log(1.0)	# TruncNormal
sd_VRapC <- 0.1
min_VRapC <- 0.8#log()
max_VRapC <- 1.2#log()

M_VRespLumC <-1.0#log(1.0)	# TruncNormal
sd_VRespLumC <- 0.11
min_VRespLumC <- 0.78
max_VRespLumC <- 1.22

M_VRespEffC <- 1.0#log(1.0)	# TruncNormal
sd_VRespEffC <- 0.11
min_VRespEffC <- 0.78 #log()
max_VRespEffC <- 1.22#log()

M_VKidC <- 1.0#log(1.0)	# TruncNormal
sd_VKidC <- 0.1
min_VKidC <- 0.8#log()
max_VKidC <- 1.2#log()

M_VBldC <- 1.0#log(1.0)	# TruncNormal
sd_VBldC <- 0.12
min_VBldC <- 0.76#log()
max_VBldC <- 1.24#log()

# Absorption (min, max)
#median(runif(100001, min = -7.195, max = 6.62))
M_lnkTSD <- 0.3
sd_lnkTSD <- 4.63
min_lnkTSD <- -6.571 #-4.269 #
max_lnkTSD <-  7.244  #4.942 #

M_lnkAS <- 0.3
sd_lnkAS <- 4.63
min_lnkAS <- -6.571 # exp() #0.00141
max_lnkAS <- 7.244 # exp() #1399.682

M_lnkAD <- -0.3
sd_lnkAD <- 4.6
min_lnkAD <- -7.195 # exp() #0.00075
max_lnkAD <- 6.62 # exp() #749.94

M_lnkASAq <- 0.3
sd_lnkASAq <- 4.63
min_lnkASAq <- -6.571 #-4.269 #-3.5 # exp() #0.001
max_lnkASAq <- 7.244 #4.942 #

M_lnkTSDAq <- 0.3
sd_lnkTSDAq <- 4.63
min_lnkTSDAq <- -6.571 # exp() #0.001
max_lnkTSDAq <-  7.244 # exp() #1399.682

M_lnkADAq <- -0.3
sd_lnkADAq <- 4.6
min_lnkADAq <- -7.195 # exp() #0.00075
max_lnkADAq <- 6.62 # exp() #749.94

# Sampling parameters of Tissue/blood partition coeficients for Perc and TCA (Population mean, sd, min, max)
M_PBC <- exp(0)  # TruncNormal
sd_PBC <- 0.25
min_PBC <- 0.25
max_PBC <- 1.75

M_PFatC <- exp(0)  # TruncNormal
sd_PFatC <- 0.3
min_PFatC <- 0.1
max_PFatC <- 1.9

M_lnPGutC <- 0 # TruncNormal
M_lnPLivC <- 0
M_lnPRapC <- 0
M_lnPRespC <- 0
M_lnPKidC <- 0
M_lnPSlwC <- 0
M_lnPBrnC <- 0 # Perc Brain/blood partition coeficients
M_lnPKidTCAC <- 0 #log(1)  # TCA Kidney/blood partition coeficients #- TCAPlas * exp(lnPKidTCAC) * 48.8 = TCAPlas * exp(0) * 0.74
M_lnPBrnTCAC  <- 0 #log(1)  

sd_PercTCA <- 0.4
t <- 3 #0.4

min_lnPGutC <- M_lnPGutC - t*sd_PercTCA
max_lnPGutC <- M_lnPGutC + t*sd_PercTCA 

min_lnPLivC <- M_lnPLivC - t*sd_PercTCA
max_lnPLivC <- M_lnPLivC + t*sd_PercTCA 

min_lnPRapC <- M_lnPRapC - t*sd_PercTCA
max_lnPRapC <- M_lnPRapC + t*sd_PercTCA 

min_lnPRespC <- M_lnPRespC - t*sd_PercTCA
max_lnPRespC <- M_lnPRespC + t*sd_PercTCA 

min_lnPKidC <- M_lnPKidC - t*sd_PercTCA
max_lnPKidC <- M_lnPKidC + t*sd_PercTCA 

min_lnPSlwC <- M_lnPSlwC - t*sd_PercTCA
max_lnPSlwC <- M_lnPSlwC + t*sd_PercTCA 

min_lnPBrnC <- M_lnPBrnC - t*sd_PercTCA
max_lnPBrnC <- M_lnPBrnC + t*sd_PercTCA 

min_lnPKidTCAC <- M_lnPKidTCAC - t*sd_PercTCA 
max_lnPKidTCAC <- M_lnPKidTCAC + t*sd_PercTCA

min_lnPBrnTCAC <- M_lnPBrnTCAC - t*sd_PercTCA 
max_lnPBrnTCAC <- M_lnPBrnTCAC + t*sd_PercTCA 

M_lnPRBCPlasTCAC <- 0.0
sd_lnPRBCPlasTCAC <- 3.07
min_lnPRBCPlasTCAC <- -4.605 #-0.19 #Uniform
max_lnPRBCPlasTCAC <- 4.605#1.873 #

M_lnPBodTCAC <- 0 # TruncNormal
sd_lnPBodTCAC <- 0.336
min_lnPBodTCAC <- -1.008
max_lnPBodTCAC <- 1.008

M_lnPLivTCAC <- 0 # TruncNormal
sd_lnPLivTCAC <- 0.336
min_lnPLivTCAC <- -1.008
max_lnPLivTCAC <- 1.008

M_lnkDissocC <- 0.467#0 #0.535 TruncNormal
sd_lnkDissocC <- 1.15#0.624#1.191
min_lnkDissocC <- -2.983#-1.337#-3.573
max_lnkDissocC <- 3.917#2.407#3.573

M_lnBMaxkDC <- 0.421#0.403#0 # TruncNormal
sd_lnBMaxkDC <- 0.45#0.244#0.495
min_lnBMaxkDC <- -0.929#-0.329#-1.485
max_lnBMaxkDC <- 1.771#1.135#1.485

# Sampling parameters of Tissue/blood partition coeficients for GSH-conjugation (Population mean, sd, min, max)
M_lnPBodTCVGC  <- 0 # TruncNormal
M_lnPLivTCVGC <- 0
M_lnPKidTCVGC <- 0
M_lnPBodTCVCC <- 0
M_lnPLivTCVCC <- 0
M_lnPKidTCVCC <- 0 
M_lnPBodNATC <- 0
M_lnPLivNATC <- 0
M_lnPKidNATC <- 0
sd_lnPGSHC <-  1.5#3.3334#1.5 #2.67
r <- 2#1.5
#median(runif(100001, min = -5, max = 5))
t <- 3.3334#2#2#2.667#
min_lnPBodTCVGC <- M_lnPBodTCVGC - t*sd_lnPGSHC
max_lnPBodTCVGC <- M_lnPBodTCVGC + r*sd_lnPGSHC
min_lnPLivTCVGC <- M_lnPBodTCVGC - t*sd_lnPGSHC
max_lnPLivTCVGC <- M_lnPBodTCVGC + r*sd_lnPGSHC
min_lnPKidTCVGC <- M_lnPBodTCVGC - t*sd_lnPGSHC
max_lnPKidTCVGC <- M_lnPBodTCVGC + r*sd_lnPGSHC
min_lnPBodTCVCC <- M_lnPBodTCVGC - t*sd_lnPGSHC
max_lnPBodTCVCC <- M_lnPBodTCVGC + r*sd_lnPGSHC
min_lnPLivTCVCC <- M_lnPBodTCVGC - t*sd_lnPGSHC
max_lnPLivTCVCC <- M_lnPBodTCVGC + r*sd_lnPGSHC
min_lnPKidTCVCC <- M_lnPBodTCVGC - t*sd_lnPGSHC
max_lnPKidTCVCC <- M_lnPBodTCVGC + r*sd_lnPGSHC
min_lnPBodNATC <- M_lnPBodTCVGC - t*sd_lnPGSHC
max_lnPBodNATC <- M_lnPBodTCVGC + r*sd_lnPGSHC
min_lnPLivNATC <- M_lnPBodTCVGC - t*sd_lnPGSHC
max_lnPLivNATC <- M_lnPBodTCVGC + r*sd_lnPGSHC
min_lnPKidNATC <- M_lnPBodTCVGC - t*sd_lnPGSHC
max_lnPKidNATC <- M_lnPBodTCVGC + r*sd_lnPGSHC

# Metabolism parameters (min, max)
M_lnKMC <- 0.0
sd_lnKMC <- 4.606
min_lnKMC <- -6.909 #-15# # Uniform
max_lnKMC <- 6.909 #5#10#5#10

M_lnClC <- 0.0
sd_lnClC <- 4.606
min_lnClC <- -6.909 #-4.827# #-15#-15#
max_lnClC <- 6.909 #4.827#5#15#

# min_lnKM2C <- 0#-15.1 #C&G(2011) #-6.909 -5
# max_lnKM2C <- 15.0#15.1 #6.909 # fixed at 15 to turn off liver in C(2018)

M_lnCl2OxC <- 0.0
sd_lnCl2OxC <- 4.606
min_lnCl2OxC <- -6.909 #-4.827 #-15#
max_lnCl2OxC <- 6.909 #4.827 #5#

M_lnFracOtherC <- 0.0
sd_lnFracOtherC <- 4.606
min_lnFracOtherC <- -6.908 #-6.701#-2#-10
max_lnFracOtherC <- 6.908 #-1.679#5#10

# min_lnKMKidLivC <- -15
# max_lnKMKidLivC <- 5#10
# 
# min_lnClKidLivC <- -15
# max_lnClKidLivC <- 5#10
# 
# min_lnKMRespLivC <- -15
# max_lnKMRespLivC <- 5#10
# 
# min_lnVMaxLungLivC <- -15
# max_lnVMaxLungLivC <- 5#10


# min_lnVMaxKidLivTCVGC <- -15
# max_lnVMaxKidLivTCVGC <- 5
# 
# min_lnClKidLivTCVGC <- -15#-5#
# max_lnClKidLivTCVGC <- 5#15#10#

M_lnkUrnTCAC <- -2.15
sd_lnkUrnTCAC <- 0.64
min_lnkUrnTCAC <- -3.109#-4.605 #-15 #C(2014)
max_lnkUrnTCAC <- -1.194#4.605 #5#10

#median(runif(1000001, min = -3.109, max = -1.194))

M_lnkMetTCAC <- -0.55
sd_lnkMetTCAC <- 0.5
min_lnkMetTCAC <- -1.309#-9.21 #-15
max_lnkMetTCAC <- 0.205#4.605 #5#10

# min_lnVMaxTCVGC <- 0#-10.203 #C&G(2011) #-1
# max_lnVMaxTCVGC <- 10.2 # fixed at 10.2 C(2018)

# runif(101, min = -13.8, max = 10.203)#, log = T
# median(runif(100001, min = -13.8, max = 10.203))
# sd(runif(100001, min = -13.8, max = 10.203))

#median(runif(1000001, min = -13.8, max = -0))
M_lnClTCVGC <- -6.9
sd_lnClTCVGC <- 4.6
min_lnClTCVGC <- -13.8 #C(2018) #-15
max_lnClTCVGC <- 0#10.203 #0 #C(2018) #5#0

# min_lnkTCVCC <- -15.2 #C&G(2011) fixed at -15.2 in C(2018) #-10.203
# max_lnkTCVCC <-  0#10.203 #C&G(2011) #5#10

M_lnkKidTCVCC <- 0.0
sd_lnkKidTCVCC <- 4.606
min_lnkKidTCVCC <- -6.909 #-15#
max_lnkKidTCVCC <- 6.909 #5#

# min_lnkNATC <- -15.2 # fixed at -15.2 in C(2018)
# max_lnkNATC <- 0#5#10 0#

M_lnkKidNATC <- 0.0
sd_lnkKidNATC <- 4.606
min_lnkKidNATC <- -6.909 #-10#-15#
max_lnkKidNATC <- 6.909 #10#5#

M_lnkDCAC <- 0.0
sd_lnkDCAC <- 4.606
min_lnkDCAC <-  -6.909#-8.23 #-6.7#
max_lnkDCAC <- 6.909 #24

M_lnkUrnNATC <- 0.0
sd_lnkUrnNATC <- 4.606
min_lnkUrnNATC <- -6.909 #-5#
max_lnkUrnNATC <- 6.909 #15#10#