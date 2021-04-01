# PBPK model files for perc in 3 + CC-45 strains of mice
This folder contains following PBPK model files: 
  - Model files:
    - an original model file 'perc.v3.4.model' from Dalaijamts et al. 2018, which was used in MC/MCMC simulations.
    - a modified model file 'perc.v2.strain.48.model' added some parameters for Dose metric predictions.
  - Input files for MC/MCMC simulations of preliminary and final models.
  - Global Sensitivity analysis was run on 'pksensi' version 1.2.0 R package developed by our lab.
  - Evaluation of model fits were run on MCSim v.5.6.5 software on Windows.
  - Dose metric predictions were run on MCSim under R on Windows.

## A workflow describing the steps of modeling processes and their inputs and outputs
