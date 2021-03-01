# PBPK-perc in 3 + CC-45 strains of mice
This repository includes available files of PBPK modeling, MC/MCMC simulation and analysis of results of a manuscript titled 'Quantitative Characterization of Population-wide Tissue- and Metabolite-specific Variability in Perchloroethylene Toxicokinetics in Male Mice' submitted to Tox.Sci.

The modeling processes are complex comprised with different steps and components.

Following diagram will help to undertand a whole picture of the current Bayesian population PBPK model.

Stages of the PBPK modeling run on softwares as follow:
  - MCMC simulations of preliminary and final models were run on MCSim v.5.6.5 software on Linux/Unix environment in Terra cluster in the High Performance Research Center, Texas A&M University.
  - Global Sensitivity analysis was run on 'pksensi' version 1.2.0 R package developed by our lab.
  - Evaluation of model fits were run on MCSim v.5.6.5 software on Windows.
  - Dose metric predictions were run on MCSim under R on Windows.

## A workflow describing the steps of modeling processes and their inputs and outputs

![A workflow describing the steps of modeling processes and their inputs and outputs](https://github.com/ChimkaD/PBPK-perc/blob/main/Model%20Files/Figure%201.jpg)


# References
https://www.gnu.org/software/mcsim/

https://github.com/nanhung/MCSim_under_R

Hsieh NH, Reisfeld B, Chiu WA. pksensi: an R package to apply sensitivity analysis in pharmacokinetic modeling. 58th SOT Annual Meeting, Baltimore, USA, March 10–14, 2019.
