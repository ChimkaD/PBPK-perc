## PBPK model files for perc in 3 + CC-45 strains of mice
This folder contains following PBPK modeling files: 
  - Model files - an original model file 'perc.v3.4.model' from Dalaijamts et al. 2018, which was used in MC/MCMC simulations.
  - Input files for MC/MCMC simulations of preliminary and final models: 
    -  Preliminary modeling starts with inputs for MCMC simulation "perc.mouse.48strain.27p.mcmc.1.in x 4 markov chains" were checked adding TK time-course data of 45 strains of CC mice to previous 3 mouse strains.
    -  Preliminary modeling of MCMC simulation using 58 parameter priors and 3 strains to produce posteiors for use of inputs of Global Sensitivity analysis.
    -  Final modeling of MCMC simulation using 43 parameter priors including all 48 strains.
  - Posterior outputs of final MCMC modeling were randomly selected from 2nd half of 100k iterations from each of 4 markov chains and combined outputs were used for PBPK model prediction of TK profiles.
  - PBPK model predictions were performed using 'perc.mouse.48strains.43p.set.in' file from compbined output of posterior parameters and Setpoint modeling in MCSim software.
