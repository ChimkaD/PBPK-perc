# USEPA Perc Model perc.v1.strain.48
# Integrate(Lsodes, 1e-9, 1e-9, 1)
Integrate(Lsodes, 0.3e-8, 1e-11 , 1)
SetPoints (
"perc.mouse.48strains.43p.random.1.met.set.out",
"perc.mouse.48strains.43p.random1.500.out",
0,
M_lnQCC,
M_lnVPRC,
M_QGutC,
M_QSlwC,
M_VFatC,
M_VRapC,
M_VKidC,
M_lnkTSD,
M_lnkAS,
M_lnkAD,
M_lnkASAq,
M_lnkTSDAq,
M_lnkADAq,
M_PBC,
M_PFatC,
M_lnPLivC,
M_lnPRapC,
M_lnPRespC,
M_lnPKidC,
M_lnPRBCPlasTCAC,
M_lnPKidTCAC,
M_lnPBodTCAC,
M_lnPLivTCAC,
M_lnPLivTCVGC,
M_lnPKidTCVGC,
M_lnPBodTCVCC,
M_lnPLivTCVCC,
M_lnPKidTCVCC,
M_lnPBodNATC,
M_lnPLivNATC,
M_lnPKidNATC,
M_lnkDissocC,
M_lnBMaxkDC,
M_lnKMC,
M_lnClC,
M_lnClTCVGC,
M_lnCl2OxC,
M_lnkUrnTCAC,
M_lnkMetTCAC,
M_lnkKidTCVCC,
M_lnkKidNATC,
M_lnkDCAC,
M_lnkUrnNATC,
V_lnQCC,
V_lnVPRC,
V_QGutC,
V_QSlwC,
V_VFatC,
V_VRapC,
V_VKidC,
V_lnkTSD,
V_lnkAS,
V_lnkAD,
V_lnkASAq,
V_lnkTSDAq,
V_lnkADAq,
V_PBC,
V_PFatC,
V_lnPLivC,
V_lnPRapC,
V_lnPRespC,
V_lnPKidC,
V_lnPRBCPlasTCAC,
V_lnPKidTCAC,
V_lnPBodTCAC,
V_lnPLivTCAC,
V_lnPLivTCVGC,
V_lnPKidTCVGC,
V_lnPBodTCVCC,
V_lnPLivTCVCC,
V_lnPKidTCVCC,
V_lnPBodNATC,
V_lnPLivNATC,
V_lnPKidNATC,
V_lnkDissocC,
V_lnBMaxkDC,
V_lnKMC,
V_lnClC,
V_lnClTCVGC,
V_lnCl2OxC,
V_lnkUrnTCAC,
V_lnkMetTCAC,
V_lnkKidTCVCC,
V_lnkKidNATC,
V_lnkDCAC,
V_lnkUrnNATC
);
## Add any parameters that are fixed at something other than the “default”
lnDRespC  = 	0.83; 		#(v3.1)
FracPlasC =	0.874; 
lnVMaxTCVGC = 10.2;
lnKM2C = 15;
lnkTCVCC = -15.2;	#(v3.1)
lnkNATC = -15.2;	#(v3.1)
lnFracOtherC = -2.197; # Baseline #-4.454;
Distrib(	lnQCC	TruncNormal_v	M_lnQCC	V_lnQCC	-0.183	0.487	); #v2
Distrib(	lnVPRC	TruncNormal_v	 M_lnVPRC	V_lnVPRC	-0.744 0.105	);	#v1
Distrib(	QGutC	TruncNormal_v	 M_QGutC	V_QGutC	0.66	1.34	);
Distrib(	QSlwC	TruncNormal_v	 M_QSlwC	V_QSlwC	0.42	1.58	);
Distrib(	VFatC	TruncNormal_v	M_VFatC	V_VFatC	0.1	1.9	);
Distrib(	VRapC	TruncNormal_v	M_VRapC	V_VRapC	0.8	1.2	); 
Distrib(	VKidC	TruncNormal_v	M_VKidC	V_VKidC	0.8	1.2	); 
Distrib(	lnkTSD	TruncNormal_v	M_lnkTSD	V_lnkTSD	-6.571	7.244	);
Distrib(	lnkAS	TruncNormal_v	M_lnkAS	V_lnkAS	-6.571	7.244	);
Distrib(	lnkAD	TruncNormal_v	M_lnkAD	V_lnkAD	-7.195	6.62	);
Distrib(	lnkASAq	TruncNormal_v	M_lnkASAq	V_lnkASAq	-6.571	7.244	);
Distrib(	lnkTSDAq	TruncNormal_v	M_lnkTSDAq	V_lnkTSDAq	-6.571	7.244	);
Distrib(	lnkADAq	TruncNormal_v	M_lnkADAq	V_lnkADAq	-7.195	6.62	);
Distrib(	PBC	TruncNormal_v	M_PBC	V_PBC	0.25 1.75 ); 
Distrib(	PFatC	TruncNormal_v	M_PFatC	V_PFatC	0.1 1.9 ); 
Distrib(	lnPLivC	TruncNormal_v	M_lnPLivC	V_lnPLivC	-1.2 1.2 ); 
Distrib(	lnPRapC	TruncNormal_v M_lnPRapC V_lnPRapC	-1.2 1.2 ); 	
Distrib(	lnPRespC	TruncNormal_v M_lnPRespC V_lnPRespC	-1.2 1.2 );
Distrib(	lnPKidC	TruncNormal_v	M_lnPKidC	V_lnPKidC	-1.2 1.2 ); 
Distrib(	lnPRBCPlasTCAC	TruncNormal_v	M_lnPRBCPlasTCAC	V_lnPRBCPlasTCAC	-0.605	2.383	); #v1
Distrib(	lnPKidTCAC	TruncNormal_v	M_lnPKidTCAC	V_lnPKidTCAC	-1.2 1.2	); 
Distrib(	lnPBodTCAC	TruncNormal_v	M_lnPBodTCAC	V_lnPBodTCAC	-1.008 1.008	); 
Distrib(	lnPLivTCAC	TruncNormal_v	M_lnPLivTCAC	V_lnPLivTCAC	-1.008 1.008	);
Distrib(	lnPLivTCVGC	TruncNormal_v	M_lnPLivTCVGC	V_lnPLivTCVGC	-5.0 3.0	); 
Distrib(	lnPKidTCVGC	TruncNormal_v	M_lnPKidTCVGC	V_lnPKidTCVGC	-5.0 3.0	); 
Distrib(	lnPBodTCVCC	TruncNormal_v	M_lnPBodTCVCC	V_lnPBodTCVCC	-5.0 3.0	); 
Distrib(	lnPLivTCVCC	TruncNormal_v	M_lnPLivTCVCC	V_lnPLivTCVCC	-5.0 3.0	); 
Distrib(	lnPKidTCVCC	TruncNormal_v	M_lnPKidTCVCC	V_lnPKidTCVCC	-5.0 3.0	); 
Distrib(	lnPBodNATC	TruncNormal_v	M_lnPBodNATC	V_lnPBodNATC	-5.0 3.0	); 
Distrib(	lnPLivNATC	TruncNormal_v	M_lnPLivNATC	V_lnPLivNATC	-5.0 3.0	); 
Distrib(	lnPKidNATC	TruncNormal_v	M_lnPKidNATC	V_lnPKidNATC	-5.0 3.0	); 
Distrib(	lnkDissocC	TruncNormal_v	M_lnkDissocC	V_lnkDissocC	-1.44	2.375	);	#v1
Distrib(	lnBMaxkDC	TruncNormal_v	M_lnBMaxkDC	V_lnBMaxkDC	-0.352 1.2	);				#v1
Distrib(	lnKMC	TruncNormal_v	M_lnKMC	V_lnKMC	-6.909	6.909	);
Distrib(	lnClC	TruncNormal_v	M_lnClC	V_lnClC	-6.909	6.909	);
Distrib(	lnClTCVGC	TruncNormal_v	M_lnClTCVGC	V_lnClTCVGC	-13.8	10.203	);	
Distrib(	lnCl2OxC	TruncNormal_v	M_lnCl2OxC		V_lnCl2OxC	-6.909	6.909	);
Distrib(	lnkUrnTCAC	TruncNormal_v	M_lnkUrnTCAC	V_lnkUrnTCAC	-3.556	-0.663	); #v2
Distrib(	lnkMetTCAC	TruncNormal_v	M_lnkMetTCAC	V_lnkMetTCAC	-1.735	0.4	); #v2
Distrib(	lnkKidTCVCC	TruncNormal_v	M_lnkKidTCVCC	V_lnkKidTCVCC	-6.909	6.909	);
Distrib(	lnkKidNATC	TruncNormal_v	M_lnkKidNATC	V_lnkKidNATC	-6.909	6.909	);
Distrib(	lnkDCAC	TruncNormal_v	M_lnkDCAC	V_lnkDCAC	-6.909	6.909	);				#(v3.1)
Distrib(	lnkUrnNATC	TruncNormal_v	M_lnkUrnNATC	V_lnkUrnNATC	-6.909	6.909	);

Distrib(		BWmeas		Normal	0.023867	0.0038	);
# CC 45 strains, Joe et al. (2017) 
Experiment {	### Strain = CC001/Unc M
Species = 3;
Male = 1.0;
# BWmeas=0.03;
PDoseAq = NDoses(2, 1000, 0, 0, 0.05 );
TChng =  0.05 ;
Print( TotDoseBW34 , 36 );
Data( TotDoseBW34 , -1);
Print( TotTissueBW34 , 36 );
Data( TotTissueBW34 , -1);
Print( TotMetabBW34 , 36 );
Data( TotMetabBW34 , -1);
Print( TotOxMetabBW34 , 36 );
Data( TotOxMetabBW34 , -1);
Print( TotTCAInBW34 , 36);
Data( TotTCAInBW34 , -1);
Print( AMetGSHBW34 , 36 );
Data( AMetGSHBW34 , -1);
Print( AMetLiv2BW34 , 36 );
Data( AMetLiv2BW34 , -1);
Print( AMetKid2BW34 , 36 );
Data( AMetKid2BW34 , -1);
Print( AMetKidTCVCBW34 , 36 );
Data( AMetKidTCVCBW34 , -1);
} # End Strain = CC001/Unc M
End.