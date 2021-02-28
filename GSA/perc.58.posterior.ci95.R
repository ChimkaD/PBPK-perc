# 58 parameter MCMC posterior distributions for GSA

# Parameters setting
M_lnQCC <- 0.33 #TruncNormal
sd_lnQCC <- 0.142
min_lnQCC <- 0.037 #0.04 2.5%
max_lnQCC <- 0.6 #0.6 97.5%

M_lnVPRC <- -0.237 # TruncNormal
sd_lnVPRC  <- 0.123 
min_lnVPRC = -0.481 
max_lnVPRC = 0.003

# ---Blood Flows to Tissues
M_QFatC <- 0.83 # 1.0#log(1.0)	# TruncNormal
sd_QFatC <- 0.325 #0.46
min_QFatC <- 0.211#log(0.08)
max_QFatC <- 1.496#log(1.92)

M_QGutC <- 1 #1.0#log(1.0)	# TruncNormal
sd_QGutC <- 0.147#0.17
min_QGutC <- 0.713#0.66#log(0.66)
max_QGutC <- 1.277#1.34#log(1.34)

M_QLivC <- 1.0#log(1.0)	# TruncNormal
sd_QLivC <- 0.15#0.17
min_QLivC <- 0.715#log()
max_QLivC <- 1.28#log()

M_QSlwC <- 1.0#log(1.0)	# TruncNormal
sd_QSlwC <- 0.241#0.29 
min_QSlwC <- 0.58#log()
max_QSlwC <- 1.52#log()

M_QKidC <- 1.22#log(1.0)	# TruncNormal
sd_QKidC <- 0.232
min_QKidC <- 0.733#log()
max_QKidC <- 1.604#log()

M_FracPlasC <- 0.87 #1.0#log(1.0)	# TruncNormal
sd_FracPlasC <- 0.07 #0.2
min_FracPlasC <- 0.73 #0.4#log()
max_FracPlasC <- 1.008 #1.6#log()

# ---Volumes
M_VFatC <- 0.887#log(1.0)	# TruncNormal
sd_VFatC <- 0.337
min_VFatC <- 0.249#log()
max_VFatC <- 1.573#log()

M_VGutC <- 0.994#log(1.0)	# TruncNormal
sd_VGutC <- 0.114
min_VGutC <- 0.777#log()
max_VGutC <- 1.216#log()

M_VLivC <- 0.872#log(1.0)	# TruncNormal
sd_VLivC <- 0.198
min_VLivC <- 0.555#log()
max_VLivC <- 1.317#log()

M_VRapC <- 1.0#log(1.0)	# TruncNormal
sd_VRapC <- 0.09
min_VRapC <- 0.835#log()
max_VRapC <- 1.169#log()

M_VRespLumC <-1.0#log(1.0)	# TruncNormal
sd_VRespLumC <- 0.1
min_VRespLumC <- 0.811
max_VRespLumC <- 1.184

M_VRespEffC <- 1.0#log(1.0)	# TruncNormal
sd_VRespEffC <- 0.1
min_VRespEffC <- 0.814 #log()
max_VRespEffC <- 1.181#log()

M_VKidC <- 1.0#log(1.0)	# TruncNormal
sd_VKidC <- 0.087
min_VKidC <- 0.83#log()
max_VKidC <- 1.163#log()

M_VBldC <- 1.0#log(1.0)	# TruncNormal
sd_VBldC <- 0.106
min_VBldC <- 0.796#log()
max_VBldC <- 1.201#log()

# Absorption (min, max)
#median(runif(100001, min = -7.195, max = 6.62))
M_lnkTSD <- -0.253 #0.3
sd_lnkTSD <- 3.9#4.63
min_lnkTSD <- -6.225 #-4.269 #
max_lnkTSD <-  6.81  #4.942 #

M_lnkAS <- -2.158#0.3
sd_lnkAS <- 2.5#4.63
min_lnkAS <- -6.267 # exp() #0.00141
max_lnkAS <- 3.404 # exp() #1399.682

M_lnkAD <- -0.025#-0.113
sd_lnkAD <- 3.187#4.6
min_lnkAD <- -6.088 # exp() #0.00075
max_lnkAD <- 6.192 # exp() #749.94

M_lnkASAq <- 4.152#0.3
sd_lnkASAq <- 1.76#4.63
min_lnkASAq <- 0.457#-6.571 #-4.269 #-3.5 # exp() #0.001
max_lnkASAq <- 7.033 #4.942 #

