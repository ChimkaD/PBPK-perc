# Files for posterior dose metric prediction

This folder contains R and R Markdown scripts for following analysis of MCMC simulation outputs of PBPK model:
  
  ## Convergence of markov chains of MCMC simulations of posterior parameter distributions for population mean, including:
   - Gelman & Rubin Shrink Factor scores,
   - Traceplots
   - Kernel densities 
   - Correlation matrix 
   - log-likelihood of the chains.
  
  The evaluation of convergence of the MCMC simulations were carried out using the R “coda” package v.0.19-1.
  
  ## R scripts for analysis of parameter prior and posterior distributions of: 
   - Population mean,  
   - Population variability, and
   - Strain-specific parameter posteriors
  
  ## Interpretations of model fitting, including: 
   - Global evaluation of model prediction:
      - Scatterplot of prediction vs. observation - overal
      - Violin of distribution of residual error
      - Scatterplot of prediction vs. observation - each chemical
   - PBPK model prediction of concentration-time course for:
      - Modeling Setpoint of toxicokinetics prediction
        - Combined CC 45 strains using Population-generated random strain parameter posteriori
        - Each of CC 45 strains using Strain-specific parameter posteriori
      - Test results of last iterations of each of 4 chains for Each of CC 45 strains

  ### in vivo data used for calibration and evaluation of model fitting:
   - Toxicokinetic in vivo data from our lab
   - Limits of detection of the chemicals in tissues.


## References
- Plummer M, Best N, Cowles K, Vines K. 2006. Coda: Convergence diagnosis and output analysis for mcmc. R news, 6, 7-11. URL: http://CRAN R-project org/doc/Rnews.
- Gelman A, Carlin JB, Stern HS, Rubin DB. 2004. Bayesian data analysis. New York: Chapman and Hall/CRC.
- Cichocki JA, Furuya S, Venkatratnam A, McDonald TJ, Knap AH, Wade T, Sweet S, Chiu WA, Threadgill DW, Rusyn I. 2017b. Characterization of variability in toxicokinetics and toxicodynamics of tetrachloroethylene using the collaborative cross mouse population. Environ Health Persp. 125(5):057006.
- Luo YS, Cichocki JA, Hsieh NH, Lewis L, Wright FA, Threadgill DW, Chiu WA, Rusyn I. 2019. Using collaborative cross mouse population to fill data gaps in risk assessment: A case study of population-based analysis of toxicokinetics and kidney toxicodynamics of tetrachloroethylene. Environ Health Persp. 127(6).
