# Files for Global Sensitivity Analysis (GSA)

This folder contains following files:
  - R script for:
      - eFAST test functions, 
      - Interpretitions of results and Ranking functions, and
      - Tabulating and visualization of analysis results.
  - Input files for: 
      - Parameter prior and posterior distributions, 
      - MCMC simulations to create parameter posteriors for 3 strains to be used for GSA, and 
      - Setpoint model predicitons of impact of model parameters and their interactions to the range of model outputs.
  - Output files of:
      - Posterior parameter distributions, and 
      - eFAST test results.

Global Sensitivity Analysis was conducted using eFAST test on 'pksensi' version 1.2.0 R package developed by our lab.
'pksensi' package can be installed via CRAN or GitHub:
 - To get pksensi from CRAN:
    install.packages('pksensi')
 - Development version from GitHub:
    remotes::install_github('nanhung/pksensi')

![](https://github.com/nanhung/pksensi/blob/master/man/figures/logo.png)

## Reference
Hsieh NH, Reisfeld B, Chiu WA. pksensi: an R package to apply sensitivity analysis in pharmacokinetic modeling. 58th SOT Annual Meeting, Baltimore, USA, March 10–14, 2019.