M_lnkTSDAq <- 5.145#0.3
sd_lnkTSDAq <- 1.525#4.63
min_lnkTSDAq <- 1.69#-6.571 # exp() #0.001
max_lnkTSDAq <-  7.15 # exp() #1399.682

M_lnkADAq <- -2#-0.3
sd_lnkADAq <- 1.318#4.6
min_lnkADAq <- -4.9 # exp() #0.00075
max_lnkADAq <- 0.642 # exp() #749.94

# Sampling parameters of Tissue/blood partition coeficients for Perc and TCA (Population mean, sd, min, max)
M_PBC <- 1.1#exp(0)  # TruncNormal
sd_PBC <- 0.284#exp(0.25)
min_PBC <- 0.561#exp(-0.75)
max_PBC <- 1.68#exp(0.75)

M_PFatC <- 0.84#exp(0)  # TruncNormal
sd_PFatC <- 0.3#exp(0.3)
min_PFatC <- 0.434#exp(-0.9)
max_PFatC <- 1.538#exp(0.9)

M_lnPGutC <- -0.087#0 # TruncNormal
sd_lnPGutC <- 0.374#0.4
min_lnPGutC <- -0.815
max_lnPGutC <- 0.66

M_lnPLivC <- 0.203
sd_lnPLivC <- 0.278
min_lnPLivC <- -0.363
max_lnPLivC <- 0.745

M_lnPRapC <- 0.072
sd_lnPRapC <- 0.402
min_lnPRapC <- -0.72
max_lnPRapC <- 0.871

M_lnPRespC <- 0.227
sd_lnPRespC <- 0.4
min_lnPRespC <- -0.59
max_lnPRespC <- 0.986
  
M_lnPKidC <- 0.34
sd_lnPKidC <- 0.284
min_lnPKidC <- -0.253
max_lnPKidC <- 0.882
  
M_lnPSlwC <- 0.03
sd_lnPSlwC <- 0.3
min_lnPSlwC <- -0.581
max_lnPSlwC <- 0.608
  
M_lnPBrnC <- 0
sd_lnPBrnC <- 0.4
min_lnPBrnC <- -0.773
max_lnPBrnC <- 0.775
  
M_lnPKidTCAC <- -0.11
sd_lnPKidTCAC <- 0.28
min_lnPKidTCAC <- -0.66
max_lnPKidTCAC <- 0.438
  
M_lnPBrnTCAC  <- 0
sd_lnPBrnTCAC <- 0.4
min_lnPBrnTCAC <- -0.767
max_lnPBrnTCAC <- 0.774

M_lnPRBCPlasTCAC <- 0.56
sd_lnPRBCPlasTCAC <- 0.48
min_lnPRBCPlasTCAC <- -0.158# Uniform
max_lnPRBCPlasTCAC <- 1.603

M_lnPBodTCAC <- 0 # TruncNormal
sd_lnPBodTCAC <- 0.258
min_lnPBodTCAC <- -0.494
max_lnPBodTCAC <- 0.512

M_lnPLivTCAC <- -0.067 # TruncNormal
sd_lnPLivTCAC <- 0.216
min_lnPLivTCAC <- -0.485
max_lnPLivTCAC <- 0.363

M_lnkDissocC <- 0.524#0 # TruncNormal
sd_lnkDissocC <- 0.548#1.191
min_lnkDissocC <- -0.555#-3.573
max_lnkDissocC <- 1.571#3.573

M_lnBMaxkDC <- 0.488#0 # TruncNormal
sd_lnBMaxkDC <- 0.224#0.495
min_lnBMaxkDC <- 0.043#-1.485
max_lnBMaxkDC <- 0.92#1.485

# Sampling parameters of Tissue/blood partition coeficients for GSH-conjugation (Population mean, sd, min, max)
M_lnPBodTCVGC  <- -1.224
sd_lnPBodTCVGC <- 1.1
min_lnPBodTCVGC <- -3.512
max_lnPBodTCVGC <- 0.8

M_lnPLivTCVGC <- 2.458
sd_lnPLivTCVGC <- 0.392
min_lnPLivTCVGC <- -1.517
max_lnPLivTCVGC <- 2.973

M_lnPKidTCVGC <- 2.04
sd_lnPKidTCVGC <- 0.57
min_lnPKidTCVGC <- 0.827
max_lnPKidTCVGC <- 2.932

M_lnPBodTCVCC <- -1.6
sd_lnPBodTCVCC <- 1
min_lnPBodTCVCC <- -3.82
max_lnPBodTCVCC <- 0.173

M_lnPLivTCVCC <- -1.222
sd_lnPLivTCVCC <- 0.531
min_lnPLivTCVCC <- -2.213
max_lnPLivTCVCC <- -0.128

M_lnPKidTCVCC <- 0.65
sd_lnPKidTCVCC <- 0.4
min_lnPKidTCVCC <- -0.16
max_lnPKidTCVCC <- 1.392

M_lnPBodNATC <- -2.274
sd_lnPBodNATC <- 0.874
min_lnPBodNATC <- -4.1
max_lnPBodNATC <- -0.634

M_lnPLivNATC <- -0.465
sd_lnPLivNATC <- 0.437
min_lnPLivNATC <- -1.3
max_lnPLivNATC <- 0.427

M_lnPKidNATC <- -1.6
sd_lnPKidNATC <-  0.445
min_lnPKidNATC <- -2.381
max_lnPKidNATC <- -0.651

# Metabolism parameters (min, max)
M_lnKMC <- -4.26
sd_lnKMC <- 0.42
min_lnKMC <- -5.056 #-15# # Uniform
max_lnKMC <- -3.416 #5#10#5#10

M_lnClC <- 4.24
sd_lnClC <- 0.661
min_lnClC <- 3.021 #-4.827# #-15#-15#
max_lnClC <- 5.764 #4.827#5#15#

# min_lnKM2C <- 0#-15.1 #C&G(2011) #-6.909 -5
# max_lnKM2C <- 15.0#15.1 #6.909 # fixed at 15 to turn off liver in C(2018)

M_lnCl2OxC <- -3.341
sd_lnCl2OxC <- 1.118
min_lnCl2OxC <- -5.88 #-4.827 #-15#
max_lnCl2OxC <- -1.391 #4.827 #5#

M_lnFracOtherC <- -4.454
sd_lnFracOtherC <- 1.531
min_lnFracOtherC <- -6.786 #-6.701#-2#-10
max_lnFracOtherC <- -1.44

M_lnkUrnTCAC <- -2.336
sd_lnkUrnTCAC <- 0.511
min_lnkUrnTCAC <- -3.073#-4.605 #-15 #C(2014)
max_lnkUrnTCAC <- -1.3#4.605 #5#10

#median(runif(1000001, min = -3.109, max = -1.194))

M_lnkMetTCAC <- -0.734
sd_lnkMetTCAC <- 0.388
min_lnkMetTCAC <- -1.282#-9.21 #-15
max_lnkMetTCAC <- 0.094#4.605 #5#10

# min_lnVMaxTCVGC <- 0#-10.203 #C&G(2011) #-1
# max_lnVMaxTCVGC <- 10.2 # fixed at 10.2 C(2018)

# runif(101, min = -13.8, max = 10.203)#, log = T
# median(runif(100001, min = -13.8, max = 10.203))
# sd(runif(100001, min = -13.8, max = 10.203))

#median(runif(1000001, min = -13.8, max = -0))
M_lnClTCVGC <- -10.7
sd_lnClTCVGC <- 0.586
min_lnClTCVGC <- -11.9 #C(2018) #-15
max_lnClTCVGC <- -9.56#10.203 #0 #C(2018) #5#0

# min_lnkTCVCC <- -15.2 #C&G(2011) fixed at -15.2 in C(2018) #-10.203
# max_lnkTCVCC <-  0#10.203 #C&G(2011) #5#10

M_lnkKidTCVCC <- 4.416
sd_lnkKidTCVCC <- 0.543
min_lnkKidTCVCC <- 3.319#-15#
max_lnkKidTCVCC <- 5.475

# min_lnkNATC <- -15.2 # fixed at -15.2 in C(2018)
# max_lnkNATC <- 0#5#10 0#

M_lnkKidNATC <- 3.044
sd_lnkKidNATC <- 0.574
min_lnkKidNATC <- 1.839
max_lnkKidNATC <- 4.163

M_lnkDCAC <- -2.338
sd_lnkDCAC <- 2.68
min_lnkDCAC <-  -6.623#-8.23 #-6.7#
max_lnkDCAC <- 2.6

M_lnkUrnNATC <- 1.774
sd_lnkUrnNATC <- 0.611
min_lnkUrnNATC <- 0.561
max_lnkUrnNATC <- 2.964
